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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the SurveySurveyTagRelation type in your schema. */
@immutable
class SurveySurveyTagRelation extends Model {
  static const classType = const _SurveySurveyTagRelationModelType();
  final String id;
  final Survey? _survey;
  final SurveyTag? _surveyTag;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
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
  
  SurveyTag get surveyTag {
    try {
      return _surveyTag!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const SurveySurveyTagRelation._internal({required this.id, required survey, required surveyTag, createdAt, updatedAt}): _survey = survey, _surveyTag = surveyTag, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory SurveySurveyTagRelation({String? id, required Survey survey, required SurveyTag surveyTag}) {
    return SurveySurveyTagRelation._internal(
      id: id == null ? UUID.getUUID() : id,
      survey: survey,
      surveyTag: surveyTag);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SurveySurveyTagRelation &&
      id == other.id &&
      _survey == other._survey &&
      _surveyTag == other._surveyTag;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("SurveySurveyTagRelation {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("survey=" + (_survey != null ? _survey!.toString() : "null") + ", ");
    buffer.write("surveyTag=" + (_surveyTag != null ? _surveyTag!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  SurveySurveyTagRelation copyWith({String? id, Survey? survey, SurveyTag? surveyTag}) {
    return SurveySurveyTagRelation._internal(
      id: id ?? this.id,
      survey: survey ?? this.survey,
      surveyTag: surveyTag ?? this.surveyTag);
  }
  
  SurveySurveyTagRelation.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _survey = json['survey']?['serializedData'] != null
        ? Survey.fromJson(new Map<String, dynamic>.from(json['survey']['serializedData']))
        : null,
      _surveyTag = json['surveyTag']?['serializedData'] != null
        ? SurveyTag.fromJson(new Map<String, dynamic>.from(json['surveyTag']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'survey': _survey?.toJson(), 'surveyTag': _surveyTag?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "surveySurveyTagRelation.id");
  static final QueryField SURVEY = QueryField(
    fieldName: "survey",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Survey).toString()));
  static final QueryField SURVEYTAG = QueryField(
    fieldName: "surveyTag",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (SurveyTag).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "SurveySurveyTagRelation";
    modelSchemaDefinition.pluralName = "SurveySurveyTagRelations";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: SurveySurveyTagRelation.SURVEY,
      isRequired: true,
      targetName: "surveyID",
      ofModelName: (Survey).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: SurveySurveyTagRelation.SURVEYTAG,
      isRequired: true,
      targetName: "surveyTagID",
      ofModelName: (SurveyTag).toString()
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
  });
}

class _SurveySurveyTagRelationModelType extends ModelType<SurveySurveyTagRelation> {
  const _SurveySurveyTagRelationModelType();
  
  @override
  SurveySurveyTagRelation fromJson(Map<String, dynamic> jsonData) {
    return SurveySurveyTagRelation.fromJson(jsonData);
  }
}