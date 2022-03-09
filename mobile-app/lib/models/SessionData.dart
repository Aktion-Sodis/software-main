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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the SessionData type in your schema. */
@immutable
class SessionData extends Model {
  static const classType = const _SessionDataModelType();
  final String id;
  final TemporalDateTime? _date;
  final String? _userID;
  final String? _app;
  final String? _version;
  final String? _buildNumber;
  final String? _remoteConfig;
  final String? _platform;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  TemporalDateTime get date {
    try {
      return _date!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get userID {
    return _userID;
  }
  
  String? get app {
    return _app;
  }
  
  String? get version {
    return _version;
  }
  
  String? get buildNumber {
    return _buildNumber;
  }
  
  String? get remoteConfig {
    return _remoteConfig;
  }
  
  String? get platform {
    return _platform;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const SessionData._internal({required this.id, required date, userID, app, version, buildNumber, remoteConfig, platform, createdAt, updatedAt}): _date = date, _userID = userID, _app = app, _version = version, _buildNumber = buildNumber, _remoteConfig = remoteConfig, _platform = platform, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory SessionData({String? id, required TemporalDateTime date, String? userID, String? app, String? version, String? buildNumber, String? remoteConfig, String? platform}) {
    return SessionData._internal(
      id: id == null ? UUID.getUUID() : id,
      date: date,
      userID: userID,
      app: app,
      version: version,
      buildNumber: buildNumber,
      remoteConfig: remoteConfig,
      platform: platform);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionData &&
      id == other.id &&
      _date == other._date &&
      _userID == other._userID &&
      _app == other._app &&
      _version == other._version &&
      _buildNumber == other._buildNumber &&
      _remoteConfig == other._remoteConfig &&
      _platform == other._platform;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("SessionData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("date=" + (_date != null ? _date!.format() : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("app=" + "$_app" + ", ");
    buffer.write("version=" + "$_version" + ", ");
    buffer.write("buildNumber=" + "$_buildNumber" + ", ");
    buffer.write("remoteConfig=" + "$_remoteConfig" + ", ");
    buffer.write("platform=" + "$_platform" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  SessionData copyWith({String? id, TemporalDateTime? date, String? userID, String? app, String? version, String? buildNumber, String? remoteConfig, String? platform}) {
    return SessionData._internal(
      id: id ?? this.id,
      date: date ?? this.date,
      userID: userID ?? this.userID,
      app: app ?? this.app,
      version: version ?? this.version,
      buildNumber: buildNumber ?? this.buildNumber,
      remoteConfig: remoteConfig ?? this.remoteConfig,
      platform: platform ?? this.platform);
  }
  
  SessionData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _date = json['date'] != null ? TemporalDateTime.fromString(json['date']) : null,
      _userID = json['userID'],
      _app = json['app'],
      _version = json['version'],
      _buildNumber = json['buildNumber'],
      _remoteConfig = json['remoteConfig'],
      _platform = json['platform'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'date': _date?.format(), 'userID': _userID, 'app': _app, 'version': _version, 'buildNumber': _buildNumber, 'remoteConfig': _remoteConfig, 'platform': _platform, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "sessionData.id");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField APP = QueryField(fieldName: "app");
  static final QueryField VERSION = QueryField(fieldName: "version");
  static final QueryField BUILDNUMBER = QueryField(fieldName: "buildNumber");
  static final QueryField REMOTECONFIG = QueryField(fieldName: "remoteConfig");
  static final QueryField PLATFORM = QueryField(fieldName: "platform");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "SessionData";
    modelSchemaDefinition.pluralName = "SessionData";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SessionData.DATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SessionData.USERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SessionData.APP,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SessionData.VERSION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SessionData.BUILDNUMBER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SessionData.REMOTECONFIG,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: SessionData.PLATFORM,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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

class _SessionDataModelType extends ModelType<SessionData> {
  const _SessionDataModelType();
  
  @override
  SessionData fromJson(Map<String, dynamic> jsonData) {
    return SessionData.fromJson(jsonData);
  }
}