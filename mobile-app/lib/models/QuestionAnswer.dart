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


/** This is an auto generated class representing the QuestionAnswer type in your schema. */
@immutable
class QuestionAnswer {
  final String id;
  final String? _questionID;
  final TemporalDateTime? _date;
  final QuestionType? _type;
  final String? _text;
  final List<QuestionOption>? _questionOptions;
  final List<Marking>? _markings;

  String get questionID {
    try {
      return _questionID!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime get date {
    try {
      return _date!;
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
  
  String? get text {
    return _text;
  }
  
  List<QuestionOption>? get questionOptions {
    return _questionOptions;
  }
  
  List<Marking>? get markings {
    return _markings;
  }
  
  const QuestionAnswer._internal({required this.id, required questionID, required date, required type, text, questionOptions, markings}): _questionID = questionID, _date = date, _type = type, _text = text, _questionOptions = questionOptions, _markings = markings;
  
  factory QuestionAnswer({String? id, required String questionID, required TemporalDateTime date, required QuestionType type, String? text, List<QuestionOption>? questionOptions, List<Marking>? markings}) {
    return QuestionAnswer._internal(
      id: id == null ? UUID.getUUID() : id,
      questionID: questionID,
      date: date,
      type: type,
      text: text,
      questionOptions: questionOptions != null ? List<QuestionOption>.unmodifiable(questionOptions) : questionOptions,
      markings: markings != null ? List<Marking>.unmodifiable(markings) : markings);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuestionAnswer &&
      id == other.id &&
      _questionID == other._questionID &&
      _date == other._date &&
      _type == other._type &&
      _text == other._text &&
      DeepCollectionEquality().equals(_questionOptions, other._questionOptions) &&
      DeepCollectionEquality().equals(_markings, other._markings);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("QuestionAnswer {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("questionID=" + "$_questionID" + ", ");
    buffer.write("date=" + (_date != null ? _date!.format() : "null") + ", ");
    buffer.write("type=" + (_type != null ? enumToString(_type)! : "null") + ", ");
    buffer.write("text=" + "$_text" + ", ");
    buffer.write("questionOptions=" + (_questionOptions != null ? _questionOptions!.toString() : "null") + ", ");
    buffer.write("markings=" + (_markings != null ? _markings!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  QuestionAnswer copyWith({String? id, String? questionID, TemporalDateTime? date, QuestionType? type, String? text, List<QuestionOption>? questionOptions, List<Marking>? markings}) {
    return QuestionAnswer._internal(
      id: id ?? this.id,
      questionID: questionID ?? this.questionID,
      date: date ?? this.date,
      type: type ?? this.type,
      text: text ?? this.text,
      questionOptions: questionOptions ?? this.questionOptions,
      markings: markings ?? this.markings);
  }
  
  QuestionAnswer.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _questionID = json['questionID'],
      _date = json['date'] != null ? TemporalDateTime.fromString(json['date']) : null,
      _type = enumFromString<QuestionType>(json['type'], QuestionType.values),
      _text = json['text'],
      _questionOptions = json['questionOptions'] is List
        ? (json['questionOptions'] as List)
          .where((e) => e != null)
          .map((e) => QuestionOption.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _markings = json['markings'] is List
        ? (json['markings'] as List)
          .where((e) => e != null)
          .map((e) => Marking.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'questionID': _questionID, 'date': _date?.format(), 'type': enumToString(_type), 'text': _text, 'questionOptions': _questionOptions?.map((QuestionOption? e) => e?.toJson()).toList(), 'markings': _markings?.map((Marking? e) => e?.toJson()).toList()
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "QuestionAnswer";
    modelSchemaDefinition.pluralName = "QuestionAnswers";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'id',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'questionID',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'date',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'type',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'text',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'questionOptions',
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'QuestionOption')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'markings',
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embeddedCollection, ofCustomTypeName: 'Marking')
    ));
  });
}