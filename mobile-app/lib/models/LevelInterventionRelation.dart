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


/** This is an auto generated class representing the LevelInterventionRelation type in your schema. */
@immutable
class LevelInterventionRelation extends Model {
  static const classType = const _LevelInterventionRelationModelType();
  final String id;
  final Level? _level;
  final Intervention? _intervention;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  Level get level {
    try {
      return _level!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Intervention get intervention {
    try {
      return _intervention!;
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
  
  const LevelInterventionRelation._internal({required this.id, required level, required intervention, createdAt, updatedAt}): _level = level, _intervention = intervention, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory LevelInterventionRelation({String? id, required Level level, required Intervention intervention}) {
    return LevelInterventionRelation._internal(
      id: id == null ? UUID.getUUID() : id,
      level: level,
      intervention: intervention);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LevelInterventionRelation &&
      id == other.id &&
      _level == other._level &&
      _intervention == other._intervention;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("LevelInterventionRelation {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("level=" + (_level != null ? _level!.toString() : "null") + ", ");
    buffer.write("intervention=" + (_intervention != null ? _intervention!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  LevelInterventionRelation copyWith({String? id, Level? level, Intervention? intervention}) {
    return LevelInterventionRelation._internal(
      id: id ?? this.id,
      level: level ?? this.level,
      intervention: intervention ?? this.intervention);
  }
  
  LevelInterventionRelation.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _level = json['level']?['serializedData'] != null
        ? Level.fromJson(new Map<String, dynamic>.from(json['level']['serializedData']))
        : null,
      _intervention = json['intervention']?['serializedData'] != null
        ? Intervention.fromJson(new Map<String, dynamic>.from(json['intervention']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'level': _level?.toJson(), 'intervention': _intervention?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "levelInterventionRelation.id");
  static final QueryField LEVEL = QueryField(
    fieldName: "level",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Level).toString()));
  static final QueryField INTERVENTION = QueryField(
    fieldName: "intervention",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Intervention).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LevelInterventionRelation";
    modelSchemaDefinition.pluralName = "LevelInterventionRelations";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: LevelInterventionRelation.LEVEL,
      isRequired: true,
      targetName: "levelID",
      ofModelName: (Level).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: LevelInterventionRelation.INTERVENTION,
      isRequired: true,
      targetName: "interventionID",
      ofModelName: (Intervention).toString()
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

class _LevelInterventionRelationModelType extends ModelType<LevelInterventionRelation> {
  const _LevelInterventionRelationModelType();
  
  @override
  LevelInterventionRelation fromJson(Map<String, dynamic> jsonData) {
    return LevelInterventionRelation.fromJson(jsonData);
  }
}