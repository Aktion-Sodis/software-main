import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'dataStorePaths.dart';
import 'storage_repository.dart';

// Question: How will this be used? --> 
// TODO: implement readImageFile, readPDFFile, readMP3File, ...
// TODO: implement writeImageFile, writePDFFile, writeMP3File, ...
// write --> save locally --> update cloaud
// test case: View with upload, display, delete
class SynchedFile {
  DataStorePaths dataStorePath;
  StorageRepository storageRepository = StorageRepository();

  // Question: What should be returned? Local File? Binary? Image?
  Future<File> get cachedFile async {
    File localCacheFile = await getCache();
    bool cached = await localCacheFile.exists();
    if (!cached){
      storageRepository.downloadFile(dataStorePath, localCacheFile);
    }

    cached = await localCacheFile.exists();

    if (!cached){
      throw Exception('Failed to cache file ${dataStorePath.name}');
    }
    
    return localCacheFile;
  }

  SynchedFile(this.dataStorePath);

  Future<File> getCache() async {
    String url = await storageRepository.getUrlForFile(dataStorePath);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File localCacheFile = File('${appDocDir.path}/$url');
    return localCacheFile;
  }

  // Question: Where does this file come from? What is actually passed to this method? Binary? Image object?
  Future<void> update(File newFile) async {
    File localCacheFile = await getCache();
    newFile.copySync(localCacheFile.path); 
    await storageRepository.uploadFile(newFile, dataStorePath);
  }

  // Question: 
  Future<void> deleteLocal(File newFile) async {
    File localCacheFile = await getCache();
    await localCacheFile.delete();
  }

  // Question: 
  Future<void> deleteCloud(File newFile) async {
    File localCacheFile = await getCache();
    await localCacheFile.delete();
  }
}
