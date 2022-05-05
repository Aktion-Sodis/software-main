import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';

class UserState {
  final User? user;

  UserState({this.user});

  UserState copyWith({User? user, File? userPic}) {
    return UserState(user: user ?? this.user);
  }
}
