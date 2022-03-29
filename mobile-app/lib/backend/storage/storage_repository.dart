import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'dataStorePaths.dart';

class StorageRepository {
  static Future<void> downloadFile(File toDownload, String path) async {
    try {
      print("trying to get file: $path");
      await Amplify.Storage.downloadFile(key: path, local: toDownload);
      print("file for $path successfully downloaded");
    } catch (e) {
      print("not found $path");
      print(e.toString());
    }
  }

  static Future<String> uploadFile(File file, String dataStorePath) async {
    try {
      final result = await Amplify.Storage.uploadFile(
        local: file,
        key: dataStorePath,
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
        key: path,
        // options: options
      );
      return result.key;
    } catch (e) {
      rethrow;
    }
  }
}
