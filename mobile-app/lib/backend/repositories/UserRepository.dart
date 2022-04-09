import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/backend/storage/dataStorePaths.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class UserRepository {
  Future<User?> getUserById(String userId) async {
    try {
      final List<amp.User> users = await Amplify.DataStore.query(
        amp.User.classType,
        where: amp.User.ID.eq(userId),
      );
      print("userQuery has REsults: ${users.length}");
      return users.isNotEmpty ? User.fromAmplifyModel(users.first) : null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<amp.User> getAmpUserByID(String userID) async {
    final List<amp.User> users = await Amplify.DataStore.query(
      amp.User.classType,
      where: amp.User.ID.eq(userID),
    );
    return users.first;
  }

  Future createUser(User user) async {
    ///creates a user
    ///ID always has to be set as it should equal the authentication ID
    amp.User newUser = user.toAmplifyModel();
    await Amplify.DataStore.save(newUser);
  }

  Future updateUser(User user) async {
    ///updates an existing User
    ///ID always has to be set

    await Amplify.DataStore.save(user.toAmplifyModel());
  }

  static SyncedFile getUserPicFile(User user) {
    String path = dataStorePath(DataStorePaths.userPicPath, [user.id!]);
    return SyncedFile(path);
  }

  static SyncedFile getUserPicFileByUserID(String id) {
    String path = dataStorePath(DataStorePaths.userPicPath, [id]);
    return SyncedFile(path);
  }
}
