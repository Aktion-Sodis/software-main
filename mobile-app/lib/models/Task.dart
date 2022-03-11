/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Task type in your schema. */
@immutable
class Task extends Model {
  static const classType = const _TaskModelType();
  final String id;
  final String? _title;
  final String? _text;
  final TemporalDateTime? _dueDate;
  final TemporalDateTime? _finishedDate;
  final Location? _location;
  final User? _user;
  final Entity? _entity;
  final AppliedIntervention? _appliedIntervention;
  final ExecutedSurvey? _executedSurvey;
  final int? _schemeVersion;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _taskUserId;
  final String? _taskEntityId;
  final String? _taskAppliedInterventionId;
  final String? _taskExecutedSurveyId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get title {
    try {
      return _title!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get text {
    return _text;
  }
  
  TemporalDateTime? get dueDate {
    return _dueDate;
  }
  
  TemporalDateTime? get finishedDate {
    return _finishedDate;
  }
  
  Location? get location {
    return _location;
  }
  
  User get user {
    try {
      return _user!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Entity? get entity {
    return _entity;
  }
  
  AppliedIntervention? get appliedIntervention {
    return _appliedIntervention;
  }
  
  ExecutedSurvey? get executedSurvey {
    return _executedSurvey;
  }
  
  int? get schemeVersion {
    return _schemeVersion;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String get taskUserId {
    try {
      return _taskUserId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get taskEntityId {
    return _taskEntityId;
  }
  
  String? get taskAppliedInterventionId {
    return _taskAppliedInterventionId;
  }
  
  String? get taskExecutedSurveyId {
    return _taskExecutedSurveyId;
  }
  
  const Task._internal({required this.id, required title, text, dueDate, finishedDate, location, required user, entity, appliedIntervention, executedSurvey, schemeVersion, createdAt, updatedAt, required taskUserId, taskEntityId, taskAppliedInterventionId, taskExecutedSurveyId}): _title = title, _text = text, _dueDate = dueDate, _finishedDate = finishedDate, _location = location, _user = user, _entity = entity, _appliedIntervention = appliedIntervention, _executedSurvey = executedSurvey, _schemeVersion = schemeVersion, _createdAt = createdAt, _updatedAt = updatedAt, _taskUserId = taskUserId, _taskEntityId = taskEntityId, _taskAppliedInterventionId = taskAppliedInterventionId, _taskExecutedSurveyId = taskExecutedSurveyId;
  
  factory Task({String? id, required String title, String? text, TemporalDateTime? dueDate, TemporalDateTime? finishedDate, Location? location, required User user, Entity? entity, AppliedIntervention? appliedIntervention, ExecutedSurvey? executedSurvey, int? schemeVersion, required String taskUserId, String? taskEntityId, String? taskAppliedInterventionId, String? taskExecutedSurveyId}) {
    return Task._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      text: text,
      dueDate: dueDate,
      finishedDate: finishedDate,
      location: location,
      user: user,
      entity: entity,
      appliedIntervention: appliedIntervention,
      executedSurvey: executedSurvey,
      schemeVersion: schemeVersion,
      taskUserId: taskUserId,
      taskEntityId: taskEntityId,
      taskAppliedInterventionId: taskAppliedInterventionId,
      taskExecutedSurveyId: taskExecutedSurveyId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Task &&
      id == other.id &&
      _title == other._title &&
      _text == other._text &&
      _dueDate == other._dueDate &&
      _finishedDate == other._finishedDate &&
      _location == other._location &&
      _user == other._user &&
      _entity == other._entity &&
      _appliedIntervention == other._appliedIntervention &&
      _executedSurvey == other._executedSurvey &&
      _schemeVersion == other._schemeVersion &&
      _taskUserId == other._taskUserId &&
      _taskEntityId == other._taskEntityId &&
      _taskAppliedInterventionId == other._taskAppliedInterventionId &&
      _taskExecutedSurveyId == other._taskExecutedSurveyId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Task {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("text=" + "$_text" + ", ");
    buffer.write("dueDate=" + (_dueDate != null ? _dueDate!.format() : "null") + ", ");
    buffer.write("finishedDate=" + (_finishedDate != null ? _finishedDate!.format() : "null") + ", ");
    buffer.write("location=" + (_location != null ? _location!.toString() : "null") + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("taskUserId=" + "$_taskUserId" + ", ");
    buffer.write("taskEntityId=" + "$_taskEntityId" + ", ");
    buffer.write("taskAppliedInterventionId=" + "$_taskAppliedInterventionId" + ", ");
    buffer.write("taskExecutedSurveyId=" + "$_taskExecutedSurveyId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Task copyWith({String? id, String? title, String? text, TemporalDateTime? dueDate, TemporalDateTime? finishedDate, Location? location, User? user, Entity? entity, AppliedIntervention? appliedIntervention, ExecutedSurvey? executedSurvey, int? schemeVersion, String? taskUserId, String? taskEntityId, String? taskAppliedInterventionId, String? taskExecutedSurveyId}) {
    return Task._internal(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      dueDate: dueDate ?? this.dueDate,
      finishedDate: finishedDate ?? this.finishedDate,
      location: location ?? this.location,
      user: user ?? this.user,
      entity: entity ?? this.entity,
      appliedIntervention: appliedIntervention ?? this.appliedIntervention,
      executedSurvey: executedSurvey ?? this.executedSurvey,
      schemeVersion: schemeVersion ?? this.schemeVersion,
      taskUserId: taskUserId ?? this.taskUserId,
      taskEntityId: taskEntityId ?? this.taskEntityId,
      taskAppliedInterventionId: taskAppliedInterventionId ?? this.taskAppliedInterventionId,
      taskExecutedSurveyId: taskExecutedSurveyId ?? this.taskExecutedSurveyId);
  }
  
  Task.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _text = json['text'],
      _dueDate = json['dueDate'] != null ? TemporalDateTime.fromString(json['dueDate']) : null,
      _finishedDate = json['finishedDate'] != null ? TemporalDateTime.fromString(json['finishedDate']) : null,
      _location = json['location']?['serializedData'] != null
        ? Location.fromJson(new Map<String, dynamic>.from(json['location']['serializedData']))
        : null,
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _entity = json['entity']?['serializedData'] != null
        ? Entity.fromJson(new Map<String, dynamic>.from(json['entity']['serializedData']))
        : null,
      _appliedIntervention = json['appliedIntervention']?['serializedData'] != null
        ? AppliedIntervention.fromJson(new Map<String, dynamic>.from(json['appliedIntervention']['serializedData']))
        : null,
      _executedSurvey = json['executedSurvey']?['serializedData'] != null
        ? ExecutedSurvey.fromJson(new Map<String, dynamic>.from(json['executedSurvey']['serializedData']))
        : null,
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _taskUserId = json['taskUserId'],
      _taskEntityId = json['taskEntityId'],
      _taskAppliedInterventionId = json['taskAppliedInterventionId'],
      _taskExecutedSurveyId = json['taskExecutedSurveyId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'text': _text, 'dueDate': _dueDate?.format(), 'finishedDate': _finishedDate?.format(), 'location': _location?.toJson(), 'user': _user?.toJson(), 'entity': _entity?.toJson(), 'appliedIntervention': _appliedIntervention?.toJson(), 'executedSurvey': _executedSurvey?.toJson(), 'schemeVersion': _schemeVersion, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'taskUserId': _taskUserId, 'taskEntityId': _taskEntityId, 'taskAppliedInterventionId': _taskAppliedInterventionId, 'taskExecutedSurveyId': _taskExecutedSurveyId
  };

  static final QueryField ID = QueryField(fieldName: "task.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField TEXT = QueryField(fieldName: "text");
  static final QueryField DUEDATE = QueryField(fieldName: "dueDate");
  static final QueryField FINISHEDDATE = QueryField(fieldName: "finishedDate");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField ENTITY = QueryField(
    fieldName: "entity",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Entity).toString()));
  static final QueryField APPLIEDINTERVENTION = QueryField(
    fieldName: "appliedIntervention",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (AppliedIntervention).toString()));
  static final QueryField EXECUTEDSURVEY = QueryField(
    fieldName: "executedSurvey",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ExecutedSurvey).toString()));
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static final QueryField TASKUSERID = QueryField(fieldName: "taskUserId");
  static final QueryField TASKENTITYID = QueryField(fieldName: "taskEntityId");
  static final QueryField TASKAPPLIEDINTERVENTIONID = QueryField(fieldName: "taskAppliedInterventionId");
  static final QueryField TASKEXECUTEDSURVEYID = QueryField(fieldName: "taskExecutedSurveyId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Task";
    modelSchemaDefinition.pluralName = "Tasks";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.TITLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.TEXT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.DUEDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.FINISHEDDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'location',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Location')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Task.USER,
      isRequired: true,
      ofModelName: (User).toString(),
      associatedKey: User.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Task.ENTITY,
      isRequired: false,
      ofModelName: (Entity).toString(),
      associatedKey: Entity.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Task.APPLIEDINTERVENTION,
      isRequired: false,
      ofModelName: (AppliedIntervention).toString(),
      associatedKey: AppliedIntervention.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Task.EXECUTEDSURVEY,
      isRequired: false,
      ofModelName: (ExecutedSurvey).toString(),
      associatedKey: ExecutedSurvey.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.SCHEMEVERSION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.TASKUSERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.TASKENTITYID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.TASKAPPLIEDINTERVENTIONID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.TASKEXECUTEDSURVEYID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _TaskModelType extends ModelType<Task> {
  const _TaskModelType();
  
  @override
  Task fromJson(Map<String, dynamic> jsonData) {
    return Task.fromJson(jsonData);
  }
}