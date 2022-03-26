import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'dataStorePaths.dart';


class StorageRepository {
  // Question: Does the singleton implementation make sense? What is the standard Dart design pattern for accessing a repository class?
  StorageRepository._privateConstructor();

  static final StorageRepository _instance = StorageRepository._privateConstructor();

  factory StorageRepository() {
    return _instance;
  }

  Future<void> downloadFile(DataStorePaths dataStorePath, File downloadToFile) async {
    String url = await getUrlForFile(dataStorePath);

    //Try to download the specified file, and write it to the localCacheFile.
    try {
      await Amplify.Storage.downloadFile(key: url, local: downloadToFile);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadFile(File file, DataStorePaths dataStorePath) async {
    try {
      String url = await getUrlForFile(dataStorePath);
      final result = await Amplify.Storage.uploadFile(
        local: file,
        key: url,
      );
      
      return result.key;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getUrlForFile(DataStorePaths dataStorePath) async {
    try {
      final result = await Amplify.Storage.getUrl(key: dataStorePath.name);
      return result.url;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> removeFile(String key) async {
    try {
      // RemoveOptions options =
      // RemoveOptions(accessLevel: StorageAccessLevel.guest);
      final result = await Amplify.Storage.remove(key: key, 
        // options: options
        );
      return result.key;
    } catch (e) {
      rethrow;
    }
  }

}