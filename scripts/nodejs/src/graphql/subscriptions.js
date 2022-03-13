/* eslint-disable */
// this is an auto generated file. This will be overwritten

export const onCreateUser = /* GraphQL */ `
  subscription OnCreateUser {
    onCreateUser {
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
export const onUpdateUser = /* GraphQL */ `
  subscription OnUpdateUser {
    onUpdateUser {
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
export const onDeleteUser = /* GraphQL */ `
  subscription OnDeleteUser {
    onDeleteUser {
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
export const onCreateConfig = /* GraphQL */ `
  subscription OnCreateConfig {
    onCreateConfig {
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
export const onUpdateConfig = /* GraphQL */ `
  subscription OnUpdateConfig {
    onUpdateConfig {
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
export const onDeleteConfig = /* GraphQL */ `
  subscription OnDeleteConfig {
    onDeleteConfig {
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
export const onCreateLevel = /* GraphQL */ `
  subscription OnCreateLevel {
    onCreateLevel {
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
export const onUpdateLevel = /* GraphQL */ `
  subscription OnUpdateLevel {
    onUpdateLevel {
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
export const onDeleteLevel = /* GraphQL */ `
  subscription OnDeleteLevel {
    onDeleteLevel {
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
export const onCreateIntervention = /* GraphQL */ `
  subscription OnCreateIntervention {
    onCreateIntervention {
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
export const onUpdateIntervention = /* GraphQL */ `
  subscription OnUpdateIntervention {
    onUpdateIntervention {
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
export const onDeleteIntervention = /* GraphQL */ `
  subscription OnDeleteIntervention {
    onDeleteIntervention {
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
export const onCreateContent = /* GraphQL */ `
  subscription OnCreateContent {
    onCreateContent {
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
export const onUpdateContent = /* GraphQL */ `
  subscription OnUpdateContent {
    onUpdateContent {
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
export const onDeleteContent = /* GraphQL */ `
  subscription OnDeleteContent {
    onDeleteContent {
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
export const onCreateSurvey = /* GraphQL */ `
  subscription OnCreateSurvey {
    onCreateSurvey {
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
export const onUpdateSurvey = /* GraphQL */ `
  subscription OnUpdateSurvey {
    onUpdateSurvey {
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
export const onDeleteSurvey = /* GraphQL */ `
  subscription OnDeleteSurvey {
    onDeleteSurvey {
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
export const onCreateEntity = /* GraphQL */ `
  subscription OnCreateEntity {
    onCreateEntity {
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
export const onUpdateEntity = /* GraphQL */ `
  subscription OnUpdateEntity {
    onUpdateEntity {
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
export const onDeleteEntity = /* GraphQL */ `
  subscription OnDeleteEntity {
    onDeleteEntity {
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
export const onCreateAppliedIntervention = /* GraphQL */ `
  subscription OnCreateAppliedIntervention {
    onCreateAppliedIntervention {
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
export const onUpdateAppliedIntervention = /* GraphQL */ `
  subscription OnUpdateAppliedIntervention {
    onUpdateAppliedIntervention {
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
export const onDeleteAppliedIntervention = /* GraphQL */ `
  subscription OnDeleteAppliedIntervention {
    onDeleteAppliedIntervention {
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
export const onCreateExecutedSurvey = /* GraphQL */ `
  subscription OnCreateExecutedSurvey {
    onCreateExecutedSurvey {
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
export const onUpdateExecutedSurvey = /* GraphQL */ `
  subscription OnUpdateExecutedSurvey {
    onUpdateExecutedSurvey {
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
export const onDeleteExecutedSurvey = /* GraphQL */ `
  subscription OnDeleteExecutedSurvey {
    onDeleteExecutedSurvey {
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
export const onCreateTask = /* GraphQL */ `
  subscription OnCreateTask {
    onCreateTask {
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
export const onUpdateTask = /* GraphQL */ `
  subscription OnUpdateTask {
    onUpdateTask {
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
export const onDeleteTask = /* GraphQL */ `
  subscription OnDeleteTask {
    onDeleteTask {
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
export const onCreateContentTag = /* GraphQL */ `
  subscription OnCreateContentTag {
    onCreateContentTag {
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
export const onUpdateContentTag = /* GraphQL */ `
  subscription OnUpdateContentTag {
    onUpdateContentTag {
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
export const onDeleteContentTag = /* GraphQL */ `
  subscription OnDeleteContentTag {
    onDeleteContentTag {
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
export const onCreateInterventionTag = /* GraphQL */ `
  subscription OnCreateInterventionTag {
    onCreateInterventionTag {
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
export const onUpdateInterventionTag = /* GraphQL */ `
  subscription OnUpdateInterventionTag {
    onUpdateInterventionTag {
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
export const onDeleteInterventionTag = /* GraphQL */ `
  subscription OnDeleteInterventionTag {
    onDeleteInterventionTag {
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
export const onCreateSurveyTag = /* GraphQL */ `
  subscription OnCreateSurveyTag {
    onCreateSurveyTag {
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
export const onUpdateSurveyTag = /* GraphQL */ `
  subscription OnUpdateSurveyTag {
    onUpdateSurveyTag {
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
export const onDeleteSurveyTag = /* GraphQL */ `
  subscription OnDeleteSurveyTag {
    onDeleteSurveyTag {
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
export const onCreateSessionData = /* GraphQL */ `
  subscription OnCreateSessionData {
    onCreateSessionData {
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
export const onUpdateSessionData = /* GraphQL */ `
  subscription OnUpdateSessionData {
    onUpdateSessionData {
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
export const onDeleteSessionData = /* GraphQL */ `
  subscription OnDeleteSessionData {
    onDeleteSessionData {
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
export const onCreateLevelInterventionRelation = /* GraphQL */ `
  subscription OnCreateLevelInterventionRelation {
    onCreateLevelInterventionRelation {
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
export const onUpdateLevelInterventionRelation = /* GraphQL */ `
  subscription OnUpdateLevelInterventionRelation {
    onUpdateLevelInterventionRelation {
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
export const onDeleteLevelInterventionRelation = /* GraphQL */ `
  subscription OnDeleteLevelInterventionRelation {
    onDeleteLevelInterventionRelation {
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
export const onCreateInterventionContentRelation = /* GraphQL */ `
  subscription OnCreateInterventionContentRelation {
    onCreateInterventionContentRelation {
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
export const onUpdateInterventionContentRelation = /* GraphQL */ `
  subscription OnUpdateInterventionContentRelation {
    onUpdateInterventionContentRelation {
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
export const onDeleteInterventionContentRelation = /* GraphQL */ `
  subscription OnDeleteInterventionContentRelation {
    onDeleteInterventionContentRelation {
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
export const onCreateInterventionInterventionTagRelation = /* GraphQL */ `
  subscription OnCreateInterventionInterventionTagRelation {
    onCreateInterventionInterventionTagRelation {
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
export const onUpdateInterventionInterventionTagRelation = /* GraphQL */ `
  subscription OnUpdateInterventionInterventionTagRelation {
    onUpdateInterventionInterventionTagRelation {
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
export const onDeleteInterventionInterventionTagRelation = /* GraphQL */ `
  subscription OnDeleteInterventionInterventionTagRelation {
    onDeleteInterventionInterventionTagRelation {
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
export const onCreateContentContentTagRelation = /* GraphQL */ `
  subscription OnCreateContentContentTagRelation {
    onCreateContentContentTagRelation {
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
export const onUpdateContentContentTagRelation = /* GraphQL */ `
  subscription OnUpdateContentContentTagRelation {
    onUpdateContentContentTagRelation {
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
export const onDeleteContentContentTagRelation = /* GraphQL */ `
  subscription OnDeleteContentContentTagRelation {
    onDeleteContentContentTagRelation {
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
export const onCreateSurveySurveyTagRelation = /* GraphQL */ `
  subscription OnCreateSurveySurveyTagRelation {
    onCreateSurveySurveyTagRelation {
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
export const onUpdateSurveySurveyTagRelation = /* GraphQL */ `
  subscription OnUpdateSurveySurveyTagRelation {
    onUpdateSurveySurveyTagRelation {
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
export const onDeleteSurveySurveyTagRelation = /* GraphQL */ `
  subscription OnDeleteSurveySurveyTagRelation {
    onDeleteSurveySurveyTagRelation {
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
