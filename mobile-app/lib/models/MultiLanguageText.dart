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

import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the MultiLanguageText type in your schema. */
@immutable
class MultiLanguageText {
  final List<String>? _languageKeys;
  final List<String>? _languageTexts;

  List<String> get languageKeys {
    try {
      return _languageKeys!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String> get languageTexts {
    try {
      return _languageTexts!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  const MultiLanguageText._internal({required languageKeys, required languageTexts}): _languageKeys = languageKeys, _languageTexts = languageTexts;
  
  factory MultiLanguageText({required List<String> languageKeys, required List<String> languageTexts}) {
    return MultiLanguageText._internal(
      languageKeys: languageKeys != null ? List<String>.unmodifiable(languageKeys) : languageKeys,
      languageTexts: languageTexts != null ? List<String>.unmodifiable(languageTexts) : languageTexts);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MultiLanguageText &&
      DeepCollectionEquality().equals(_languageKeys, other._languageKeys) &&
      DeepCollectionEquality().equals(_languageTexts, other._languageTexts);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MultiLanguageText {");
    buffer.write("languageKeys=" + (_languageKeys != null ? _languageKeys!.toString() : "null") + ", ");
    buffer.write("languageTexts=" + (_languageTexts != null ? _languageTexts!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MultiLanguageText copyWith({List<String>? languageKeys, List<String>? languageTexts}) {
    return MultiLanguageText._internal(
      languageKeys: languageKeys ?? this.languageKeys,
      languageTexts: languageTexts ?? this.languageTexts);
  }
  
  MultiLanguageText.fromJson(Map<String, dynamic> json)  
    : _languageKeys = json['languageKeys']?.cast<String>(),
      _languageTexts = json['languageTexts']?.cast<String>();
  
  Map<String, dynamic> toJson() => {
    'languageKeys': _languageKeys, 'languageTexts': _languageTexts
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MultiLanguageText";
    modelSchemaDefinition.pluralName = "MultiLanguageTexts";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'languageKeys',
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'languageTexts',
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
  });
}