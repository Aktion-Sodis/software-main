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


/** This is an auto generated class representing the QuestionOption type in your schema. */
@immutable
class QuestionOption {
  final String id;
  final I18nString? _text;
  final List<String>? _followUpQuestionIDs;

  I18nString get text {
    try {
      return _text!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String>? get followUpQuestionIDs {
    return _followUpQuestionIDs;
  }
  
  const QuestionOption._internal({required this.id, required text, followUpQuestionIDs}): _text = text, _followUpQuestionIDs = followUpQuestionIDs;
  
  factory QuestionOption({String? id, required I18nString text, List<String>? followUpQuestionIDs}) {
    return QuestionOption._internal(
      id: id == null ? UUID.getUUID() : id,
      text: text,
      followUpQuestionIDs: followUpQuestionIDs != null ? List<String>.unmodifiable(followUpQuestionIDs) : followUpQuestionIDs);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuestionOption &&
      id == other.id &&
      _text == other._text &&
      DeepCollectionEquality().equals(_followUpQuestionIDs, other._followUpQuestionIDs);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("QuestionOption {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("text=" + (_text != null ? _text!.toString() : "null") + ", ");
    buffer.write("followUpQuestionIDs=" + (_followUpQuestionIDs != null ? _followUpQuestionIDs!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  QuestionOption copyWith({String? id, I18nString? text, List<String>? followUpQuestionIDs}) {
    return QuestionOption._internal(
      id: id ?? this.id,
      text: text ?? this.text,
      followUpQuestionIDs: followUpQuestionIDs ?? this.followUpQuestionIDs);
  }
  
  QuestionOption.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _text = json['text']?['serializedData'] != null
        ? I18nString.fromJson(new Map<String, dynamic>.from(json['text']['serializedData']))
        : null,
      _followUpQuestionIDs = json['followUpQuestionIDs']?.cast<String>();
  
  Map<String, dynamic> toJson() => {
    'id': id, 'text': _text?.toJson(), 'followUpQuestionIDs': _followUpQuestionIDs
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "QuestionOption";
    modelSchemaDefinition.pluralName = "QuestionOptions";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'id',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'text',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'I18nString')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'followUpQuestionIDs',
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
  });
}