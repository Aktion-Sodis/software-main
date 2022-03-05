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


/** This is an auto generated class representing the ContentTag type in your schema. */
@immutable
class ContentTag extends Model {
  static const classType = const _ContentTagModelType();
  final String id;
  final String? _text;
  final int? _schemeVersion;
  final String? _contentTagsId;

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
  
  String? get contentTagsId {
    return _contentTagsId;
  }
  
  const ContentTag._internal({required this.id, required text, schemeVersion, contentTagsId}): _text = text, _schemeVersion = schemeVersion, _contentTagsId = contentTagsId;
  
  factory ContentTag({String? id, required String text, int? schemeVersion, String? contentTagsId}) {
    return ContentTag._internal(
      id: id == null ? UUID.getUUID() : id,
      text: text,
      schemeVersion: schemeVersion,
      contentTagsId: contentTagsId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContentTag &&
      id == other.id &&
      _text == other._text &&
      _schemeVersion == other._schemeVersion &&
      _contentTagsId == other._contentTagsId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ContentTag {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("text=" + "$_text" + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("contentTagsId=" + "$_contentTagsId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ContentTag copyWith({String? id, String? text, int? schemeVersion, String? contentTagsId}) {
    return ContentTag(
      id: id ?? this.id,
      text: text ?? this.text,
      schemeVersion: schemeVersion ?? this.schemeVersion,
      contentTagsId: contentTagsId ?? this.contentTagsId);
  }
  
  ContentTag.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _text = json['text'],
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _contentTagsId = json['contentTagsId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'text': _text, 'schemeVersion': _schemeVersion, 'contentTagsId': _contentTagsId
  };

  static final QueryField ID = QueryField(fieldName: "contentTag.id");
  static final QueryField TEXT = QueryField(fieldName: "text");
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static final QueryField CONTENTTAGSID = QueryField(fieldName: "contentTagsId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ContentTag";
    modelSchemaDefinition.pluralName = "ContentTags";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ContentTag.TEXT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ContentTag.SCHEMEVERSION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ContentTag.CONTENTTAGSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _ContentTagModelType extends ModelType<ContentTag> {
  const _ContentTagModelType();
  
  @override
  ContentTag fromJson(Map<String, dynamic> jsonData) {
    return ContentTag.fromJson(jsonData);
  }
}