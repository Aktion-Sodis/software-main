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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Tag type in your schema. */
@immutable
class Tag extends Model {
  static const classType = const _TagModelType();
  final String id;
  final String? _text;
  final int? _schemeVersion;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _interventionTagsId;
  final String? _contentTagsId;
  final String? _surveyTagsId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get text {
    try {
      return _text!;
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
  
  String? get interventionTagsId {
    return _interventionTagsId;
  }
  
  String? get contentTagsId {
    return _contentTagsId;
  }
  
  String? get surveyTagsId {
    return _surveyTagsId;
  }
  
  const Tag._internal({required this.id, required text, schemeVersion, createdAt, updatedAt, interventionTagsId, contentTagsId, surveyTagsId}): _text = text, _schemeVersion = schemeVersion, _createdAt = createdAt, _updatedAt = updatedAt, _interventionTagsId = interventionTagsId, _contentTagsId = contentTagsId, _surveyTagsId = surveyTagsId;
  
  factory Tag({String? id, required String text, int? schemeVersion, String? interventionTagsId, String? contentTagsId, String? surveyTagsId}) {
    return Tag._internal(
      id: id == null ? UUID.getUUID() : id,
      text: text,
      schemeVersion: schemeVersion,
      interventionTagsId: interventionTagsId,
      contentTagsId: contentTagsId,
      surveyTagsId: surveyTagsId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Tag &&
      id == other.id &&
      _text == other._text &&
      _schemeVersion == other._schemeVersion &&
      _interventionTagsId == other._interventionTagsId &&
      _contentTagsId == other._contentTagsId &&
      _surveyTagsId == other._surveyTagsId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Tag {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("text=" + "$_text" + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("interventionTagsId=" + "$_interventionTagsId" + ", ");
    buffer.write("contentTagsId=" + "$_contentTagsId" + ", ");
    buffer.write("surveyTagsId=" + "$_surveyTagsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Tag copyWith({String? id, String? text, int? schemeVersion, String? interventionTagsId, String? contentTagsId, String? surveyTagsId}) {
    return Tag._internal(
      id: id ?? this.id,
      text: text ?? this.text,
      schemeVersion: schemeVersion ?? this.schemeVersion,
      interventionTagsId: interventionTagsId ?? this.interventionTagsId,
      contentTagsId: contentTagsId ?? this.contentTagsId,
      surveyTagsId: surveyTagsId ?? this.surveyTagsId);
  }
  
  Tag.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _text = json['text'],
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null,
      _interventionTagsId = json['interventionTagsId'],
      _contentTagsId = json['contentTagsId'],
      _surveyTagsId = json['surveyTagsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'text': _text, 'schemeVersion': _schemeVersion, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'interventionTagsId': _interventionTagsId, 'contentTagsId': _contentTagsId, 'surveyTagsId': _surveyTagsId
  };

  static final QueryField ID = QueryField(fieldName: "tag.id");
  static final QueryField TEXT = QueryField(fieldName: "text");
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static final QueryField INTERVENTIONTAGSID = QueryField(fieldName: "interventionTagsId");
  static final QueryField CONTENTTAGSID = QueryField(fieldName: "contentTagsId");
  static final QueryField SURVEYTAGSID = QueryField(fieldName: "surveyTagsId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Tag";
    modelSchemaDefinition.pluralName = "Tags";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Tag.TEXT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Tag.SCHEMEVERSION,
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
      key: Tag.INTERVENTIONTAGSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Tag.CONTENTTAGSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Tag.SURVEYTAGSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _TagModelType extends ModelType<Tag> {
  const _TagModelType();
  
  @override
  Tag fromJson(Map<String, dynamic> jsonData) {
    return Tag.fromJson(jsonData);
  }
}