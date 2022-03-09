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


/** This is an auto generated class representing the Intervention type in your schema. */
@immutable
class Intervention extends Model {
  static const classType = const _InterventionModelType();
  final String id;
  final MultiLanguageText? _name;
  final MultiLanguageText? _description;
  final InterventionType? _interventionType;
  final List<InterventionContentRelation>? _contents;
  final List<Survey>? _surveys;
  final List<InterventionTag>? _tags;
  final int? _schemeVersion;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _levelAllowedInterventionsId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  MultiLanguageText get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  MultiLanguageText get description {
    try {
      return _description!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  InterventionType get interventionType {
    try {
      return _interventionType!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<InterventionContentRelation> get contents {
    try {
      return _contents!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Survey> get surveys {
    try {
      return _surveys!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<InterventionTag> get tags {
    try {
      return _tags!;
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
  
  String? get levelAllowedInterventionsId {
    return _levelAllowedInterventionsId;
  }
  
  const Intervention._internal({required this.id, required name, required description, required interventionType, required contents, required surveys, required tags, schemeVersion, createdAt, updatedAt, levelAllowedInterventionsId}): _name = name, _description = description, _interventionType = interventionType, _contents = contents, _surveys = surveys, _tags = tags, _schemeVersion = schemeVersion, _createdAt = createdAt, _updatedAt = updatedAt, _levelAllowedInterventionsId = levelAllowedInterventionsId;
  
  factory Intervention({String? id, required MultiLanguageText name, required MultiLanguageText description, required InterventionType interventionType, required List<InterventionContentRelation> contents, required List<Survey> surveys, required List<InterventionTag> tags, int? schemeVersion, String? levelAllowedInterventionsId}) {
    return Intervention._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      description: description,
      interventionType: interventionType,
      contents: contents != null ? List<InterventionContentRelation>.unmodifiable(contents) : contents,
      surveys: surveys != null ? List<Survey>.unmodifiable(surveys) : surveys,
      tags: tags != null ? List<InterventionTag>.unmodifiable(tags) : tags,
      schemeVersion: schemeVersion,
      levelAllowedInterventionsId: levelAllowedInterventionsId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Intervention &&
      id == other.id &&
      _name == other._name &&
      _description == other._description &&
      _interventionType == other._interventionType &&
      DeepCollectionEquality().equals(_contents, other._contents) &&
      DeepCollectionEquality().equals(_surveys, other._surveys) &&
      DeepCollectionEquality().equals(_tags, other._tags) &&
      _schemeVersion == other._schemeVersion &&
      _levelAllowedInterventionsId == other._levelAllowedInterventionsId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Intervention {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + (_name != null ? _name!.toString() : "null") + ", ");
    buffer.write("description=" + (_description != null ? _description!.toString() : "null") + ", ");
    buffer.write("interventionType=" + (_interventionType != null ? enumToString(_interventionType)! : "null") + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("levelAllowedInterventionsId=" + "$_levelAllowedInterventionsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Intervention copyWith({String? id, MultiLanguageText? name, MultiLanguageText? description, InterventionType? interventionType, List<InterventionContentRelation>? contents, List<Survey>? surveys, List<InterventionTag>? tags, int? schemeVersion, String? levelAllowedInterventionsId}) {
    return Intervention._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      interventionType: interventionType ?? this.interventionType,
      contents: contents ?? this.contents,
      surveys: surveys ?? this.surveys,
      tags: tags ?? this.tags,
      schemeVersion: schemeVersion ?? this.schemeVersion,
      levelAllowedInterventionsId: levelAllowedInterventionsId ?? this.levelAllowedInterventionsId);
  }
  
  Intervention.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name']?['serializedData'] != null
        ? MultiLanguageText.fromJson(new Map<String, dynamic>.from(json['name']['serializedData']))
        : null,
      _description = json['description']?['serializedData'] != null
        ? MultiLanguageText.fromJson(new Map<String, dynamic>.from(json['description']['serializedData']))
        : null,
      _interventionType = enumFromString<InterventionType>(json['interventionType'], InterventionType.values),
      _contents = json['contents'] is List
        ? (json['contents'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => InterventionContentRelation.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _surveys = json['surveys'] is List
        ? (json['surveys'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Survey.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _tags = json['tags'] is List
        ? (json['tags'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => InterventionTag.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _levelAllowedInterventionsId = json['levelAllowedInterventionsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name?.toJson(), 'description': _description?.toJson(), 'interventionType': enumToString(_interventionType), 'contents': _contents?.map((InterventionContentRelation? e) => e?.toJson()).toList(), 'surveys': _surveys?.map((Survey? e) => e?.toJson()).toList(), 'tags': _tags?.map((InterventionTag? e) => e?.toJson()).toList(), 'schemeVersion': _schemeVersion, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'levelAllowedInterventionsId': _levelAllowedInterventionsId
  };

  static final QueryField ID = QueryField(fieldName: "intervention.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField INTERVENTIONTYPE = QueryField(fieldName: "interventionType");
  static final QueryField CONTENTS = QueryField(
    fieldName: "contents",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (InterventionContentRelation).toString()));
  static final QueryField SURVEYS = QueryField(
    fieldName: "surveys",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Survey).toString()));
  static final QueryField TAGS = QueryField(
    fieldName: "tags",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (InterventionTag).toString()));
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static final QueryField LEVELALLOWEDINTERVENTIONSID = QueryField(fieldName: "levelAllowedInterventionsId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Intervention";
    modelSchemaDefinition.pluralName = "Interventions";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'name',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'MultiLanguageText')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'description',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'MultiLanguageText')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Intervention.INTERVENTIONTYPE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Intervention.CONTENTS,
      isRequired: true,
      ofModelName: (InterventionContentRelation).toString(),
      associatedKey: InterventionContentRelation.INTERVENTION
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Intervention.SURVEYS,
      isRequired: true,
      ofModelName: (Survey).toString(),
      associatedKey: Survey.INTERVENTION
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Intervention.TAGS,
      isRequired: true,
      ofModelName: (InterventionTag).toString(),
      associatedKey: InterventionTag.INTERVENTIONTAGSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Intervention.SCHEMEVERSION,
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
      key: Intervention.LEVELALLOWEDINTERVENTIONSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _InterventionModelType extends ModelType<Intervention> {
  const _InterventionModelType();
  
  @override
  Intervention fromJson(Map<String, dynamic> jsonData) {
    return Intervention.fromJson(jsonData);
  }
}