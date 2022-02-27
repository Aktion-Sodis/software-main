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


/** This is an auto generated class representing the Content type in your schema. */
@immutable
class Content extends Model {
  static const classType = const _ContentModelType();
  final String id;
  final String? _name;
  final String? _description;
  final List<InterventionContentRelation>? _interventions;
  final List<Tag>? _tags;
  final int? _schemeVersion;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

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
  
  List<InterventionContentRelation> get interventions {
    try {
      return _interventions!;
    } catch(e) {
      throw new DataStoreException(
      DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
      recoverySuggestion:
        DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
      underlyingException: e.toString()
    );
    }
  }
  
  List<Tag> get tags {
    try {
      return _tags!;
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
  
  const Content._internal({required this.id, required name, description, required interventions, required tags, schemeVersion, createdAt, updatedAt}): _name = name, _description = description, _interventions = interventions, _tags = tags, _schemeVersion = schemeVersion, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Content({String? id, required String name, String? description, required List<InterventionContentRelation> interventions, required List<Tag> tags, int? schemeVersion}) {
    return Content._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      description: description,
      interventions: interventions != null ? List<InterventionContentRelation>.unmodifiable(interventions) : interventions,
      tags: tags != null ? List<Tag>.unmodifiable(tags) : tags,
      schemeVersion: schemeVersion);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Content &&
      id == other.id &&
      _name == other._name &&
      _description == other._description &&
      DeepCollectionEquality().equals(_interventions, other._interventions) &&
      DeepCollectionEquality().equals(_tags, other._tags) &&
      _schemeVersion == other._schemeVersion;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Content {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Content copyWith({String? id, String? name, String? description, List<InterventionContentRelation>? interventions, List<Tag>? tags, int? schemeVersion}) {
    return Content._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      interventions: interventions ?? this.interventions,
      tags: tags ?? this.tags,
      schemeVersion: schemeVersion ?? this.schemeVersion);
  }
  
  Content.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _description = json['description'],
      _interventions = json['interventions'] is List
        ? (json['interventions'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => InterventionContentRelation.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _tags = json['tags'] is List
        ? (json['tags'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Tag.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'description': _description, 'interventions': _interventions?.map((InterventionContentRelation? e) => e?.toJson()).toList(), 'tags': _tags?.map((Tag? e) => e?.toJson()).toList(), 'schemeVersion': _schemeVersion, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "content.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField INTERVENTIONS = QueryField(
    fieldName: "interventions",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (InterventionContentRelation).toString()));
  static final QueryField TAGS = QueryField(
    fieldName: "tags",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Tag).toString()));
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Content";
    modelSchemaDefinition.pluralName = "Contents";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Content.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Content.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Content.INTERVENTIONS,
      isRequired: true,
      ofModelName: (InterventionContentRelation).toString(),
      associatedKey: InterventionContentRelation.CONTENT
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Content.TAGS,
      isRequired: true,
      ofModelName: (Tag).toString(),
      associatedKey: Tag.CONTENTTAGSID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Content.SCHEMEVERSION,
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

class _ContentModelType extends ModelType<Content> {
  const _ContentModelType();
  
  @override
  Content fromJson(Map<String, dynamic> jsonData) {
    return Content.fromJson(jsonData);
  }
}