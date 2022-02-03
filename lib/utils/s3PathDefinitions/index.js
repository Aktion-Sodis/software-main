/* Resolve the following "path"s by replacing the substrings with the strings given in the array "replace" in the back-end.
If cannot be resolved, use default values for images, and show an error message for audio, markdown etc.
The dollar signs are put so that it is more legible for the development. They are thought be replaced with the empty string
before replacing the other substrings.

TODO: don't deploy the dollar signs to production! */

export const databaseOntologies = Object.freeze({
  userPicPath: { path: "userFiles/$userID/pic.png", toBeReplaced: ["userID"] },
  levelPicPath: {
    path: "levelFiles/$levelID/pic.png",
    toBeReplaced: ["levelID"],
  },
  levelCustomDataPicPath: {
    path: "levelFiles/$levelID/customDataFiles/$customDataID/pic.png",
    toBeReplaced: ["levelID", "customDataID"],
  },
  interventionPicPath: {
    path: "interventionFiles/$interventionID/pic.png",
    toBeReplaced: ["interventionID"],
  },
  // interventionDocMdPath: {
  //   path: "interventionFiles/$interventionID/documentFiles/$documentID.md",
  //   toBeReplaced: ["interventionID", "documentID"],
  // },
  docPdfPath: {
    path: "documentFiles/$documentID/pdf.pdf",
    toBeReplaced: ["documentID"],
  },
  docPicPath: {
    path: "documentFiles/$documentID/pic.png",
    toBeReplaced: ["documentID"],
  },
  interventionSurveyPicPath: {
    path: "interventionFiles/$interventionID/surveyFiles/$surveyID/pic.png",
    toBeReplaced: ["interventionID", "surveyID"],
  },
  questionPicPath: {
    path: "interventionFiles/$interventionID/surveyFiles/$surveyID/questionFiles/$questionID/pic.png",
    toBeReplaced: ["interventionID", "surveyID", "questionID"],
  },
  questionOptionPicPath: {
    path: "interventionFiles/$interventionID/surveyFiles/$surveyID/questionFiles/$questionID/optionFiles/$optionID/pic.png",
    toBeReplaced: ["interventionID", "surveyID", "questionID", "optionID"],
  },
  questionPicAnswerPath: {
    path: "appliedInterventionFiles/$appliedInterventionID/executedSurveyFiles/$executedSurveyID/questionFiles/$questionID/pic.png",
    toBeReplaced: ["appliedInterventionID", "executedSurveyID", "questionID"],
  },
  questionAudioAnswerPath: {
    path: "appliedInterventionFiles/$appliedInterventionID/executedSurveyFiles/$executedSurveyID/questionFiles/$questionID/audio.mp3",
    toBeReplaced: ["appliedInterventionID", "executedSurveyID", "questionID"],
  },
  appliedInterventionPicPath: {
    path: "appliedInterventionFiles/$appliedInterventionID/pic.png",
    toBeReplaced: ["appliedInterventionID"],
  },
  entityPicPath: {
    path: "entityFiles/$entityID/pic.png",
    toBeReplaced: ["entityID"],
  },
  taskPicPath: { path: "taskFiles/$taskID/pic.png", toBeReplaced: ["taskID"] },
  taskAudioPath: {
    path: "taskFiles/$taskID/audio.mp3",
    toBeReplaced: ["taskID"],
  },
});

export const deriveFilePath = (wantedDerivative, paramsObj) => {
  const derivative = databaseOntologies[wantedDerivative];
  if (Object.keys(paramsObj).length !== derivative.toBeReplaced.length)
    return -1;
  let res = derivative.path;
  res = res.replace("$", ""); // TODO: only development, not in production!

  Object.keys(paramsObj).forEach((k, i) => {
    res = res.replace(derivative.toBeReplaced[i], paramsObj[k]);
  });
  return res;
};
