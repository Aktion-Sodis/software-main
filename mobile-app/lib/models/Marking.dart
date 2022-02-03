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


/** This is an auto generated class representing the Marking type in your schema. */
@immutable
class Marking {
  final double? _x;
  final double? _y;
  final double? _rx;
  final double? _ry;
  final String? _text;

  double get x {
    try {
      return _x!;
    } catch(e) {
      throw new DataStoreException(
      DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
      recoverySuggestion:
        DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
      underlyingException: e.toString()
    );
    }
  }
  
  double get y {
    try {
      return _y!;
    } catch(e) {
      throw new DataStoreException(
      DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
      recoverySuggestion:
        DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
      underlyingException: e.toString()
    );
    }
  }
  
  double get rx {
    try {
      return _rx!;
    } catch(e) {
      throw new DataStoreException(
      DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
      recoverySuggestion:
        DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
      underlyingException: e.toString()
    );
    }
  }
  
  double get ry {
    try {
      return _ry!;
    } catch(e) {
      throw new DataStoreException(
      DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
      recoverySuggestion:
        DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
      underlyingException: e.toString()
    );
    }
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
  
  const Marking._internal({required x, required y, required rx, required ry, required text}): _x = x, _y = y, _rx = rx, _ry = ry, _text = text;
  
  factory Marking({required double x, required double y, required double rx, required double ry, required String text}) {
    return Marking._internal(
      x: x,
      y: y,
      rx: rx,
      ry: ry,
      text: text);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Marking &&
      _x == other._x &&
      _y == other._y &&
      _rx == other._rx &&
      _ry == other._ry &&
      _text == other._text;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Marking {");
    buffer.write("x=" + (_x != null ? _x!.toString() : "null") + ", ");
    buffer.write("y=" + (_y != null ? _y!.toString() : "null") + ", ");
    buffer.write("rx=" + (_rx != null ? _rx!.toString() : "null") + ", ");
    buffer.write("ry=" + (_ry != null ? _ry!.toString() : "null") + ", ");
    buffer.write("text=" + "$_text");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Marking copyWith({double? x, double? y, double? rx, double? ry, String? text}) {
    return Marking._internal(
      x: x ?? this.x,
      y: y ?? this.y,
      rx: rx ?? this.rx,
      ry: ry ?? this.ry,
      text: text ?? this.text);
  }
  
  Marking.fromJson(Map<String, dynamic> json)  
    : _x = (json['x'] as num?)?.toDouble(),
      _y = (json['y'] as num?)?.toDouble(),
      _rx = (json['rx'] as num?)?.toDouble(),
      _ry = (json['ry'] as num?)?.toDouble(),
      _text = json['text'];
  
  Map<String, dynamic> toJson() => {
    'x': _x, 'y': _y, 'rx': _rx, 'ry': _ry, 'text': _text
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Marking";
    modelSchemaDefinition.pluralName = "Markings";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'x',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'y',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'rx',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'ry',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'text',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}