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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Config type in your schema. */
@immutable
class Config extends Model {
  static const classType = const _ConfigModelType();
  final String id;
  final String? _name;
  final ColorTheme? _colorTheme;
  final StoragePaths? _storagePaths;
  final int? _schemeVersion;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new DataStoreException(
          DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  ColorTheme? get colorTheme {
    return _colorTheme;
  }
  
  StoragePaths get storagePaths {
    try {
      return _storagePaths!;
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
  
  const Config._internal({required this.id, required name, colorTheme, required storagePaths, schemeVersion, createdAt, updatedAt}): _name = name, _colorTheme = colorTheme, _storagePaths = storagePaths, _schemeVersion = schemeVersion, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Config({String? id, required String name, ColorTheme? colorTheme, required StoragePaths storagePaths, int? schemeVersion}) {
    return Config._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      colorTheme: colorTheme,
      storagePaths: storagePaths,
      schemeVersion: schemeVersion);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Config &&
      id == other.id &&
      _name == other._name &&
      _colorTheme == other._colorTheme &&
      _storagePaths == other._storagePaths &&
      _schemeVersion == other._schemeVersion;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Config {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("colorTheme=" + (_colorTheme != null ? _colorTheme!.toString() : "null") + ", ");
    buffer.write("storagePaths=" + (_storagePaths != null ? _storagePaths!.toString() : "null") + ", ");
    buffer.write("schemeVersion=" + (_schemeVersion != null ? _schemeVersion!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Config copyWith({String? id, String? name, ColorTheme? colorTheme, StoragePaths? storagePaths, int? schemeVersion}) {
    return Config._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      colorTheme: colorTheme ?? this.colorTheme,
      storagePaths: storagePaths ?? this.storagePaths,
      schemeVersion: schemeVersion ?? this.schemeVersion);
  }
  
  Config.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _colorTheme = json['colorTheme']?['serializedData'] != null
        ? ColorTheme.fromJson(new Map<String, dynamic>.from(json['colorTheme']['serializedData']))
        : null,
      _storagePaths = json['storagePaths']?['serializedData'] != null
        ? StoragePaths.fromJson(new Map<String, dynamic>.from(json['storagePaths']['serializedData']))
        : null,
      _schemeVersion = (json['schemeVersion'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'colorTheme': _colorTheme?.toJson(), 'storagePaths': _storagePaths?.toJson(), 'schemeVersion': _schemeVersion, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "config.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField COLORTHEME = QueryField(fieldName: "colorTheme");
  static final QueryField STORAGEPATHS = QueryField(fieldName: "storagePaths");
  static final QueryField SCHEMEVERSION = QueryField(fieldName: "schemeVersion");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Config";
    modelSchemaDefinition.pluralName = "Configs";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Config.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'colorTheme',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'ColorTheme')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.embedded(
      fieldName: 'storagePaths',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.embedded, ofCustomTypeName: 'StoragePaths')
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Config.SCHEMEVERSION,
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
  });
}

class _ConfigModelType extends ModelType<Config> {
  const _ConfigModelType();
  
  @override
  Config fromJson(Map<String, dynamic> jsonData) {
    return Config.fromJson(jsonData);
  }
}