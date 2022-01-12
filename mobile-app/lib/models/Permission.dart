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


/** This is an auto generated class representing the Permission type in your schema. */
@immutable
class Permission {
  final PermissionType? _permissionType;
  final List<String>? _allowedEntities;

  PermissionType get permissionType {
    try {
      return _permissionType!;
    } catch(e) {
      throw new DataStoreException(
      DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
      recoverySuggestion:
        DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
      underlyingException: e.toString()
    );
    }
  }
  
  List<String> get allowedEntities {
    try {
      return _allowedEntities!;
    } catch(e) {
      throw new DataStoreException(
      DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
      recoverySuggestion:
        DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
      underlyingException: e.toString()
    );
    }
  }
  
  const Permission._internal({required permissionType, required allowedEntities}): _permissionType = permissionType, _allowedEntities = allowedEntities;
  
  factory Permission({required PermissionType permissionType, required List<String> allowedEntities}) {
    return Permission._internal(
      permissionType: permissionType,
      allowedEntities: allowedEntities != null ? List<String>.unmodifiable(allowedEntities) : allowedEntities);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Permission &&
      _permissionType == other._permissionType &&
      DeepCollectionEquality().equals(_allowedEntities, other._allowedEntities);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Permission {");
    buffer.write("permissionType=" + (_permissionType != null ? enumToString(_permissionType)! : "null") + ", ");
    buffer.write("allowedEntities=" + (_allowedEntities != null ? _allowedEntities!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Permission copyWith({PermissionType? permissionType, List<String>? allowedEntities}) {
    return Permission._internal(
      permissionType: permissionType ?? this.permissionType,
      allowedEntities: allowedEntities ?? this.allowedEntities);
  }
  
  Permission.fromJson(Map<String, dynamic> json)  
    : _permissionType = enumFromString<PermissionType>(json['permissionType'], PermissionType.values),
      _allowedEntities = json['allowedEntities']?.cast<String>();
  
  Map<String, dynamic> toJson() => {
    'permissionType': enumToString(_permissionType), 'allowedEntities': _allowedEntities
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Permission";
    modelSchemaDefinition.pluralName = "Permissions";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'permissionType',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'allowedEntities',
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
  });
}