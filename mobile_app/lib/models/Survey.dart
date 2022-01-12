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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Survey type in your schema. */
@immutable
class Survey extends Model {
  static const classType = const _SurveyModelType();
  final String id;
  final String? _name;
  final String? _description;
  final Intervention? _intervention;
  final List<Question>? _questions;
  final int? _schemeVersion;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _interventionSurveysId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new DataStoreException(
      DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
      recoverySuggestion:
        DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
      underlyingException: e.toString()
    );
    }
  }
  
  String? get description {
    return _description;
  }
  
  Intervention? get intervention {
    return _intervention;
  }
  
  List<Question> get questions {
    try {
      return _questions!;
    } catch(e) {
      throw new DataStoreException(
      DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
      recoverySuggestion:
        DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
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
  
  String? get interventionSurveysId {
    return _interventionSurveysId;
  }
  
  const Survey._internal({required this.id, required name, description, intervention, required questions, schemeVersion, createdAt, updatedAt, interventionSurveysId}): _name = name, _description = description, _intervention = intervention, _questions = questions, _schemeVersion = schemeVersion, _createdAt = createdAt, _updatedAt = updatedAt, _interventionSurveysId = interventionSurveysId;
  
  factory Survey({String? id, required String name, String? description, Intervention? intervention, required List<Question> questions, int? schemeVersion, String? interventionSurveysId}) {
    return Survey._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      description: description,
      intervention: intervention,
      questions: questions != null ? List<Question>.unmodifiable(questions) : questions,
      schemeVersion: schemeVersion,
      interventionSurveysId: interventionSurveysId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Survey &&
      id == other.id &&
      _name == other._name &&
      _description == other._description &&
      _intervention == other._intervention &&
      DeepCollectionEquality().equals(_questions, other._questions) &&
      _schemeVersion == other._schemeVersion &&
      _interventionSurveysId == other._interventionSurveysId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Survey {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("intervention=" + (_intervention != null ? _intervention!.toString() : "null") + ", ");
    buffer.write("questions=" + (_questions != null ? _questions!.toString() : "null") + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("interventionSurveysId=" + "$_interventionSurveysId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Survey copyWith({String? id, String? name, String? description, Intervention? intervention, List<Question>? questions, int? schemeVersion, String? interventionSurveysId}) {
    return Survey._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      intervention: intervention ?? this.intervention,
      questions: questions ?? this.questions,
      schemeVersion: schemeVersion ?? this.schemeVersion,
      interventionSurveysId: interventionSurveysId ?? this.interventionSurveysId);
  }
  
  Survey.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _description = json['description'],
      _intervention = json['intervention']?['serializedData'] != null
        ? Intervention.fromJson(new Map<String, dynamic>.from(json['intervention']['serializedData']))
        : null,
      _questions = json['questions'] is List
        ? (json['questions'] as List)
          .where((e) => e != null)
          .map((e) => Question.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _interventionSurveysId = json['interventionSurveysId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'description': _description, 'intervention': _intervention?.toJson(), 'questions': _questions?.map((Question? e) => e?.toJson()).toList(), 'schemeVersion': _schemeVersion, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'interventionSurveysId': _interventionSurveysId
  };

  static final QueryField ID = QueryField(fieldName: "survey.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField INTERVENTION = QueryField(
    fieldName: "intervention",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Intervention).toString()));
  static final QueryField QUESTIONS = QueryField(fieldName: "questions");
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static final QueryField INTERVENTIONSURVEYSID = QueryField(fieldName: "interventionSurveysId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Survey";
    modelSchemaDefinition.pluralName = "Surveys";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Survey.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Survey.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Survey.INTERVENTION,
      isRequired: false,
      targetName: "interventionSurveysId",
      ofModelName: (Intervention).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'questions',
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Question')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Survey.SCHEMEVERSION,
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
      key: Survey.INTERVENTIONSURVEYSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _SurveyModelType extends ModelType<Survey> {
  const _SurveyModelType();
  
  @override
  Survey fromJson(Map<String, dynamic> jsonData) {
    return Survey.fromJson(jsonData);
  }
}