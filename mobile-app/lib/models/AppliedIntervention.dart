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


/** This is an auto generated class representing the AppliedIntervention type in your schema. */
@immutable
class AppliedIntervention extends Model {
  static const classType = const _AppliedInterventionModelType();
  final String id;
  final User? _whoDidIt;
  final Intervention? _intervention;
  final Location? _location;
  final List<ExecutedSurvey>? _executedSurveys;
  final int? _schemeVersion;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _entityAppliedInterventionsId;
  final String? _appliedInterventionWhoDidItId;
  final String? _appliedInterventionInterventionId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  User get whoDidIt {
    try {
      return _whoDidIt!;
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
  
  Location? get location {
    return _location;
  }
  
  List<ExecutedSurvey> get executedSurveys {
    try {
      return _executedSurveys!;
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
  
  String? get entityAppliedInterventionsId {
    return _entityAppliedInterventionsId;
  }
  
  String get appliedInterventionWhoDidItId {
    try {
      return _appliedInterventionWhoDidItId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get appliedInterventionInterventionId {
    try {
      return _appliedInterventionInterventionId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const AppliedIntervention._internal({required this.id, required whoDidIt, required intervention, location, required executedSurveys, schemeVersion, createdAt, updatedAt, entityAppliedInterventionsId, required appliedInterventionWhoDidItId, required appliedInterventionInterventionId}): _whoDidIt = whoDidIt, _intervention = intervention, _location = location, _executedSurveys = executedSurveys, _schemeVersion = schemeVersion, _createdAt = createdAt, _updatedAt = updatedAt, _entityAppliedInterventionsId = entityAppliedInterventionsId, _appliedInterventionWhoDidItId = appliedInterventionWhoDidItId, _appliedInterventionInterventionId = appliedInterventionInterventionId;
  
  factory AppliedIntervention({String? id, required User whoDidIt, required Intervention intervention, Location? location, required List<ExecutedSurvey> executedSurveys, int? schemeVersion, String? entityAppliedInterventionsId, required String appliedInterventionWhoDidItId, required String appliedInterventionInterventionId}) {
    return AppliedIntervention._internal(
      id: id == null ? UUID.getUUID() : id,
      whoDidIt: whoDidIt,
      intervention: intervention,
      location: location,
      executedSurveys: executedSurveys != null ? List<ExecutedSurvey>.unmodifiable(executedSurveys) : executedSurveys,
      schemeVersion: schemeVersion,
      entityAppliedInterventionsId: entityAppliedInterventionsId,
      appliedInterventionWhoDidItId: appliedInterventionWhoDidItId,
      appliedInterventionInterventionId: appliedInterventionInterventionId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppliedIntervention &&
      id == other.id &&
      _whoDidIt == other._whoDidIt &&
      _intervention == other._intervention &&
      _location == other._location &&
      DeepCollectionEquality().equals(_executedSurveys, other._executedSurveys) &&
      _schemeVersion == other._schemeVersion &&
      _entityAppliedInterventionsId == other._entityAppliedInterventionsId &&
      _appliedInterventionWhoDidItId == other._appliedInterventionWhoDidItId &&
      _appliedInterventionInterventionId == other._appliedInterventionInterventionId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("AppliedIntervention {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("location=" + (_location != null ? _location!.toString() : "null") + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("entityAppliedInterventionsId=" + "$_entityAppliedInterventionsId" + ", ");
    buffer.write("appliedInterventionWhoDidItId=" + "$_appliedInterventionWhoDidItId" + ", ");
    buffer.write("appliedInterventionInterventionId=" + "$_appliedInterventionInterventionId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  AppliedIntervention copyWith({String? id, User? whoDidIt, Intervention? intervention, Location? location, List<ExecutedSurvey>? executedSurveys, int? schemeVersion, String? entityAppliedInterventionsId, String? appliedInterventionWhoDidItId, String? appliedInterventionInterventionId}) {
    return AppliedIntervention._internal(
      id: id ?? this.id,
      whoDidIt: whoDidIt ?? this.whoDidIt,
      intervention: intervention ?? this.intervention,
      location: location ?? this.location,
      executedSurveys: executedSurveys ?? this.executedSurveys,
      schemeVersion: schemeVersion ?? this.schemeVersion,
      entityAppliedInterventionsId: entityAppliedInterventionsId ?? this.entityAppliedInterventionsId,
      appliedInterventionWhoDidItId: appliedInterventionWhoDidItId ?? this.appliedInterventionWhoDidItId,
      appliedInterventionInterventionId: appliedInterventionInterventionId ?? this.appliedInterventionInterventionId);
  }
  
  AppliedIntervention.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _whoDidIt = json['whoDidIt']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['whoDidIt']['serializedData']))
        : null,
      _intervention = json['intervention']?['serializedData'] != null
        ? Intervention.fromJson(new Map<String, dynamic>.from(json['intervention']['serializedData']))
        : null,
      _location = json['location']?['serializedData'] != null
        ? Location.fromJson(new Map<String, dynamic>.from(json['location']['serializedData']))
        : null,
      _executedSurveys = json['executedSurveys'] is List
        ? (json['executedSurveys'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ExecutedSurvey.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _entityAppliedInterventionsId = json['entityAppliedInterventionsId'],
      _appliedInterventionWhoDidItId = json['appliedInterventionWhoDidItId'],
      _appliedInterventionInterventionId = json['appliedInterventionInterventionId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'whoDidIt': _whoDidIt?.toJson(), 'intervention': _intervention?.toJson(), 'location': _location?.toJson(), 'executedSurveys': _executedSurveys?.map((ExecutedSurvey? e) => e?.toJson()).toList(), 'schemeVersion': _schemeVersion, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'entityAppliedInterventionsId': _entityAppliedInterventionsId, 'appliedInterventionWhoDidItId': _appliedInterventionWhoDidItId, 'appliedInterventionInterventionId': _appliedInterventionInterventionId
  };

  static final QueryField ID = QueryField(fieldName: "appliedIntervention.id");
  static final QueryField WHODIDIT = QueryField(
    fieldName: "whoDidIt",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField INTERVENTION = QueryField(
    fieldName: "intervention",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Intervention).toString()));
  static final QueryField LOCATION = QueryField(fieldName: "location");
  static final QueryField EXECUTEDSURVEYS = QueryField(
    fieldName: "executedSurveys",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ExecutedSurvey).toString()));
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static final QueryField ENTITYAPPLIEDINTERVENTIONSID = QueryField(fieldName: "entityAppliedInterventionsId");
  static final QueryField APPLIEDINTERVENTIONWHODIDITID = QueryField(fieldName: "appliedInterventionWhoDidItId");
  static final QueryField APPLIEDINTERVENTIONINTERVENTIONID = QueryField(fieldName: "appliedInterventionInterventionId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "AppliedIntervention";
    modelSchemaDefinition.pluralName = "AppliedInterventions";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: AppliedIntervention.WHODIDIT,
      isRequired: true,
      ofModelName: (User).toString(),
      associatedKey: User.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: AppliedIntervention.INTERVENTION,
      isRequired: true,
      ofModelName: (Intervention).toString(),
      associatedKey: Intervention.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'location',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'Location')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: AppliedIntervention.EXECUTEDSURVEYS,
      isRequired: true,
      ofModelName: (ExecutedSurvey).toString(),
      associatedKey: ExecutedSurvey.APPLIEDINTERVENTION
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppliedIntervention.SCHEMEVERSION,
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
      key: AppliedIntervention.ENTITYAPPLIEDINTERVENTIONSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppliedIntervention.APPLIEDINTERVENTIONWHODIDITID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AppliedIntervention.APPLIEDINTERVENTIONINTERVENTIONID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _AppliedInterventionModelType extends ModelType<AppliedIntervention> {
  const _AppliedInterventionModelType();
  
  @override
  AppliedIntervention fromJson(Map<String, dynamic> jsonData) {
    return AppliedIntervention.fromJson(jsonData);
  }
}