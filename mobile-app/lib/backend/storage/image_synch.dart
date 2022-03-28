import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
      StorageRepository.downloadFile(localCacheFile, path);
    }

    cached = await localCacheFile.exists();

    if (!cached) {
      return null;
    }

    return localCacheFile;
  }

  Future<File> getCachePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
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
    await update(await file.readAsString());
    return await getCachePath();
  }

  Future<void> deleteLocal() async {
    File localCacheFile = await getCachePath();
    await localCacheFile.delete();
    await StorageRepository.removeFile(path);
  }
}
