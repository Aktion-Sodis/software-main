import 'package:mobile_app/backend/callableModels/AppliedIntervention.dart';
import 'package:mobile_app/backend/callableModels/Entity.dart';
import 'package:mobile_app/backend/callableModels/ExecutedSurvey.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';
import 'package:mobile_app/backend/callableModels/User.dart';

class Task {
  String id;
  String? title;
  String? text;
  DateTime? dueDate;
  DateTime? finishedDate;
  Location? location;
  User? user;
  Entity? entity;
  AppliedIntervention? appliedIntervention;
  ExecutedSurvey? executedSurvey;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Task(
      {required this.id,
      this.title,
      this.text,
      this.dueDate,
      this.finishedDate,
      this.location,
      this.user,
      this.entity,
      this.appliedIntervention,
      this.executedSurvey,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});
}
