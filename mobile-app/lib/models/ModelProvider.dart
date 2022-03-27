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
import 'AppliedIntervention.dart';
import 'Config.dart';
import 'Content.dart';
import 'ContentContentTagRelation.dart';
import 'ContentTag.dart';
import 'Entity.dart';
import 'ExecutedSurvey.dart';
import 'Intervention.dart';
import 'InterventionContentRelation.dart';
import 'InterventionInterventionTagRelation.dart';
import 'InterventionTag.dart';
import 'Level.dart';
import 'LevelInterventionRelation.dart';
import 'SessionData.dart';
import 'Survey.dart';
import 'SurveySurveyTagRelation.dart';
import 'SurveyTag.dart';
import 'Task.dart';
import 'User.dart';
import 'AppliedCustomData.dart';
import 'ColorTheme.dart';
import 'CustomData.dart';
import 'I18nString.dart';
import 'Location.dart';
import 'Marking.dart';
import 'Permission.dart';
import 'Question.dart';
import 'QuestionAnswer.dart';
import 'QuestionOption.dart';

export 'AppliedCustomData.dart';
export 'AppliedIntervention.dart';
export 'ColorTheme.dart';
export 'Config.dart';
export 'Content.dart';
export 'ContentContentTagRelation.dart';
export 'ContentTag.dart';
export 'CustomData.dart';
export 'Entity.dart';
export 'ExecutedSurvey.dart';
export 'I18nString.dart';
export 'Intervention.dart';
export 'InterventionContentRelation.dart';
export 'InterventionInterventionTagRelation.dart';
export 'InterventionTag.dart';
export 'InterventionType.dart';
export 'Level.dart';
export 'LevelInterventionRelation.dart';
export 'Location.dart';
export 'Marking.dart';
export 'Permission.dart';
export 'PermissionType.dart';
export 'Question.dart';
export 'QuestionAnswer.dart';
export 'QuestionOption.dart';
export 'QuestionType.dart';
export 'SessionData.dart';
export 'Survey.dart';
export 'SurveySurveyTagRelation.dart';
export 'SurveyTag.dart';
export 'SurveyType.dart';
export 'Task.dart';
export 'Type.dart';
export 'User.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "0dfb644911edae5a7f8ee8ff051f9b6b";
  @override
  List<ModelSchema> modelSchemas = [AppliedIntervention.schema, Config.schema, Content.schema, ContentContentTagRelation.schema, ContentTag.schema, Entity.schema, ExecutedSurvey.schema, Intervention.schema, InterventionContentRelation.schema, InterventionInterventionTagRelation.schema, InterventionTag.schema, Level.schema, LevelInterventionRelation.schema, SessionData.schema, Survey.schema, SurveySurveyTagRelation.schema, SurveyTag.schema, Task.schema, User.schema];
  static final ModelProvider _instance = ModelProvider();
  @override
  List<ModelSchema> customTypeSchemas = [AppliedCustomData.schema, ColorTheme.schema, CustomData.schema, I18nString.schema, Location.schema, Marking.schema, Permission.schema, Question.schema, QuestionAnswer.schema, QuestionOption.schema];

  static ModelProvider get instance => _instance;
  
  ModelType getModelTypeByModelName(String modelName) {
    switch(modelName) {
      case "AppliedIntervention":
        return AppliedIntervention.classType;
      case "Config":
        return Config.classType;
      case "Content":
        return Content.classType;
      case "ContentContentTagRelation":
        return ContentContentTagRelation.classType;
      case "ContentTag":
        return ContentTag.classType;
      case "Entity":
        return Entity.classType;
      case "ExecutedSurvey":
        return ExecutedSurvey.classType;
      case "Intervention":
        return Intervention.classType;
      case "InterventionContentRelation":
        return InterventionContentRelation.classType;
      case "InterventionInterventionTagRelation":
        return InterventionInterventionTagRelation.classType;
      case "InterventionTag":
        return InterventionTag.classType;
      case "Level":
        return Level.classType;
      case "LevelInterventionRelation":
        return LevelInterventionRelation.classType;
      case "SessionData":
        return SessionData.classType;
      case "Survey":
        return Survey.classType;
      case "SurveySurveyTagRelation":
        return SurveySurveyTagRelation.classType;
      case "SurveyTag":
        return SurveyTag.classType;
      case "Task":
        return Task.classType;
      case "User":
        return User.classType;
      default:
        throw Exception("Failed to find model in model provider for model name: " + modelName);
    }
  }
}