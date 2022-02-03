///This class is only for a common definition of paths between the apps.
///
///It has to be synchronized in the application's lib folder to be used.

import 'dart:core';

///enum of available paths to avoid errors due to wrong string spelling
enum DataStorePathes {
  userPicPath,
  levelPicPath,
  levelCustomDataPicPath,
  interventionPicPath,
  docPdfPath,
  docPicPath,
  interventionSurveyPicPath,
  questionPicPath,
  questionOptionPicPath,
  questionPicAnswerPath,
  questionAudioAnswerPath,
  appliedInterventionPicPath,
  entityPicPath,
  taskPicPath,
  taskAudioPath
}

///Map of ontoligies including the replacable parameters
final Map<DataStorePathes, dynamic> databaseOntologies = {
  DataStorePathes.userPicPath: {
    "path": "userFiles/userID/pic.png",
    "toBeReplaced": ["userID"]
  },
  DataStorePathes.levelPicPath: {
    "path": "levelFiles/levelID/pic.png",
    "toBeReplaced": ["levelID"],
  },
  DataStorePathes.levelCustomDataPicPath: {
    "path": "levelFiles/levelID/customDataFiles/customDataID/pic.png",
    "toBeReplaced": ["levelID", "customDataID"],
  },
  DataStorePathes.interventionPicPath: {
    "path": "interventionFiles/interventionID/pic.png",
    "toBeReplaced": ["interventionID"],
  },
  DataStorePathes.docPdfPath: {
    "path": "documentFiles/documentID/pdf.pdf",
    "toBeReplaced": ["documentID"],
  },
  DataStorePathes.docPicPath: {
    "path": "documentFiles/documentID/pic.png",
    "toBeReplaced": ["documentID"],
  },
  DataStorePathes.interventionSurveyPicPath: {
    "path": "interventionFiles/interventionID/surveyFiles/surveyID/pic.png",
    "toBeReplaced": ["interventionID", "surveyID"],
  },
  DataStorePathes.questionPicPath: {
    "path":
        "interventionFiles/interventionID/surveyFiles/surveyID/questionFiles/questionID/pic.png",
    "toBeReplaced": ["interventionID", "surveyID", "questionID"],
  },
  DataStorePathes.questionOptionPicPath: {
    "path":
        "interventionFiles/interventionID/surveyFiles/surveyID/questionFiles/questionID/optionFiles/optionID/pic.png",
    "toBeReplaced": ["interventionID", "surveyID", "questionID", "optionID"],
  },
  DataStorePathes.questionPicAnswerPath: {
    "path":
        "appliedInterventionFiles/appliedInterventionID/executedSurveyFiles/executedSurveyID/questionFiles/questionID/pic.png",
    "toBeReplaced": ["appliedInterventionID", "executedSurveyID", "questionID"],
  },
  DataStorePathes.questionAudioAnswerPath: {
    "path":
        "appliedInterventionFiles/appliedInterventionID/executedSurveyFiles/executedSurveyID/questionFiles/questionID/audio.mp3",
    "toBeReplaced": ["appliedInterventionID", "executedSurveyID", "questionID"],
  },
  DataStorePathes.appliedInterventionPicPath: {
    "path": "appliedInterventionFiles/appliedInterventionID/pic.png",
    "toBeReplaced": ["appliedInterventionID"],
  },
  DataStorePathes.entityPicPath: {
    "path": "entityFiles/entityID/pic.png",
    "toBeReplaced": ["entityID"],
  },
  DataStorePathes.taskPicPath: {
    "path": "taskFiles/taskID/pic.png",
    "toBeReplaced": ["taskID"]
  },
  DataStorePathes.taskAudioPath: {
    "path": "taskFiles/taskID/audio.mp3",
    "toBeReplaced": ["taskID"],
  },
};

///method passed the path name and the required paramters
///throws an error if parameters not fitting the paths are passed
String dataStorePath(DataStorePathes path, List<String> parameters) {
  String rawPath = databaseOntologies[path]["path"];
  List<String> replacementParameters = databaseOntologies[path]["toBeReplaced"];

  String filledPath = rawPath;

  if (parameters.length == replacementParameters.length) {
    for (int i = 0; i < parameters.length; i++) {
      filledPath =
          filledPath.replaceAll(replacementParameters[i], parameters[i]);
    }
    return filledPath;
  } else {
    throw new FormatException(
        "Wrong parameters passed for dataStorePath $path");
  }
}