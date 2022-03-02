import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';

class UserState {
  final User? user;
  late final File? userPic;

  UserState({this.user, this.userPic});

  UserState copyWith({User? user, File? userPic}) {
    return UserState(user: user ?? this.user, userPic: userPic ?? this.userPic);
  }
}
