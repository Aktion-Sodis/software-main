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
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ExecutedSurvey type in your schema. */
@immutable
class ExecutedSurvey extends Model {
  static const classType = const _ExecutedSurveyModelType();
  final String id;
  final AppliedIntervention? _appliedIntervention;
  final Survey? _survey;
  final User? _whoExecutedIt;
  final TemporalDateTime? _date;
  final Location? _location;
  final List<QuestionAnswer>? _answers;
  final int? _schemeVersion;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _executedSurveySurveyId;
  final String? _executedSurveyWhoExecutedItId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  AppliedIntervention get appliedIntervention {
    try {
      return _appliedIntervention!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Survey get survey {
    try {
      return _survey!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  User get whoExecutedIt {
    try {
      return _whoExecutedIt!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime get date {
    try {
      return _date!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Location? get location {
    return _location;
  }
  
  List<QuestionAnswer> get answers {
    try {
      return _answers!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  String get executedSurveySurveyId {
    try {
      return _executedSurveySurveyId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get executedSurveyWhoExecutedItId {
    try {
      return _executedSurveyWhoExecutedItId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const ExecutedSurvey._internal({required this.id, required appliedIntervention, required survey, required whoExecutedIt, required date, location, required answers, schemeVersion, createdAt, updatedAt, required executedSurveySurveyId, required executedSurveyWhoExecutedItId}): _appliedIntervention = appliedIntervention, _survey = survey, _whoExecutedIt = whoExecutedIt, _date = date, _location = location, _answers = answers, _schemeVersion = schemeVersion, _createdAt = createdAt, _updatedAt = updatedAt, _executedSurveySurveyId = executedSurveySurveyId, _executedSurveyWhoExecutedItId = executedSurveyWhoExecutedItId;
  
  factory ExecutedSurvey({String? id, required AppliedIntervention appliedIntervention, required Survey survey, required User whoExecutedIt, required TemporalDateTime date, Location? location, required List<QuestionAnswer> answers, int? schemeVersion, required String executedSurveySurveyId, required String executedSurveyWhoExecutedItId}) {
    return ExecutedSurvey._internal(
      id: id == null ? UUID.getUUID() : id,
      appliedIntervention: appliedIntervention,
      survey: survey,
      whoExecutedIt: whoExecutedIt,
      date: date,
      location: location,
      answers: answers != null ? List<QuestionAnswer>.unmodifiable(answers) : answers,
      schemeVersion: schemeVersion,
      executedSurveySurveyId: executedSurveySurveyId,
      executedSurveyWhoExecutedItId: executedSurveyWhoExecutedItId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExecutedSurvey &&
      id == other.id &&
      _appliedIntervention == other._appliedIntervention &&
      _survey == other._survey &&
      _whoExecutedIt == other._whoExecutedIt &&
      _date == other._date &&
      _location == other._location &&
      DeepCollectionEquality().equals(_answers, other._answers) &&
      _schemeVersion == other._schemeVersion &&
      _executedSurveySurveyId == other._executedSurveySurveyId &&
      _executedSurveyWhoExecutedItId == other._executedSurveyWhoExecutedItId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ExecutedSurvey {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("appliedIntervention=" + (_appliedIntervention != null ? _appliedIntervention!.toString() : "null") + ", ");
    buffer.write("date=" + (_date != null ? _date!.format() : "null") + ", ");
    buffer.write("location=" + (_location != null ? _location!.toString() : "null") + ", ");
    buffer.write("answers=" + (_answers != null ? _answers!.toString() : "null") + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("executedSurveySurveyId=" + "$_executedSurveySurveyId" + ", ");
    buffer.write("executedSurveyWhoExecutedItId=" + "$_executedSurveyWhoExecutedItId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ExecutedSurvey copyWith({String? id, AppliedIntervention? appliedIntervention, Survey? survey, User? whoExecutedIt, TemporalDateTime? date, Location? location, List<QuestionAnswer>? answers, int? schemeVersion, String? executedSurveySurveyId, String? executedSurveyWhoExecutedItId}) {
    return ExecutedSurvey._internal(
      id: id ?? this.id,
      appliedIntervention: appliedIntervention ?? this.appliedIntervention,
      survey: survey ?? this.survey,
      whoExecutedIt: whoExecutedIt ?? this.whoExecutedIt,
      date: date ?? this.date,
      location: location ?? this.location,
      answers: answers ?? this.answers,
      schemeVersion: schemeVersion ?? this.schemeVersion,
      executedSurveySurveyId: executedSurveySurveyId ?? this.executedSurveySurveyId,
      executedSurveyWhoExecutedItId: executedSurveyWhoExecutedItId ?? this.executedSurveyWhoExecutedItId);
  }
  
  ExecutedSurvey.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _appliedIntervention = json['appliedIntervention']?['serializedData'] != null
        ? AppliedIntervention.fromJson(new Map<String, dynamic>.from(json['appliedIntervention']['serializedData']))
        : null,
      _survey = json['survey']?['serializedData'] != null
        ? Survey.fromJson(new Map<String, dynamic>.from(json['survey']['serializedData']))
        : null,
      _whoExecutedIt = json['whoExecutedIt']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['whoExecutedIt']['serializedData']))
        : null,
      _date = json['date'] != null ? TemporalDateTime.fromString(json['date']) : null,
      _location = json['location']?['serializedData'] != null
        ? Location.fromJson(new Map<String, dynamic>.from(json['location']['serializedData']))
        : null,
      _answers = json['answers'] is List
        ? (json['answers'] as List)
          .where((e) => e != null)
          .map((e) => QuestionAnswer.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _executedSurveySurveyId = json['executedSurveySurveyId'],
      _executedSurveyWhoExecutedItId = json['executedSurveyWhoExecutedItId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'appliedIntervention': _appliedIntervention?.toJson(), 'survey': _survey?.toJson(), 'whoExecutedIt': _whoExecutedIt?.toJson(), 'date': _date?.format(), 'location': _location?.toJson(), 'answers': _answers?.map((QuestionAnswer? e) => e?.toJson()).toList(), 'schemeVersion': _schemeVersion, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'executedSurveySurveyId': _executedSurveySurveyId, 'executedSurveyWhoExecutedItId': _executedSurveyWhoExecutedItId
  };

  static final QueryField ID = QueryField(fieldName: "executedSurvey.id");
  static final QueryField APPLIEDINTERVENTION = QueryField(
    fieldName: "appliedIntervention",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (AppliedIntervention).toString()));
  static final QueryField SURVEY = QueryField(
    fieldName: "survey",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Survey).toString()));
  static final QueryField WHOEXECUTEDIT = QueryField(
    fieldName: "whoExecutedIt",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField ANSWERS = QueryField(fieldName: "answers");
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static final QueryField EXECUTEDSURVEYSURVEYID = QueryField(fieldName: "executedSurveySurveyId");
  static final QueryField EXECUTEDSURVEYWHOEXECUTEDITID = QueryField(fieldName: "executedSurveyWhoExecutedItId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ExecutedSurvey";
    modelSchemaDefinition.pluralName = "ExecutedSurveys";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ExecutedSurvey.APPLIEDINTERVENTION,
      isRequired: true,
      targetName: "appliedInterventionExecutedSurveysId",
      ofModelName: (AppliedIntervention).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: ExecutedSurvey.SURVEY,
      isRequired: true,
      ofModelName: (Survey).toString(),
      associatedKey: Survey.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: ExecutedSurvey.WHOEXECUTEDIT,
      isRequired: true,
      ofModelName: (User).toString(),
      associatedKey: User.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ExecutedSurvey.DATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'location',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Location')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'answers',
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'QuestionAnswer')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ExecutedSurvey.SCHEMEVERSION,
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
      key: ExecutedSurvey.EXECUTEDSURVEYSURVEYID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ExecutedSurvey.EXECUTEDSURVEYWHOEXECUTEDITID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _ExecutedSurveyModelType extends ModelType<ExecutedSurvey> {
  const _ExecutedSurveyModelType();
  
  @override
  ExecutedSurvey fromJson(Map<String, dynamic> jsonData) {
    return ExecutedSurvey.fromJson(jsonData);
  }
}