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


/** This is an auto generated class representing the Question type in your schema. */
@immutable
class Question {
  final String id;
  final String? _text;
  final QuestionType? _type;
  final List<QuestionOption>? _questionOptions;

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
  
  QuestionType get type {
    try {
      return _type!;
    } catch(e) {
      throw new DataStoreException(
      DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
      recoverySuggestion:
        DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
      underlyingException: e.toString()
    );
    }
  }
  
  List<QuestionOption>? get questionOptions {
    return _questionOptions;
  }
  
  const Question._internal({required this.id, required text, required type, questionOptions}): _text = text, _type = type, _questionOptions = questionOptions;
  
  factory Question({String? id, required String text, required QuestionType type, List<QuestionOption>? questionOptions}) {
    return Question._internal(
      id: id == null ? UUID.getUUID() : id,
      text: text,
      type: type,
      questionOptions: questionOptions != null ? List<QuestionOption>.unmodifiable(questionOptions) : questionOptions);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Question &&
      id == other.id &&
      _text == other._text &&
      _type == other._type &&
      DeepCollectionEquality().equals(_questionOptions, other._questionOptions);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Question {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("text=" + "$_text" + ", ");
    buffer.write("type=" + (_type != null ? enumToString(_type)! : "null") + ", ");
    buffer.write("questionOptions=" + (_questionOptions != null ? _questionOptions!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Question copyWith({String? id, String? text, QuestionType? type, List<QuestionOption>? questionOptions}) {
    return Question._internal(
      id: id ?? this.id,
      text: text ?? this.text,
      type: type ?? this.type,
      questionOptions: questionOptions ?? this.questionOptions);
  }
  
  Question.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _text = json['text'],
      _type = enumFromString<QuestionType>(json['type'], QuestionType.values),
      _questionOptions = json['questionOptions'] is List
        ? (json['questionOptions'] as List)
          .where((e) => e != null)
          .map((e) => QuestionOption.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'text': _text, 'type': enumToString(_type), 'questionOptions': _questionOptions?.map((QuestionOption? e) => e?.toJson()).toList()
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Question";
    modelSchemaDefinition.pluralName = "Questions";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'id',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'text',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'type',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'questionOptions',
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'QuestionOption')
    ));
  });
}