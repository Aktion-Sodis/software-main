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


/** This is an auto generated class representing the StoragePaths type in your schema. */
@immutable
class StoragePaths {
  final String? _ownerPic;
  final String? _ownerIcon;

  String? get ownerPic {
    return _ownerPic;
  }
  
  String? get ownerIcon {
    return _ownerIcon;
  }
  
  const StoragePaths._internal({ownerPic, ownerIcon}): _ownerPic = ownerPic, _ownerIcon = ownerIcon;
  
  factory StoragePaths({String? ownerPic, String? ownerIcon}) {
    return StoragePaths._internal(
      ownerPic: ownerPic,
      ownerIcon: ownerIcon);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StoragePaths &&
      _ownerPic == other._ownerPic &&
      _ownerIcon == other._ownerIcon;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("StoragePaths {");
    buffer.write("ownerPic=" + "$_ownerPic" + ", ");
    buffer.write("ownerIcon=" + "$_ownerIcon");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  StoragePaths copyWith({String? ownerPic, String? ownerIcon}) {
    return StoragePaths._internal(
      ownerPic: ownerPic ?? this.ownerPic,
      ownerIcon: ownerIcon ?? this.ownerIcon);
  }
  
  StoragePaths.fromJson(Map<String, dynamic> json)  
    : _ownerPic = json['ownerPic'],
      _ownerIcon = json['ownerIcon'];
  
  Map<String, dynamic> toJson() => {
    'ownerPic': _ownerPic, 'ownerIcon': _ownerIcon
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "StoragePaths";
    modelSchemaDefinition.pluralName = "StoragePaths";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'ownerPic',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'ownerIcon',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}