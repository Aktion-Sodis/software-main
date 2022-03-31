import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/backend/Blocs/sync/sync_bloc.dart';
import 'package:mobile_app/backend/Blocs/sync/sync_events.dart';
import 'package:path_provider/path_provider.dart';

import 'dataStorePaths.dart';
import 'storage_repository.dart';

class SyncedFile {
  SyncedFile(this.path);

  String path;

  Future<File?> file() async {
    File localCacheFile = await getCachePath();
    bool cached = await localCacheFile.exists();
    if (!cached) {
      print("file not in cache, loading it");
      await StorageRepository.downloadFile(localCacheFile, path);
    } else {
      print("found in cache: $path");
    }

    cached = await localCacheFile.exists();

    if (!cached) {
      return null;
    }

    return localCacheFile;
  }

  Future<File> getCachePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    List<String> pathParts = path.split("/");
    pathParts.removeAt(pathParts.length - 1);
    String toCreateDir = "";
    for (int i = 0; i < pathParts.length; i++) {
      toCreateDir += pathParts[i];
      if (i != pathParts.length - 1) {
        toCreateDir += "/";
      }
    }
    await Directory(appDocDir.path + "/" + toCreateDir).create(recursive: true);
    File localCacheFile = File('${appDocDir.path}/$path');
    return localCacheFile;
  }

  Future<void> update(String utf8String) async {
    File localCacheFile = await getCachePath();
    await localCacheFile.writeAsString(utf8String);
    await StorageRepository.uploadFile(localCacheFile, path);
  }

  Future<File?> updateAsPic(XFile xfile) async {
    await update(await xfile.readAsString());
    return await getCachePath();
  }

  Future<File?> updateAsAudio(File file) async {
    File localCacheFile = await getCachePath();
    await localCacheFile.writeAsBytes(file.readAsBytesSync());
    await StorageRepository.uploadFile(localCacheFile, path);
    return await getCachePath();
  }

  Future<void> delete() async {
    File localCacheFile = await getCachePath();
    await localCacheFile.delete();
    await StorageRepository.removeFile(path);
  }

  Future<bool> sync(SyncBloc syncBloc) async {
    syncBloc.add(StartLoadingFileEvent());
    File localCacheFile = await getCachePath();
    bool cached = await localCacheFile.exists();
    if (!cached) {
      await StorageRepository.downloadFile(localCacheFile, path);
    } else {
      ListResult listResult = await Amplify.Storage.list(path: path);
      if (listResult.items.isEmpty) {
        StorageRepository.uploadFile(await getCachePath(), path);
      } else {
        DateTime? lastModifiedLocal;
        try {
          lastModifiedLocal = await localCacheFile.lastModified();
        } catch (e) {}
        DateTime? lastModifiedOnline = listResult.items.first.lastModified;
        if (lastModifiedOnline == null) {
          await StorageRepository.uploadFile(localCacheFile, path);
        } else if (lastModifiedLocal == null) {
          await StorageRepository.downloadFile(localCacheFile, path);
        } else if (lastModifiedLocal.isAfter(lastModifiedOnline)) {
          await StorageRepository.uploadFile(localCacheFile, path);
        } else if (lastModifiedLocal.isBefore(lastModifiedOnline)) {
          await StorageRepository.downloadFile(localCacheFile, path);
        }
      }
    }
    syncBloc.add(LoadedFileEvent());
    return true;
  }
}
