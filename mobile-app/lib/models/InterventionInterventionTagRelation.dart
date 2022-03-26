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


/** This is an auto generated class representing the InterventionInterventionTagRelation type in your schema. */
@immutable
class InterventionInterventionTagRelation extends Model {
  static const classType = const _InterventionInterventionTagRelationModelType();
  final String id;
  final Intervention? _intervention;
  final InterventionTag? _interventionTag;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
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
  
  InterventionTag get interventionTag {
    try {
      return _interventionTag!;
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
  
  const InterventionInterventionTagRelation._internal({required this.id, required intervention, required interventionTag, createdAt, updatedAt}): _intervention = intervention, _interventionTag = interventionTag, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory InterventionInterventionTagRelation({String? id, required Intervention intervention, required InterventionTag interventionTag}) {
    return InterventionInterventionTagRelation._internal(
      id: id == null ? UUID.getUUID() : id,
      intervention: intervention,
      interventionTag: interventionTag);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InterventionInterventionTagRelation &&
      id == other.id &&
      _intervention == other._intervention &&
      _interventionTag == other._interventionTag;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("InterventionInterventionTagRelation {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("intervention=" + (_intervention != null ? _intervention!.toString() : "null") + ", ");
    buffer.write("interventionTag=" + (_interventionTag != null ? _interventionTag!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  InterventionInterventionTagRelation copyWith({String? id, Intervention? intervention, InterventionTag? interventionTag}) {
    return InterventionInterventionTagRelation._internal(
      id: id ?? this.id,
      intervention: intervention ?? this.intervention,
      interventionTag: interventionTag ?? this.interventionTag);
  }
  
  InterventionInterventionTagRelation.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _intervention = json['intervention']?['serializedData'] != null
        ? Intervention.fromJson(new Map<String, dynamic>.from(json['intervention']['serializedData']))
        : null,
      _interventionTag = json['interventionTag']?['serializedData'] != null
        ? InterventionTag.fromJson(new Map<String, dynamic>.from(json['interventionTag']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'intervention': _intervention?.toJson(), 'interventionTag': _interventionTag?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "interventionInterventionTagRelation.id");
  static final QueryField INTERVENTION = QueryField(
    fieldName: "intervention",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Intervention).toString()));
  static final QueryField INTERVENTIONTAG = QueryField(
    fieldName: "interventionTag",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (InterventionTag).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "InterventionInterventionTagRelation";
    modelSchemaDefinition.pluralName = "InterventionInterventionTagRelations";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: InterventionInterventionTagRelation.INTERVENTION,
      isRequired: true,
      targetName: "interventionID",
      ofModelName: (Intervention).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: InterventionInterventionTagRelation.INTERVENTIONTAG,
      isRequired: true,
      targetName: "interventionTagID",
      ofModelName: (InterventionTag).toString()
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

class _InterventionInterventionTagRelationModelType extends ModelType<InterventionInterventionTagRelation> {
  const _InterventionInterventionTagRelationModelType();
  
  @override
  InterventionInterventionTagRelation fromJson(Map<String, dynamic> jsonData) {
    return InterventionInterventionTagRelation.fromJson(jsonData);
  }
}