import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';

class StorageRepository {
  Future<String> uploadFile(File file, String? fileName) async {
    try {
      final result = await Amplify.Storage.uploadFile(
        local: file,
        key: fileName ?? DateTime.now().toIso8601String() + '.jpg',
      );
      
      return result.key;
    } catch (e) {
      rethrow;
    }
  }


  Future<String> getUrlForFile(String fileKey) async {
    try {
      final result = await Amplify.Storage.getUrl(key: fileKey);
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