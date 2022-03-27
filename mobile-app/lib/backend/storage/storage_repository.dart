import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'dataStorePaths.dart';

class StorageRepository {
  static Future<void> downloadFile(File toDownload, String path) async {
    String url = await getUrlForFile(path);

    //Try to download the specified file, and write it to the localCacheFile.
    try {
      await Amplify.Storage.downloadFile(key: url, local: toDownload);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> uploadFile(File file, String dataStorePath) async {
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

  static Future<String> getUrlForFile(String path) async {
    try {
      final result = await Amplify.Storage.getUrl(key: path);
      return result.url;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> removeFile(String path) async {
    try {
      // RemoveOptions options =
      // RemoveOptions(accessLevel: StorageAccessLevel.guest);
      final result = await Amplify.Storage.remove(
        key: await getUrlForFile(path),
        // options: options
      );
      return result.key;
    } catch (e) {
      rethrow;
    }
  }
}
