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


/** This is an auto generated class representing the ContentContentTagRelation type in your schema. */
@immutable
class ContentContentTagRelation extends Model {
  static const classType = const _ContentContentTagRelationModelType();
  final String id;
  final Content? _content;
  final ContentTag? _contentTag;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  Content get content {
    try {
      return _content!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  ContentTag get contentTag {
    try {
      return _contentTag!;
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
  
  const ContentContentTagRelation._internal({required this.id, required content, required contentTag, createdAt, updatedAt}): _content = content, _contentTag = contentTag, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ContentContentTagRelation({String? id, required Content content, required ContentTag contentTag}) {
    return ContentContentTagRelation._internal(
      id: id == null ? UUID.getUUID() : id,
      content: content,
      contentTag: contentTag);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContentContentTagRelation &&
      id == other.id &&
      _content == other._content &&
      _contentTag == other._contentTag;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ContentContentTagRelation {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("content=" + (_content != null ? _content!.toString() : "null") + ", ");
    buffer.write("contentTag=" + (_contentTag != null ? _contentTag!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ContentContentTagRelation copyWith({String? id, Content? content, ContentTag? contentTag}) {
    return ContentContentTagRelation._internal(
      id: id ?? this.id,
      content: content ?? this.content,
      contentTag: contentTag ?? this.contentTag);
  }
  
  ContentContentTagRelation.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _content = json['content']?['serializedData'] != null
        ? Content.fromJson(new Map<String, dynamic>.from(json['content']['serializedData']))
        : null,
      _contentTag = json['contentTag']?['serializedData'] != null
        ? ContentTag.fromJson(new Map<String, dynamic>.from(json['contentTag']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'content': _content?.toJson(), 'contentTag': _contentTag?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "contentContentTagRelation.id");
  static final QueryField CONTENT = QueryField(
    fieldName: "content",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Content).toString()));
  static final QueryField CONTENTTAG = QueryField(
    fieldName: "contentTag",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ContentTag).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ContentContentTagRelation";
    modelSchemaDefinition.pluralName = "ContentContentTagRelations";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ContentContentTagRelation.CONTENT,
      isRequired: true,
      targetName: "contentID",
      ofModelName: (Content).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ContentContentTagRelation.CONTENTTAG,
      isRequired: true,
      targetName: "contentTagID",
      ofModelName: (ContentTag).toString()
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

class _ContentContentTagRelationModelType extends ModelType<ContentContentTagRelation> {
  const _ContentContentTagRelationModelType();
  
  @override
  ContentContentTagRelation fromJson(Map<String, dynamic> jsonData) {
    return ContentContentTagRelation.fromJson(jsonData);
  }
}