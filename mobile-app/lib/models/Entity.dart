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


/** This is an auto generated class representing the Entity type in your schema. */
@immutable
class Entity extends Model {
  static const classType = const _EntityModelType();
  final String id;
  final String? _name;
  final String? _description;
  final String? _parentEntityID;
  final Level? _level;
  final Location? _location;
  final List<AppliedCustomData>? _customData;
  final List<AppliedIntervention>? _appliedInterventions;
  final int? _schemeVersion;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _entityLevelId;

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
  
  String? get parentEntityID {
    return _parentEntityID;
  }
  
  Level get level {
    try {
      return _level!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Location? get location {
    return _location;
  }
  
  List<AppliedCustomData> get customData {
    try {
      return _customData!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<AppliedIntervention> get appliedInterventions {
    try {
      return _appliedInterventions!;
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
  
  String get entityLevelId {
    try {
      return _entityLevelId!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const Entity._internal({required this.id, required name, description, parentEntityID, required level, location, required customData, required appliedInterventions, schemeVersion, createdAt, updatedAt, required entityLevelId}): _name = name, _description = description, _parentEntityID = parentEntityID, _level = level, _location = location, _customData = customData, _appliedInterventions = appliedInterventions, _schemeVersion = schemeVersion, _createdAt = createdAt, _updatedAt = updatedAt, _entityLevelId = entityLevelId;
  
  factory Entity({String? id, required String name, String? description, String? parentEntityID, required Level level, Location? location, required List<AppliedCustomData> customData, required List<AppliedIntervention> appliedInterventions, int? schemeVersion, required String entityLevelId}) {
    return Entity._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      description: description,
      parentEntityID: parentEntityID,
      level: level,
      location: location,
      customData: customData != null ? List<AppliedCustomData>.unmodifiable(customData) : customData,
      appliedInterventions: appliedInterventions != null ? List<AppliedIntervention>.unmodifiable(appliedInterventions) : appliedInterventions,
      schemeVersion: schemeVersion,
      entityLevelId: entityLevelId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Entity &&
      id == other.id &&
      _name == other._name &&
      _description == other._description &&
      _parentEntityID == other._parentEntityID &&
      _level == other._level &&
      _location == other._location &&
      DeepCollectionEquality().equals(_customData, other._customData) &&
      DeepCollectionEquality().equals(_appliedInterventions, other._appliedInterventions) &&
      _schemeVersion == other._schemeVersion &&
      _entityLevelId == other._entityLevelId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Entity {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("parentEntityID=" + "$_parentEntityID" + ", ");
    buffer.write("location=" + (_location != null ? _location!.toString() : "null") + ", ");
    buffer.write("customData=" + (_customData != null ? _customData!.toString() : "null") + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("entityLevelId=" + "$_entityLevelId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Entity copyWith({String? id, String? name, String? description, String? parentEntityID, Level? level, Location? location, List<AppliedCustomData>? customData, List<AppliedIntervention>? appliedInterventions, int? schemeVersion, String? entityLevelId}) {
    return Entity._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      parentEntityID: parentEntityID ?? this.parentEntityID,
      level: level ?? this.level,
      location: location ?? this.location,
      customData: customData ?? this.customData,
      appliedInterventions: appliedInterventions ?? this.appliedInterventions,
      schemeVersion: schemeVersion ?? this.schemeVersion,
      entityLevelId: entityLevelId ?? this.entityLevelId);
  }
  
  Entity.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _description = json['description'],
      _parentEntityID = json['parentEntityID'],
      _level = json['level']?['serializedData'] != null
        ? Level.fromJson(new Map<String, dynamic>.from(json['level']['serializedData']))
        : null,
      _location = json['location']?['serializedData'] != null
        ? Location.fromJson(new Map<String, dynamic>.from(json['location']['serializedData']))
        : null,
      _customData = json['customData'] is List
        ? (json['customData'] as List)
          .where((e) => e != null)
          .map((e) => AppliedCustomData.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _appliedInterventions = json['appliedInterventions'] is List
        ? (json['appliedInterventions'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => AppliedIntervention.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _entityLevelId = json['entityLevelId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'description': _description, 'parentEntityID': _parentEntityID, 'level': _level?.toJson(), 'location': _location?.toJson(), 'customData': _customData?.map((AppliedCustomData? e) => e?.toJson()).toList(), 'appliedInterventions': _appliedInterventions?.map((AppliedIntervention? e) => e?.toJson()).toList(), 'schemeVersion': _schemeVersion, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'entityLevelId': _entityLevelId
  };

  static final QueryField ID = QueryField(fieldName: "entity.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField PARENTENTITYID = QueryField(fieldName: "parentEntityID");
  static final QueryField LEVEL = QueryField(
    fieldName: "level",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Level).toString()));
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField CUSTOMDATA = QueryField(fieldName: "customData");
  static final QueryField APPLIEDINTERVENTIONS = QueryField(
    fieldName: "appliedInterventions",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (AppliedIntervention).toString()));
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static final QueryField ENTITYLEVELID = QueryField(fieldName: "entityLevelId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Entity";
    modelSchemaDefinition.pluralName = "Entities";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Entity.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Entity.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Entity.PARENTENTITYID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Entity.LEVEL,
      isRequired: true,
      ofModelName: (Level).toString(),
      associatedKey: Level.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'location',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Location')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'customData',
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'AppliedCustomData')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Entity.APPLIEDINTERVENTIONS,
      isRequired: true,
      ofModelName: (AppliedIntervention).toString(),
      associatedKey: AppliedIntervention.ENTITYAPPLIEDINTERVENTIONSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Entity.SCHEMEVERSION,
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
      key: Entity.ENTITYLEVELID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _EntityModelType extends ModelType<Entity> {
  const _EntityModelType();
  
  @override
  Entity fromJson(Map<String, dynamic> jsonData) {
    return Entity.fromJson(jsonData);
  }
}