import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/backend/callableModels/User.dart';

abstract class UserEvent {}

class CreateUserEvent extends UserEvent {
  final User user;

  CreateUserEvent(this.user);
}

class UpdateUserEvent extends UserEvent {
  final User user;

  UpdateUserEvent(this.user);
}

class InitializeUserEvent extends UserEvent {
  final User? user;

  InitializeUserEvent(this.user);
}

class LogOutUserEvent extends UserEvent {
  LogOutUserEvent();
}
