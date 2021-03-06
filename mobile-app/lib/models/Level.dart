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


/** This is an auto generated class representing the Level type in your schema. */
@immutable
class Level extends Model {
  static const classType = const _LevelModelType();
  final String id;
  final I18nString? _name;
  final I18nString? _description;
  final String? _parentLevelID;
  final bool? _interventionsAreAllowed;
  final List<LevelInterventionRelation>? _allowedInterventions;
  final List<CustomData>? _customData;
  final int? _schemeVersion;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  I18nString get name {
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
  
  I18nString get description {
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
  
  String? get parentLevelID {
    return _parentLevelID;
  }
  
  bool get interventionsAreAllowed {
    try {
      return _interventionsAreAllowed!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<LevelInterventionRelation>? get allowedInterventions {
    return _allowedInterventions;
  }
  
  List<CustomData> get customData {
    try {
      return _customData!;
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
  
  const Level._internal({required this.id, required name, required description, parentLevelID, required interventionsAreAllowed, allowedInterventions, required customData, schemeVersion, createdAt, updatedAt}): _name = name, _description = description, _parentLevelID = parentLevelID, _interventionsAreAllowed = interventionsAreAllowed, _allowedInterventions = allowedInterventions, _customData = customData, _schemeVersion = schemeVersion, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Level({String? id, required I18nString name, required I18nString description, String? parentLevelID, required bool interventionsAreAllowed, List<LevelInterventionRelation>? allowedInterventions, required List<CustomData> customData, int? schemeVersion}) {
    return Level._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      description: description,
      parentLevelID: parentLevelID,
      interventionsAreAllowed: interventionsAreAllowed,
      allowedInterventions: allowedInterventions != null ? List<LevelInterventionRelation>.unmodifiable(allowedInterventions) : allowedInterventions,
      customData: customData != null ? List<CustomData>.unmodifiable(customData) : customData,
      schemeVersion: schemeVersion);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Level &&
      id == other.id &&
      _name == other._name &&
      _description == other._description &&
      _parentLevelID == other._parentLevelID &&
      _interventionsAreAllowed == other._interventionsAreAllowed &&
      DeepCollectionEquality().equals(_allowedInterventions, other._allowedInterventions) &&
      DeepCollectionEquality().equals(_customData, other._customData) &&
      _schemeVersion == other._schemeVersion;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Level {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + (_name != null ? _name!.toString() : "null") + ", ");
    buffer.write("description=" + (_description != null ? _description!.toString() : "null") + ", ");
    buffer.write("parentLevelID=" + "$_parentLevelID" + ", ");
    buffer.write("interventionsAreAllowed=" + (_interventionsAreAllowed != null ? _interventionsAreAllowed!.toString() : "null") + ", ");
    buffer.write("customData=" + (_customData != null ? _customData!.toString() : "null") + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Level copyWith({String? id, I18nString? name, I18nString? description, String? parentLevelID, bool? interventionsAreAllowed, List<LevelInterventionRelation>? allowedInterventions, List<CustomData>? customData, int? schemeVersion}) {
    return Level._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      parentLevelID: parentLevelID ?? this.parentLevelID,
      interventionsAreAllowed: interventionsAreAllowed ?? this.interventionsAreAllowed,
      allowedInterventions: allowedInterventions ?? this.allowedInterventions,
      customData: customData ?? this.customData,
      schemeVersion: schemeVersion ?? this.schemeVersion);
  }
  
  Level.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name']?['serializedData'] != null
        ? I18nString.fromJson(new Map<String, dynamic>.from(json['name']['serializedData']))
        : null,
      _description = json['description']?['serializedData'] != null
        ? I18nString.fromJson(new Map<String, dynamic>.from(json['description']['serializedData']))
        : null,
      _parentLevelID = json['parentLevelID'],
      _interventionsAreAllowed = json['interventionsAreAllowed'],
      _allowedInterventions = json['allowedInterventions'] is List
        ? (json['allowedInterventions'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => LevelInterventionRelation.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _customData = json['customData'] is List
        ? (json['customData'] as List)
          .where((e) => e != null)
          .map((e) => CustomData.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name?.toJson(), 'description': _description?.toJson(), 'parentLevelID': _parentLevelID, 'interventionsAreAllowed': _interventionsAreAllowed, 'allowedInterventions': _allowedInterventions?.map((LevelInterventionRelation? e) => e?.toJson()).toList(), 'customData': _customData?.map((CustomData? e) => e?.toJson()).toList(), 'schemeVersion': _schemeVersion, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "level.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField PARENTLEVELID = QueryField(fieldName: "parentLevelID");
  static final QueryField INTERVENTIONSAREALLOWED = QueryField(fieldName: "interventionsAreAllowed");
  static final QueryField ALLOWEDINTERVENTIONS = QueryField(
    fieldName: "allowedInterventions",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (LevelInterventionRelation).toString()));
  static final QueryField CUSTOMDATA = QueryField(fieldName: "customData");
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Level";
    modelSchemaDefinition.pluralName = "Levels";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'name',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'I18nString')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'description',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'I18nString')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Level.PARENTLEVELID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Level.INTERVENTIONSAREALLOWED,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Level.ALLOWEDINTERVENTIONS,
      isRequired: true,
      ofModelName: (LevelInterventionRelation).toString(),
      associatedKey: LevelInterventionRelation.LEVEL
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'customData',
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'CustomData')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Level.SCHEMEVERSION,
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
  });
}

class _LevelModelType extends ModelType<Level> {
  const _LevelModelType();
  
  @override
  Level fromJson(Map<String, dynamic> jsonData) {
    return Level.fromJson(jsonData);
  }
}