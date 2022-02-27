import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:mobile_app/backend/callableModels/AppliedIntervention.dart';
import 'package:mobile_app/backend/callableModels/Entity.dart';
import 'package:mobile_app/backend/callableModels/ExecutedSurvey.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';
import 'package:mobile_app/backend/callableModels/User.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Task {
  String? id;
  late String title;
  String? text;
  DateTime? dueDate;
  DateTime? finishedDate;
  Location? location;
  late User user;
  Entity? entity;
  AppliedIntervention? appliedIntervention;
  ExecutedSurvey? executedSurvey;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Task(
      {this.id,
      required this.title,
      this.text,
      this.dueDate,
      this.finishedDate,
      this.location,
      required this.user,
      this.entity,
      this.appliedIntervention,
      this.executedSurvey,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  Task.fromAmplifyModel(amp.Task task) {
    id = task.id;
    title = task.title;
    text = task.text;
    dueDate = task.dueDate?.getDateTimeInUtc();
    finishedDate = task.finishedDate?.getDateTimeInUtc();
    location = task.location != null
        ? Location.fromAmplifyModel(task.location!)
        : null;
    user = User.fromAmplifyModel(task.user);
    entity = task.entity != null ? Entity.fromAmplifyModel(task.entity!) : null;
    appliedIntervention = task.appliedIntervention != null
        ? AppliedIntervention.fromAmplifyModel(task.appliedIntervention!)
        : null;
    executedSurvey = task.executedSurvey != null
        ? ExecutedSurvey.fromAmplifyModel(task.executedSurvey!)
        : null;
    schemeVersion = task.schemeVersion;
    createdAt = task.createdAt?.getDateTimeInUtc();
    updatedAt = task.updatedAt?.getDateTimeInUtc();
  }

  amp.Task toAmplifyModel() {
    return amp.Task(
        id: id,
        title: title,
        text: text,
        dueDate: dueDate != null ? TemporalDateTime(dueDate!) : null,
        finishedDate:
            finishedDate != null ? TemporalDateTime(finishedDate!) : null,
        location: location?.toAmplifyModel(),
        user: user.toAmplifyModel(),
        entity: entity?.toAmplifyModel(),
        appliedIntervention: appliedIntervention?.toAmplifyModel(),
        executedSurvey: executedSurvey?.toAmplifyModel(),
        schemeVersion: 0,
        taskUserId: user.id!,
        taskAppliedInterventionId: appliedIntervention?.id!,
        taskExecutedSurveyId: executedSurvey?.id!,
        taskEntityId: entity?.id!);
  }
}
