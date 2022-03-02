import 'dart:io';

import 'package:flutter/material.dart';
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
      return users.isNotEmpty ? User.fromAmplifyModel(users.first) : null;
    } catch (e) {
      rethrow;
    }
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

  Future updateUserPic(File file, String userID) async {
    ///returns local asset path and saves pic to cloud storage
    //todo: implement
    return "test";
  }

  Future<File?> getUserPic(String userID) async {
    ///returns user Pic as asset
    ///returns File or memory
    //todo: implement
    return null;
  }
}
