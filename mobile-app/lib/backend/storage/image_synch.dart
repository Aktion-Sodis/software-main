import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/backend/Blocs/sync/sync_bloc.dart';
import 'package:mobile_app/backend/Blocs/sync/sync_events.dart';
import 'package:path_provider/path_provider.dart';

import 'dataStorePaths.dart';
import 'storage_repository.dart';

class SyncedFile {
  SyncedFile(this.path) {
    key = ValueKey(DateTime.now().toIso8601String());
  }

  String path;

  late Key key;

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
    key = ValueKey(DateTime.now().toIso8601String());
    print("returning file: $key");
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
    key = ValueKey(DateTime.now().toIso8601String());
    print("returning cache path: $key");
    return localCacheFile;
  }

  Future<void> update(String utf8String) async {
    File localCacheFile = await getCachePath();
    await localCacheFile.writeAsString(utf8String, flush: true);
    StorageRepository.uploadFile(localCacheFile, path);
    key = ValueKey(DateTime.now().toIso8601String());
  }

  Future<File?> updateAsBytes(File file) async {
    var bytes = await file.readAsBytes();
    File localCacheFile = await getCachePath();
    await localCacheFile.writeAsBytes(bytes, flush: true);
    key = ValueKey(DateTime.now().toIso8601String());
    StorageRepository.uploadFile(localCacheFile, path);
    print("pic update finished: $key");
    return await getCachePath();
  }

  Future<File?> updateAsPic(XFile xfile) async {
    var bytes = await xfile.readAsBytes();
    File localCacheFile = await getCachePath();
    await localCacheFile.writeAsBytes(bytes, flush: true);
    key = ValueKey(DateTime.now().toIso8601String());
    print("pic update finished: $key");
    StorageRepository.uploadFile(localCacheFile, path);
    return await getCachePath();
  }

  Future<File?> updateAsAudio(File file) async {
    File localCacheFile = await getCachePath();
    await localCacheFile.writeAsBytes(file.readAsBytesSync(), flush: true);
    await StorageRepository.uploadFile(localCacheFile, path);
    key = ValueKey(DateTime.now().toIso8601String());
    return await getCachePath();
  }

  Future<void> delete() async {
    File localCacheFile = await getCachePath();
    await localCacheFile.delete();
    await StorageRepository.removeFile(path);
    key = ValueKey(DateTime.now().toIso8601String());
  }

  Future<bool> sync(SyncBloc syncBloc) async {
    try {
      syncBloc.add(StartLoadingFileEvent());
      File localCacheFile = await getCachePath();
      bool cached = await localCacheFile.exists();
      if (!cached) {
        await StorageRepository.downloadFile(localCacheFile, path,
            checkConnection: false);
      } else {
        ListResult listResult = await Amplify.Storage.list(path: path);
        if (listResult.items.isEmpty) {
          StorageRepository.uploadFile(await getCachePath(), path,
              checkConnection: false);
        } else {
          DateTime? lastModifiedLocal;
          try {
            lastModifiedLocal = await localCacheFile.lastModified();
          } catch (e) {}
          DateTime? lastModifiedOnline = listResult.items.first.lastModified;
          if (lastModifiedOnline == null) {
            await StorageRepository.uploadFile(localCacheFile, path,
                checkConnection: false);
          } else if (lastModifiedLocal == null) {
            await StorageRepository.downloadFile(localCacheFile, path,
                checkConnection: false);
          } else if (lastModifiedLocal.isAfter(lastModifiedOnline)) {
            await StorageRepository.uploadFile(localCacheFile, path,
                checkConnection: false);
          } else if (lastModifiedLocal.isBefore(lastModifiedOnline)) {
            await StorageRepository.downloadFile(localCacheFile, path,
                checkConnection: false);
          }
        }
      }
      syncBloc.add(LoadedFileEvent());
      return true;
    } catch (e) {
      return false;
    }
  }
}
