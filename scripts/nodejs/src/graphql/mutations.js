/* eslint-disable */
// this is an auto generated file. This will be overwritten

export const createUser = /* GraphQL */ `
  mutation CreateUser(
    $input: CreateUserInput!
    $condition: ModelUserConditionInput
  ) {
    createUser(input: $input, condition: $condition) {
      firstName
      lastName
      bio
      permissions {
        permissionType
        allowedEntities
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateUser = /* GraphQL */ `
  mutation UpdateUser(
    $input: UpdateUserInput!
    $condition: ModelUserConditionInput
  ) {
    updateUser(input: $input, condition: $condition) {
      firstName
      lastName
      bio
      permissions {
        permissionType
        allowedEntities
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteUser = /* GraphQL */ `
  mutation DeleteUser(
    $input: DeleteUserInput!
    $condition: ModelUserConditionInput
  ) {
    deleteUser(input: $input, condition: $condition) {
      firstName
      lastName
      bio
      permissions {
        permissionType
        allowedEntities
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createConfig = /* GraphQL */ `
  mutation CreateConfig(
    $input: CreateConfigInput!
    $condition: ModelConfigConditionInput
  ) {
    createConfig(input: $input, condition: $condition) {
      name
      colorTheme {
        highlight
        secondaryHighlight
        backgroundOneLight
        backgroundTwoLight
        backgroundOneDark
        backgroundTwoDark
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateConfig = /* GraphQL */ `
  mutation UpdateConfig(
    $input: UpdateConfigInput!
    $condition: ModelConfigConditionInput
  ) {
    updateConfig(input: $input, condition: $condition) {
      name
      colorTheme {
        highlight
        secondaryHighlight
        backgroundOneLight
        backgroundTwoLight
        backgroundOneDark
        backgroundTwoDark
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteConfig = /* GraphQL */ `
  mutation DeleteConfig(
    $input: DeleteConfigInput!
    $condition: ModelConfigConditionInput
  ) {
    deleteConfig(input: $input, condition: $condition) {
      name
      colorTheme {
        highlight
        secondaryHighlight
        backgroundOneLight
        backgroundTwoLight
        backgroundOneDark
        backgroundTwoDark
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createLevel = /* GraphQL */ `
  mutation CreateLevel(
    $input: CreateLevelInput!
    $condition: ModelLevelConditionInput
  ) {
    createLevel(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      parentLevelID
      interventionsAreAllowed
      allowedInterventions {
        items {
          id
          levelID
          interventionID
          level {
            parentLevelID
            interventionsAreAllowed
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      customData {
        id
        name {
          languageKeys
          languageTexts
        }
        type
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateLevel = /* GraphQL */ `
  mutation UpdateLevel(
    $input: UpdateLevelInput!
    $condition: ModelLevelConditionInput
  ) {
    updateLevel(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      parentLevelID
      interventionsAreAllowed
      allowedInterventions {
        items {
          id
          levelID
          interventionID
          level {
            parentLevelID
            interventionsAreAllowed
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      customData {
        id
        name {
          languageKeys
          languageTexts
        }
        type
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteLevel = /* GraphQL */ `
  mutation DeleteLevel(
    $input: DeleteLevelInput!
    $condition: ModelLevelConditionInput
  ) {
    deleteLevel(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      parentLevelID
      interventionsAreAllowed
      allowedInterventions {
        items {
          id
          levelID
          interventionID
          level {
            parentLevelID
            interventionsAreAllowed
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      customData {
        id
        name {
          languageKeys
          languageTexts
        }
        type
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createIntervention = /* GraphQL */ `
  mutation CreateIntervention(
    $input: CreateInterventionInput!
    $condition: ModelInterventionConditionInput
  ) {
    createIntervention(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      interventionType
      contents {
        items {
          id
          interventionID
          contentID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      surveys {
        items {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          questions {
            id
            type
            isFollowUpQuestion
          }
          tags {
            nextToken
            startedAt
          }
          surveyType
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          interventionSurveysId
        }
        nextToken
        startedAt
      }
      tags {
        items {
          id
          interventionID
          interventionTagID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          interventionTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      schemeVersion
      levels {
        items {
          id
          levelID
          interventionID
          level {
            parentLevelID
            interventionsAreAllowed
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateIntervention = /* GraphQL */ `
  mutation UpdateIntervention(
    $input: UpdateInterventionInput!
    $condition: ModelInterventionConditionInput
  ) {
    updateIntervention(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      interventionType
      contents {
        items {
          id
          interventionID
          contentID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      surveys {
        items {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          questions {
            id
            type
            isFollowUpQuestion
          }
          tags {
            nextToken
            startedAt
          }
          surveyType
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          interventionSurveysId
        }
        nextToken
        startedAt
      }
      tags {
        items {
          id
          interventionID
          interventionTagID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          interventionTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      schemeVersion
      levels {
        items {
          id
          levelID
          interventionID
          level {
            parentLevelID
            interventionsAreAllowed
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteIntervention = /* GraphQL */ `
  mutation DeleteIntervention(
    $input: DeleteInterventionInput!
    $condition: ModelInterventionConditionInput
  ) {
    deleteIntervention(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      interventionType
      contents {
        items {
          id
          interventionID
          contentID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      surveys {
        items {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          questions {
            id
            type
            isFollowUpQuestion
          }
          tags {
            nextToken
            startedAt
          }
          surveyType
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          interventionSurveysId
        }
        nextToken
        startedAt
      }
      tags {
        items {
          id
          interventionID
          interventionTagID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          interventionTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      schemeVersion
      levels {
        items {
          id
          levelID
          interventionID
          level {
            parentLevelID
            interventionsAreAllowed
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createContent = /* GraphQL */ `
  mutation CreateContent(
    $input: CreateContentInput!
    $condition: ModelContentConditionInput
  ) {
    createContent(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      interventions {
        items {
          id
          interventionID
          contentID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      tags {
        items {
          id
          contentID
          contentTagID
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          contentTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateContent = /* GraphQL */ `
  mutation UpdateContent(
    $input: UpdateContentInput!
    $condition: ModelContentConditionInput
  ) {
    updateContent(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      interventions {
        items {
          id
          interventionID
          contentID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      tags {
        items {
          id
          contentID
          contentTagID
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          contentTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteContent = /* GraphQL */ `
  mutation DeleteContent(
    $input: DeleteContentInput!
    $condition: ModelContentConditionInput
  ) {
    deleteContent(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      interventions {
        items {
          id
          interventionID
          contentID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      tags {
        items {
          id
          contentID
          contentTagID
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          contentTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createSurvey = /* GraphQL */ `
  mutation CreateSurvey(
    $input: CreateSurveyInput!
    $condition: ModelSurveyConditionInput
  ) {
    createSurvey(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      questions {
        id
        text {
          languageKeys
          languageTexts
        }
        type
        questionOptions {
          id
          text {
            languageKeys
            languageTexts
          }
          followUpQuestionID
        }
        isFollowUpQuestion
      }
      tags {
        items {
          id
          surveyID
          surveyTagID
          survey {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          surveyTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      surveyType
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      interventionSurveysId
    }
  }
`;
export const updateSurvey = /* GraphQL */ `
  mutation UpdateSurvey(
    $input: UpdateSurveyInput!
    $condition: ModelSurveyConditionInput
  ) {
    updateSurvey(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      questions {
        id
        text {
          languageKeys
          languageTexts
        }
        type
        questionOptions {
          id
          text {
            languageKeys
            languageTexts
          }
          followUpQuestionID
        }
        isFollowUpQuestion
      }
      tags {
        items {
          id
          surveyID
          surveyTagID
          survey {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          surveyTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      surveyType
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      interventionSurveysId
    }
  }
`;
export const deleteSurvey = /* GraphQL */ `
  mutation DeleteSurvey(
    $input: DeleteSurveyInput!
    $condition: ModelSurveyConditionInput
  ) {
    deleteSurvey(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      questions {
        id
        text {
          languageKeys
          languageTexts
        }
        type
        questionOptions {
          id
          text {
            languageKeys
            languageTexts
          }
          followUpQuestionID
        }
        isFollowUpQuestion
      }
      tags {
        items {
          id
          surveyID
          surveyTagID
          survey {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          surveyTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      surveyType
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      interventionSurveysId
    }
  }
`;
export const createEntity = /* GraphQL */ `
  mutation CreateEntity(
    $input: CreateEntityInput!
    $condition: ModelEntityConditionInput
  ) {
    createEntity(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      parentEntityID
      level {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        parentLevelID
        interventionsAreAllowed
        allowedInterventions {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        customData {
          id
          name {
            languageKeys
            languageTexts
          }
          type
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      location {
        latitude
        longitude
      }
      customData {
        customDataID
        type
        name
        intValue
        stringValue
      }
      appliedInterventions {
        items {
          whoDidIt {
            firstName
            lastName
            bio
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          location {
            latitude
            longitude
          }
          executedSurveys {
            nextToken
            startedAt
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          entityAppliedInterventionsId
          appliedInterventionWhoDidItId
          appliedInterventionInterventionId
        }
        nextToken
        startedAt
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      entityLevelId
    }
  }
`;
export const updateEntity = /* GraphQL */ `
  mutation UpdateEntity(
    $input: UpdateEntityInput!
    $condition: ModelEntityConditionInput
  ) {
    updateEntity(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      parentEntityID
      level {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        parentLevelID
        interventionsAreAllowed
        allowedInterventions {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        customData {
          id
          name {
            languageKeys
            languageTexts
          }
          type
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      location {
        latitude
        longitude
      }
      customData {
        customDataID
        type
        name
        intValue
        stringValue
      }
      appliedInterventions {
        items {
          whoDidIt {
            firstName
            lastName
            bio
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          location {
            latitude
            longitude
          }
          executedSurveys {
            nextToken
            startedAt
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          entityAppliedInterventionsId
          appliedInterventionWhoDidItId
          appliedInterventionInterventionId
        }
        nextToken
        startedAt
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      entityLevelId
    }
  }
`;
export const deleteEntity = /* GraphQL */ `
  mutation DeleteEntity(
    $input: DeleteEntityInput!
    $condition: ModelEntityConditionInput
  ) {
    deleteEntity(input: $input, condition: $condition) {
      name {
        languageKeys
        languageTexts
      }
      description {
        languageKeys
        languageTexts
      }
      parentEntityID
      level {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        parentLevelID
        interventionsAreAllowed
        allowedInterventions {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        customData {
          id
          name {
            languageKeys
            languageTexts
          }
          type
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      location {
        latitude
        longitude
      }
      customData {
        customDataID
        type
        name
        intValue
        stringValue
      }
      appliedInterventions {
        items {
          whoDidIt {
            firstName
            lastName
            bio
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          location {
            latitude
            longitude
          }
          executedSurveys {
            nextToken
            startedAt
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          entityAppliedInterventionsId
          appliedInterventionWhoDidItId
          appliedInterventionInterventionId
        }
        nextToken
        startedAt
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      entityLevelId
    }
  }
`;
export const createAppliedIntervention = /* GraphQL */ `
  mutation CreateAppliedIntervention(
    $input: CreateAppliedInterventionInput!
    $condition: ModelAppliedInterventionConditionInput
  ) {
    createAppliedIntervention(input: $input, condition: $condition) {
      whoDidIt {
        firstName
        lastName
        bio
        permissions {
          permissionType
          allowedEntities
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      location {
        latitude
        longitude
      }
      executedSurveys {
        items {
          appliedIntervention {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            entityAppliedInterventionsId
            appliedInterventionWhoDidItId
            appliedInterventionInterventionId
          }
          survey {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          whoExecutedIt {
            firstName
            lastName
            bio
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          date
          location {
            latitude
            longitude
          }
          answers {
            id
            questionID
            date
            type
            text
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          appliedInterventionExecutedSurveysId
          executedSurveySurveyId
          executedSurveyWhoExecutedItId
        }
        nextToken
        startedAt
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      entityAppliedInterventionsId
      appliedInterventionWhoDidItId
      appliedInterventionInterventionId
    }
  }
`;
export const updateAppliedIntervention = /* GraphQL */ `
  mutation UpdateAppliedIntervention(
    $input: UpdateAppliedInterventionInput!
    $condition: ModelAppliedInterventionConditionInput
  ) {
    updateAppliedIntervention(input: $input, condition: $condition) {
      whoDidIt {
        firstName
        lastName
        bio
        permissions {
          permissionType
          allowedEntities
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      location {
        latitude
        longitude
      }
      executedSurveys {
        items {
          appliedIntervention {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            entityAppliedInterventionsId
            appliedInterventionWhoDidItId
            appliedInterventionInterventionId
          }
          survey {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          whoExecutedIt {
            firstName
            lastName
            bio
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          date
          location {
            latitude
            longitude
          }
          answers {
            id
            questionID
            date
            type
            text
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          appliedInterventionExecutedSurveysId
          executedSurveySurveyId
          executedSurveyWhoExecutedItId
        }
        nextToken
        startedAt
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      entityAppliedInterventionsId
      appliedInterventionWhoDidItId
      appliedInterventionInterventionId
    }
  }
`;
export const deleteAppliedIntervention = /* GraphQL */ `
  mutation DeleteAppliedIntervention(
    $input: DeleteAppliedInterventionInput!
    $condition: ModelAppliedInterventionConditionInput
  ) {
    deleteAppliedIntervention(input: $input, condition: $condition) {
      whoDidIt {
        firstName
        lastName
        bio
        permissions {
          permissionType
          allowedEntities
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      location {
        latitude
        longitude
      }
      executedSurveys {
        items {
          appliedIntervention {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            entityAppliedInterventionsId
            appliedInterventionWhoDidItId
            appliedInterventionInterventionId
          }
          survey {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          whoExecutedIt {
            firstName
            lastName
            bio
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          date
          location {
            latitude
            longitude
          }
          answers {
            id
            questionID
            date
            type
            text
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          appliedInterventionExecutedSurveysId
          executedSurveySurveyId
          executedSurveyWhoExecutedItId
        }
        nextToken
        startedAt
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      entityAppliedInterventionsId
      appliedInterventionWhoDidItId
      appliedInterventionInterventionId
    }
  }
`;
export const createExecutedSurvey = /* GraphQL */ `
  mutation CreateExecutedSurvey(
    $input: CreateExecutedSurveyInput!
    $condition: ModelExecutedSurveyConditionInput
  ) {
    createExecutedSurvey(input: $input, condition: $condition) {
      appliedIntervention {
        whoDidIt {
          firstName
          lastName
          bio
          permissions {
            permissionType
            allowedEntities
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        location {
          latitude
          longitude
        }
        executedSurveys {
          items {
            date
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            appliedInterventionExecutedSurveysId
            executedSurveySurveyId
            executedSurveyWhoExecutedItId
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        entityAppliedInterventionsId
        appliedInterventionWhoDidItId
        appliedInterventionInterventionId
      }
      survey {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        questions {
          id
          text {
            languageKeys
            languageTexts
          }
          type
          questionOptions {
            id
            followUpQuestionID
          }
          isFollowUpQuestion
        }
        tags {
          items {
            id
            surveyID
            surveyTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveyType
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        interventionSurveysId
      }
      whoExecutedIt {
        firstName
        lastName
        bio
        permissions {
          permissionType
          allowedEntities
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      date
      location {
        latitude
        longitude
      }
      answers {
        id
        questionID
        date
        type
        text
        questionOptions {
          id
          text {
            languageKeys
            languageTexts
          }
          followUpQuestionID
        }
        markings {
          x
          y
          rx
          ry
          text
        }
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      appliedInterventionExecutedSurveysId
      executedSurveySurveyId
      executedSurveyWhoExecutedItId
    }
  }
`;
export const updateExecutedSurvey = /* GraphQL */ `
  mutation UpdateExecutedSurvey(
    $input: UpdateExecutedSurveyInput!
    $condition: ModelExecutedSurveyConditionInput
  ) {
    updateExecutedSurvey(input: $input, condition: $condition) {
      appliedIntervention {
        whoDidIt {
          firstName
          lastName
          bio
          permissions {
            permissionType
            allowedEntities
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        location {
          latitude
          longitude
        }
        executedSurveys {
          items {
            date
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            appliedInterventionExecutedSurveysId
            executedSurveySurveyId
            executedSurveyWhoExecutedItId
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        entityAppliedInterventionsId
        appliedInterventionWhoDidItId
        appliedInterventionInterventionId
      }
      survey {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        questions {
          id
          text {
            languageKeys
            languageTexts
          }
          type
          questionOptions {
            id
            followUpQuestionID
          }
          isFollowUpQuestion
        }
        tags {
          items {
            id
            surveyID
            surveyTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveyType
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        interventionSurveysId
      }
      whoExecutedIt {
        firstName
        lastName
        bio
        permissions {
          permissionType
          allowedEntities
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      date
      location {
        latitude
        longitude
      }
      answers {
        id
        questionID
        date
        type
        text
        questionOptions {
          id
          text {
            languageKeys
            languageTexts
          }
          followUpQuestionID
        }
        markings {
          x
          y
          rx
          ry
          text
        }
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      appliedInterventionExecutedSurveysId
      executedSurveySurveyId
      executedSurveyWhoExecutedItId
    }
  }
`;
export const deleteExecutedSurvey = /* GraphQL */ `
  mutation DeleteExecutedSurvey(
    $input: DeleteExecutedSurveyInput!
    $condition: ModelExecutedSurveyConditionInput
  ) {
    deleteExecutedSurvey(input: $input, condition: $condition) {
      appliedIntervention {
        whoDidIt {
          firstName
          lastName
          bio
          permissions {
            permissionType
            allowedEntities
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        location {
          latitude
          longitude
        }
        executedSurveys {
          items {
            date
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            appliedInterventionExecutedSurveysId
            executedSurveySurveyId
            executedSurveyWhoExecutedItId
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        entityAppliedInterventionsId
        appliedInterventionWhoDidItId
        appliedInterventionInterventionId
      }
      survey {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        questions {
          id
          text {
            languageKeys
            languageTexts
          }
          type
          questionOptions {
            id
            followUpQuestionID
          }
          isFollowUpQuestion
        }
        tags {
          items {
            id
            surveyID
            surveyTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveyType
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        interventionSurveysId
      }
      whoExecutedIt {
        firstName
        lastName
        bio
        permissions {
          permissionType
          allowedEntities
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      date
      location {
        latitude
        longitude
      }
      answers {
        id
        questionID
        date
        type
        text
        questionOptions {
          id
          text {
            languageKeys
            languageTexts
          }
          followUpQuestionID
        }
        markings {
          x
          y
          rx
          ry
          text
        }
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      appliedInterventionExecutedSurveysId
      executedSurveySurveyId
      executedSurveyWhoExecutedItId
    }
  }
`;
export const createTask = /* GraphQL */ `
  mutation CreateTask(
    $input: CreateTaskInput!
    $condition: ModelTaskConditionInput
  ) {
    createTask(input: $input, condition: $condition) {
      title
      text
      dueDate
      finishedDate
      location {
        latitude
        longitude
      }
      user {
        firstName
        lastName
        bio
        permissions {
          permissionType
          allowedEntities
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      entity {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        parentEntityID
        level {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          parentLevelID
          interventionsAreAllowed
          allowedInterventions {
            nextToken
            startedAt
          }
          customData {
            id
            type
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        location {
          latitude
          longitude
        }
        customData {
          customDataID
          type
          name
          intValue
          stringValue
        }
        appliedInterventions {
          items {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            entityAppliedInterventionsId
            appliedInterventionWhoDidItId
            appliedInterventionInterventionId
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        entityLevelId
      }
      appliedIntervention {
        whoDidIt {
          firstName
          lastName
          bio
          permissions {
            permissionType
            allowedEntities
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        location {
          latitude
          longitude
        }
        executedSurveys {
          items {
            date
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            appliedInterventionExecutedSurveysId
            executedSurveySurveyId
            executedSurveyWhoExecutedItId
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        entityAppliedInterventionsId
        appliedInterventionWhoDidItId
        appliedInterventionInterventionId
      }
      executedSurvey {
        appliedIntervention {
          whoDidIt {
            firstName
            lastName
            bio
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          location {
            latitude
            longitude
          }
          executedSurveys {
            nextToken
            startedAt
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          entityAppliedInterventionsId
          appliedInterventionWhoDidItId
          appliedInterventionInterventionId
        }
        survey {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          questions {
            id
            type
            isFollowUpQuestion
          }
          tags {
            nextToken
            startedAt
          }
          surveyType
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          interventionSurveysId
        }
        whoExecutedIt {
          firstName
          lastName
          bio
          permissions {
            permissionType
            allowedEntities
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        date
        location {
          latitude
          longitude
        }
        answers {
          id
          questionID
          date
          type
          text
          questionOptions {
            id
            followUpQuestionID
          }
          markings {
            x
            y
            rx
            ry
            text
          }
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        appliedInterventionExecutedSurveysId
        executedSurveySurveyId
        executedSurveyWhoExecutedItId
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      taskUserId
      taskEntityId
      taskAppliedInterventionId
      taskExecutedSurveyId
    }
  }
`;
export const updateTask = /* GraphQL */ `
  mutation UpdateTask(
    $input: UpdateTaskInput!
    $condition: ModelTaskConditionInput
  ) {
    updateTask(input: $input, condition: $condition) {
      title
      text
      dueDate
      finishedDate
      location {
        latitude
        longitude
      }
      user {
        firstName
        lastName
        bio
        permissions {
          permissionType
          allowedEntities
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      entity {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        parentEntityID
        level {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          parentLevelID
          interventionsAreAllowed
          allowedInterventions {
            nextToken
            startedAt
          }
          customData {
            id
            type
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        location {
          latitude
          longitude
        }
        customData {
          customDataID
          type
          name
          intValue
          stringValue
        }
        appliedInterventions {
          items {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            entityAppliedInterventionsId
            appliedInterventionWhoDidItId
            appliedInterventionInterventionId
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        entityLevelId
      }
      appliedIntervention {
        whoDidIt {
          firstName
          lastName
          bio
          permissions {
            permissionType
            allowedEntities
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        location {
          latitude
          longitude
        }
        executedSurveys {
          items {
            date
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            appliedInterventionExecutedSurveysId
            executedSurveySurveyId
            executedSurveyWhoExecutedItId
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        entityAppliedInterventionsId
        appliedInterventionWhoDidItId
        appliedInterventionInterventionId
      }
      executedSurvey {
        appliedIntervention {
          whoDidIt {
            firstName
            lastName
            bio
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          location {
            latitude
            longitude
          }
          executedSurveys {
            nextToken
            startedAt
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          entityAppliedInterventionsId
          appliedInterventionWhoDidItId
          appliedInterventionInterventionId
        }
        survey {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          questions {
            id
            type
            isFollowUpQuestion
          }
          tags {
            nextToken
            startedAt
          }
          surveyType
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          interventionSurveysId
        }
        whoExecutedIt {
          firstName
          lastName
          bio
          permissions {
            permissionType
            allowedEntities
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        date
        location {
          latitude
          longitude
        }
        answers {
          id
          questionID
          date
          type
          text
          questionOptions {
            id
            followUpQuestionID
          }
          markings {
            x
            y
            rx
            ry
            text
          }
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        appliedInterventionExecutedSurveysId
        executedSurveySurveyId
        executedSurveyWhoExecutedItId
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      taskUserId
      taskEntityId
      taskAppliedInterventionId
      taskExecutedSurveyId
    }
  }
`;
export const deleteTask = /* GraphQL */ `
  mutation DeleteTask(
    $input: DeleteTaskInput!
    $condition: ModelTaskConditionInput
  ) {
    deleteTask(input: $input, condition: $condition) {
      title
      text
      dueDate
      finishedDate
      location {
        latitude
        longitude
      }
      user {
        firstName
        lastName
        bio
        permissions {
          permissionType
          allowedEntities
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      entity {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        parentEntityID
        level {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          parentLevelID
          interventionsAreAllowed
          allowedInterventions {
            nextToken
            startedAt
          }
          customData {
            id
            type
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        location {
          latitude
          longitude
        }
        customData {
          customDataID
          type
          name
          intValue
          stringValue
        }
        appliedInterventions {
          items {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            entityAppliedInterventionsId
            appliedInterventionWhoDidItId
            appliedInterventionInterventionId
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        entityLevelId
      }
      appliedIntervention {
        whoDidIt {
          firstName
          lastName
          bio
          permissions {
            permissionType
            allowedEntities
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        location {
          latitude
          longitude
        }
        executedSurveys {
          items {
            date
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            appliedInterventionExecutedSurveysId
            executedSurveySurveyId
            executedSurveyWhoExecutedItId
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        entityAppliedInterventionsId
        appliedInterventionWhoDidItId
        appliedInterventionInterventionId
      }
      executedSurvey {
        appliedIntervention {
          whoDidIt {
            firstName
            lastName
            bio
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          location {
            latitude
            longitude
          }
          executedSurveys {
            nextToken
            startedAt
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          entityAppliedInterventionsId
          appliedInterventionWhoDidItId
          appliedInterventionInterventionId
        }
        survey {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          questions {
            id
            type
            isFollowUpQuestion
          }
          tags {
            nextToken
            startedAt
          }
          surveyType
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
          interventionSurveysId
        }
        whoExecutedIt {
          firstName
          lastName
          bio
          permissions {
            permissionType
            allowedEntities
          }
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        date
        location {
          latitude
          longitude
        }
        answers {
          id
          questionID
          date
          type
          text
          questionOptions {
            id
            followUpQuestionID
          }
          markings {
            x
            y
            rx
            ry
            text
          }
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        appliedInterventionExecutedSurveysId
        executedSurveySurveyId
        executedSurveyWhoExecutedItId
      }
      schemeVersion
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
      taskUserId
      taskEntityId
      taskAppliedInterventionId
      taskExecutedSurveyId
    }
  }
`;
export const createContentTag = /* GraphQL */ `
  mutation CreateContentTag(
    $input: CreateContentTagInput!
    $condition: ModelContentTagConditionInput
  ) {
    createContentTag(input: $input, condition: $condition) {
      text {
        languageKeys
        languageTexts
      }
      schemeVersion
      contents {
        items {
          id
          contentID
          contentTagID
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          contentTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateContentTag = /* GraphQL */ `
  mutation UpdateContentTag(
    $input: UpdateContentTagInput!
    $condition: ModelContentTagConditionInput
  ) {
    updateContentTag(input: $input, condition: $condition) {
      text {
        languageKeys
        languageTexts
      }
      schemeVersion
      contents {
        items {
          id
          contentID
          contentTagID
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          contentTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteContentTag = /* GraphQL */ `
  mutation DeleteContentTag(
    $input: DeleteContentTagInput!
    $condition: ModelContentTagConditionInput
  ) {
    deleteContentTag(input: $input, condition: $condition) {
      text {
        languageKeys
        languageTexts
      }
      schemeVersion
      contents {
        items {
          id
          contentID
          contentTagID
          content {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          contentTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createInterventionTag = /* GraphQL */ `
  mutation CreateInterventionTag(
    $input: CreateInterventionTagInput!
    $condition: ModelInterventionTagConditionInput
  ) {
    createInterventionTag(input: $input, condition: $condition) {
      text {
        languageKeys
        languageTexts
      }
      schemeVersion
      interventions {
        items {
          id
          interventionID
          interventionTagID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          interventionTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateInterventionTag = /* GraphQL */ `
  mutation UpdateInterventionTag(
    $input: UpdateInterventionTagInput!
    $condition: ModelInterventionTagConditionInput
  ) {
    updateInterventionTag(input: $input, condition: $condition) {
      text {
        languageKeys
        languageTexts
      }
      schemeVersion
      interventions {
        items {
          id
          interventionID
          interventionTagID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          interventionTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteInterventionTag = /* GraphQL */ `
  mutation DeleteInterventionTag(
    $input: DeleteInterventionTagInput!
    $condition: ModelInterventionTagConditionInput
  ) {
    deleteInterventionTag(input: $input, condition: $condition) {
      text {
        languageKeys
        languageTexts
      }
      schemeVersion
      interventions {
        items {
          id
          interventionID
          interventionTagID
          intervention {
            interventionType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          interventionTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createSurveyTag = /* GraphQL */ `
  mutation CreateSurveyTag(
    $input: CreateSurveyTagInput!
    $condition: ModelSurveyTagConditionInput
  ) {
    createSurveyTag(input: $input, condition: $condition) {
      text {
        languageKeys
        languageTexts
      }
      schemeVersion
      surveys {
        items {
          id
          surveyID
          surveyTagID
          survey {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          surveyTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateSurveyTag = /* GraphQL */ `
  mutation UpdateSurveyTag(
    $input: UpdateSurveyTagInput!
    $condition: ModelSurveyTagConditionInput
  ) {
    updateSurveyTag(input: $input, condition: $condition) {
      text {
        languageKeys
        languageTexts
      }
      schemeVersion
      surveys {
        items {
          id
          surveyID
          surveyTagID
          survey {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          surveyTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteSurveyTag = /* GraphQL */ `
  mutation DeleteSurveyTag(
    $input: DeleteSurveyTagInput!
    $condition: ModelSurveyTagConditionInput
  ) {
    deleteSurveyTag(input: $input, condition: $condition) {
      text {
        languageKeys
        languageTexts
      }
      schemeVersion
      surveys {
        items {
          id
          surveyID
          surveyTagID
          survey {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          surveyTag {
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        nextToken
        startedAt
      }
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createSessionData = /* GraphQL */ `
  mutation CreateSessionData(
    $input: CreateSessionDataInput!
    $condition: ModelSessionDataConditionInput
  ) {
    createSessionData(input: $input, condition: $condition) {
      date
      userID
      app
      version
      buildNumber
      remoteConfig
      platform
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateSessionData = /* GraphQL */ `
  mutation UpdateSessionData(
    $input: UpdateSessionDataInput!
    $condition: ModelSessionDataConditionInput
  ) {
    updateSessionData(input: $input, condition: $condition) {
      date
      userID
      app
      version
      buildNumber
      remoteConfig
      platform
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteSessionData = /* GraphQL */ `
  mutation DeleteSessionData(
    $input: DeleteSessionDataInput!
    $condition: ModelSessionDataConditionInput
  ) {
    deleteSessionData(input: $input, condition: $condition) {
      date
      userID
      app
      version
      buildNumber
      remoteConfig
      platform
      id
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createLevelInterventionRelation = /* GraphQL */ `
  mutation CreateLevelInterventionRelation(
    $input: CreateLevelInterventionRelationInput!
    $condition: ModelLevelInterventionRelationConditionInput
  ) {
    createLevelInterventionRelation(input: $input, condition: $condition) {
      id
      levelID
      interventionID
      level {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        parentLevelID
        interventionsAreAllowed
        allowedInterventions {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        customData {
          id
          name {
            languageKeys
            languageTexts
          }
          type
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateLevelInterventionRelation = /* GraphQL */ `
  mutation UpdateLevelInterventionRelation(
    $input: UpdateLevelInterventionRelationInput!
    $condition: ModelLevelInterventionRelationConditionInput
  ) {
    updateLevelInterventionRelation(input: $input, condition: $condition) {
      id
      levelID
      interventionID
      level {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        parentLevelID
        interventionsAreAllowed
        allowedInterventions {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        customData {
          id
          name {
            languageKeys
            languageTexts
          }
          type
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteLevelInterventionRelation = /* GraphQL */ `
  mutation DeleteLevelInterventionRelation(
    $input: DeleteLevelInterventionRelationInput!
    $condition: ModelLevelInterventionRelationConditionInput
  ) {
    deleteLevelInterventionRelation(input: $input, condition: $condition) {
      id
      levelID
      interventionID
      level {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        parentLevelID
        interventionsAreAllowed
        allowedInterventions {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        customData {
          id
          name {
            languageKeys
            languageTexts
          }
          type
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createInterventionContentRelation = /* GraphQL */ `
  mutation CreateInterventionContentRelation(
    $input: CreateInterventionContentRelationInput!
    $condition: ModelInterventionContentRelationConditionInput
  ) {
    createInterventionContentRelation(input: $input, condition: $condition) {
      id
      interventionID
      contentID
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      content {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventions {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            contentID
            contentTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateInterventionContentRelation = /* GraphQL */ `
  mutation UpdateInterventionContentRelation(
    $input: UpdateInterventionContentRelationInput!
    $condition: ModelInterventionContentRelationConditionInput
  ) {
    updateInterventionContentRelation(input: $input, condition: $condition) {
      id
      interventionID
      contentID
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      content {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventions {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            contentID
            contentTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteInterventionContentRelation = /* GraphQL */ `
  mutation DeleteInterventionContentRelation(
    $input: DeleteInterventionContentRelationInput!
    $condition: ModelInterventionContentRelationConditionInput
  ) {
    deleteInterventionContentRelation(input: $input, condition: $condition) {
      id
      interventionID
      contentID
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      content {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventions {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            contentID
            contentTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createInterventionInterventionTagRelation = /* GraphQL */ `
  mutation CreateInterventionInterventionTagRelation(
    $input: CreateInterventionInterventionTagRelationInput!
    $condition: ModelInterventionInterventionTagRelationConditionInput
  ) {
    createInterventionInterventionTagRelation(
      input: $input
      condition: $condition
    ) {
      id
      interventionID
      interventionTagID
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      interventionTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        interventions {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateInterventionInterventionTagRelation = /* GraphQL */ `
  mutation UpdateInterventionInterventionTagRelation(
    $input: UpdateInterventionInterventionTagRelationInput!
    $condition: ModelInterventionInterventionTagRelationConditionInput
  ) {
    updateInterventionInterventionTagRelation(
      input: $input
      condition: $condition
    ) {
      id
      interventionID
      interventionTagID
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      interventionTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        interventions {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteInterventionInterventionTagRelation = /* GraphQL */ `
  mutation DeleteInterventionInterventionTagRelation(
    $input: DeleteInterventionInterventionTagRelationInput!
    $condition: ModelInterventionInterventionTagRelationConditionInput
  ) {
    deleteInterventionInterventionTagRelation(
      input: $input
      condition: $condition
    ) {
      id
      interventionID
      interventionTagID
      intervention {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventionType
        contents {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveys {
          items {
            surveyType
            schemeVersion
            id
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
            interventionSurveysId
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        levels {
          items {
            id
            levelID
            interventionID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      interventionTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        interventions {
          items {
            id
            interventionID
            interventionTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createContentContentTagRelation = /* GraphQL */ `
  mutation CreateContentContentTagRelation(
    $input: CreateContentContentTagRelationInput!
    $condition: ModelContentContentTagRelationConditionInput
  ) {
    createContentContentTagRelation(input: $input, condition: $condition) {
      id
      contentID
      contentTagID
      content {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventions {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            contentID
            contentTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      contentTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        contents {
          items {
            id
            contentID
            contentTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateContentContentTagRelation = /* GraphQL */ `
  mutation UpdateContentContentTagRelation(
    $input: UpdateContentContentTagRelationInput!
    $condition: ModelContentContentTagRelationConditionInput
  ) {
    updateContentContentTagRelation(input: $input, condition: $condition) {
      id
      contentID
      contentTagID
      content {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventions {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            contentID
            contentTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      contentTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        contents {
          items {
            id
            contentID
            contentTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteContentContentTagRelation = /* GraphQL */ `
  mutation DeleteContentContentTagRelation(
    $input: DeleteContentContentTagRelationInput!
    $condition: ModelContentContentTagRelationConditionInput
  ) {
    deleteContentContentTagRelation(input: $input, condition: $condition) {
      id
      contentID
      contentTagID
      content {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventions {
          items {
            id
            interventionID
            contentID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        tags {
          items {
            id
            contentID
            contentTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      contentTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        contents {
          items {
            id
            contentID
            contentTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const createSurveySurveyTagRelation = /* GraphQL */ `
  mutation CreateSurveySurveyTagRelation(
    $input: CreateSurveySurveyTagRelationInput!
    $condition: ModelSurveySurveyTagRelationConditionInput
  ) {
    createSurveySurveyTagRelation(input: $input, condition: $condition) {
      id
      surveyID
      surveyTagID
      survey {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        questions {
          id
          text {
            languageKeys
            languageTexts
          }
          type
          questionOptions {
            id
            followUpQuestionID
          }
          isFollowUpQuestion
        }
        tags {
          items {
            id
            surveyID
            surveyTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveyType
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        interventionSurveysId
      }
      surveyTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        surveys {
          items {
            id
            surveyID
            surveyTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const updateSurveySurveyTagRelation = /* GraphQL */ `
  mutation UpdateSurveySurveyTagRelation(
    $input: UpdateSurveySurveyTagRelationInput!
    $condition: ModelSurveySurveyTagRelationConditionInput
  ) {
    updateSurveySurveyTagRelation(input: $input, condition: $condition) {
      id
      surveyID
      surveyTagID
      survey {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        questions {
          id
          text {
            languageKeys
            languageTexts
          }
          type
          questionOptions {
            id
            followUpQuestionID
          }
          isFollowUpQuestion
        }
        tags {
          items {
            id
            surveyID
            surveyTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveyType
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        interventionSurveysId
      }
      surveyTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        surveys {
          items {
            id
            surveyID
            surveyTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const deleteSurveySurveyTagRelation = /* GraphQL */ `
  mutation DeleteSurveySurveyTagRelation(
    $input: DeleteSurveySurveyTagRelationInput!
    $condition: ModelSurveySurveyTagRelationConditionInput
  ) {
    deleteSurveySurveyTagRelation(input: $input, condition: $condition) {
      id
      surveyID
      surveyTagID
      survey {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        intervention {
          name {
            languageKeys
            languageTexts
          }
          description {
            languageKeys
            languageTexts
          }
          interventionType
          contents {
            nextToken
            startedAt
          }
          surveys {
            nextToken
            startedAt
          }
          tags {
            nextToken
            startedAt
          }
          schemeVersion
          levels {
            nextToken
            startedAt
          }
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        questions {
          id
          text {
            languageKeys
            languageTexts
          }
          type
          questionOptions {
            id
            followUpQuestionID
          }
          isFollowUpQuestion
        }
        tags {
          items {
            id
            surveyID
            surveyTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        surveyType
        schemeVersion
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
        interventionSurveysId
      }
      surveyTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        surveys {
          items {
            id
            surveyID
            surveyTagID
            createdAt
            updatedAt
            _version
            _deleted
            _lastChangedAt
          }
          nextToken
          startedAt
        }
        id
        createdAt
        updatedAt
        _version
        _deleted
        _lastChangedAt
      }
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
