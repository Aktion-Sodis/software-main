/* eslint-disable */
// this is an auto generated file. This will be overwritten

export const getUser = /* GraphQL */ `
  query GetUser($id: ID!) {
    getUser(id: $id) {
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
export const listUsers = /* GraphQL */ `
  query ListUsers(
    $filter: ModelUserFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listUsers(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const syncUsers = /* GraphQL */ `
  query SyncUsers(
    $filter: ModelUserFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncUsers(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const getConfig = /* GraphQL */ `
  query GetConfig($id: ID!) {
    getConfig(id: $id) {
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
export const listConfigs = /* GraphQL */ `
  query ListConfigs(
    $filter: ModelConfigFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listConfigs(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const syncConfigs = /* GraphQL */ `
  query SyncConfigs(
    $filter: ModelConfigFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncConfigs(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const getLevel = /* GraphQL */ `
  query GetLevel($id: ID!) {
    getLevel(id: $id) {
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
  }
`;
export const listLevels = /* GraphQL */ `
  query ListLevels(
    $filter: ModelLevelFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listLevels(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const syncLevels = /* GraphQL */ `
  query SyncLevels(
    $filter: ModelLevelFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncLevels(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const getIntervention = /* GraphQL */ `
  query GetIntervention($id: ID!) {
    getIntervention(id: $id) {
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
  }
`;
export const listInterventions = /* GraphQL */ `
  query ListInterventions(
    $filter: ModelInterventionFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listInterventions(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const syncInterventions = /* GraphQL */ `
  query SyncInterventions(
    $filter: ModelInterventionFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncInterventions(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const getContent = /* GraphQL */ `
  query GetContent($id: ID!) {
    getContent(id: $id) {
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
  }
`;
export const listContents = /* GraphQL */ `
  query ListContents(
    $filter: ModelContentFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listContents(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventions {
          nextToken
          startedAt
        }
        tags {
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
      nextToken
      startedAt
    }
  }
`;
export const syncContents = /* GraphQL */ `
  query SyncContents(
    $filter: ModelContentFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncContents(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
        name {
          languageKeys
          languageTexts
        }
        description {
          languageKeys
          languageTexts
        }
        interventions {
          nextToken
          startedAt
        }
        tags {
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
      nextToken
      startedAt
    }
  }
`;
export const getSurvey = /* GraphQL */ `
  query GetSurvey($id: ID!) {
    getSurvey(id: $id) {
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
  }
`;
export const listSurveys = /* GraphQL */ `
  query ListSurveys(
    $filter: ModelSurveyFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listSurveys(filter: $filter, limit: $limit, nextToken: $nextToken) {
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
  }
`;
export const syncSurveys = /* GraphQL */ `
  query SyncSurveys(
    $filter: ModelSurveyFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncSurveys(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
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
  }
`;
export const getEntity = /* GraphQL */ `
  query GetEntity($id: ID!) {
    getEntity(id: $id) {
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
  }
`;
export const listEntities = /* GraphQL */ `
  query ListEntities(
    $filter: ModelEntityFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listEntities(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const syncEntities = /* GraphQL */ `
  query SyncEntities(
    $filter: ModelEntityFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncEntities(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const getAppliedIntervention = /* GraphQL */ `
  query GetAppliedIntervention($id: ID!) {
    getAppliedIntervention(id: $id) {
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
  }
`;
export const listAppliedInterventions = /* GraphQL */ `
  query ListAppliedInterventions(
    $filter: ModelAppliedInterventionFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listAppliedInterventions(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
    ) {
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
  }
`;
export const syncAppliedInterventions = /* GraphQL */ `
  query SyncAppliedInterventions(
    $filter: ModelAppliedInterventionFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncAppliedInterventions(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
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
  }
`;
export const getExecutedSurvey = /* GraphQL */ `
  query GetExecutedSurvey($id: ID!) {
    getExecutedSurvey(id: $id) {
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
  }
`;
export const listExecutedSurveys = /* GraphQL */ `
  query ListExecutedSurveys(
    $filter: ModelExecutedSurveyFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listExecutedSurveys(filter: $filter, limit: $limit, nextToken: $nextToken) {
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
  }
`;
export const syncExecutedSurveys = /* GraphQL */ `
  query SyncExecutedSurveys(
    $filter: ModelExecutedSurveyFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncExecutedSurveys(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
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
  }
`;
export const getTask = /* GraphQL */ `
  query GetTask($id: ID!) {
    getTask(id: $id) {
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
      executedSurvey {
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
export const listTasks = /* GraphQL */ `
  query ListTasks(
    $filter: ModelTaskFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listTasks(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
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
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        entity {
          parentEntityID
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
      nextToken
      startedAt
    }
  }
`;
export const syncTasks = /* GraphQL */ `
  query SyncTasks(
    $filter: ModelTaskFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncTasks(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
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
          schemeVersion
          id
          createdAt
          updatedAt
          _version
          _deleted
          _lastChangedAt
        }
        entity {
          parentEntityID
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
      nextToken
      startedAt
    }
  }
`;
export const getContentTag = /* GraphQL */ `
  query GetContentTag($id: ID!) {
    getContentTag(id: $id) {
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
  }
`;
export const listContentTags = /* GraphQL */ `
  query ListContentTags(
    $filter: ModelContentTagFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listContentTags(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        contents {
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
      nextToken
      startedAt
    }
  }
`;
export const syncContentTags = /* GraphQL */ `
  query SyncContentTags(
    $filter: ModelContentTagFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncContentTags(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        contents {
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
      nextToken
      startedAt
    }
  }
`;
export const getInterventionTag = /* GraphQL */ `
  query GetInterventionTag($id: ID!) {
    getInterventionTag(id: $id) {
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
  }
`;
export const listInterventionTags = /* GraphQL */ `
  query ListInterventionTags(
    $filter: ModelInterventionTagFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listInterventionTags(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
    ) {
      items {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        interventions {
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
      nextToken
      startedAt
    }
  }
`;
export const syncInterventionTags = /* GraphQL */ `
  query SyncInterventionTags(
    $filter: ModelInterventionTagFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncInterventionTags(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        interventions {
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
      nextToken
      startedAt
    }
  }
`;
export const getSurveyTag = /* GraphQL */ `
  query GetSurveyTag($id: ID!) {
    getSurveyTag(id: $id) {
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
  }
`;
export const listSurveyTags = /* GraphQL */ `
  query ListSurveyTags(
    $filter: ModelSurveyTagFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listSurveyTags(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        surveys {
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
      nextToken
      startedAt
    }
  }
`;
export const syncSurveyTags = /* GraphQL */ `
  query SyncSurveyTags(
    $filter: ModelSurveyTagFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncSurveyTags(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        surveys {
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
      nextToken
      startedAt
    }
  }
`;
export const getSessionData = /* GraphQL */ `
  query GetSessionData($id: ID!) {
    getSessionData(id: $id) {
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
export const listSessionData = /* GraphQL */ `
  query ListSessionData(
    $filter: ModelSessionDataFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listSessionData(filter: $filter, limit: $limit, nextToken: $nextToken) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const syncSessionData = /* GraphQL */ `
  query SyncSessionData(
    $filter: ModelSessionDataFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncSessionData(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
      items {
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
      nextToken
      startedAt
    }
  }
`;
export const getLevelInterventionRelation = /* GraphQL */ `
  query GetLevelInterventionRelation($id: ID!) {
    getLevelInterventionRelation(id: $id) {
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
      createdAt
      updatedAt
      _version
      _deleted
      _lastChangedAt
    }
  }
`;
export const listLevelInterventionRelations = /* GraphQL */ `
  query ListLevelInterventionRelations(
    $filter: ModelLevelInterventionRelationFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listLevelInterventionRelations(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
    ) {
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
  }
`;
export const syncLevelInterventionRelations = /* GraphQL */ `
  query SyncLevelInterventionRelations(
    $filter: ModelLevelInterventionRelationFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncLevelInterventionRelations(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
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
  }
`;
export const getInterventionContentRelation = /* GraphQL */ `
  query GetInterventionContentRelation($id: ID!) {
    getInterventionContentRelation(id: $id) {
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
          nextToken
          startedAt
        }
        tags {
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
export const listInterventionContentRelations = /* GraphQL */ `
  query ListInterventionContentRelations(
    $filter: ModelInterventionContentRelationFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listInterventionContentRelations(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
    ) {
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
  }
`;
export const syncInterventionContentRelations = /* GraphQL */ `
  query SyncInterventionContentRelations(
    $filter: ModelInterventionContentRelationFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncInterventionContentRelations(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
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
  }
`;
export const getInterventionInterventionTagRelation = /* GraphQL */ `
  query GetInterventionInterventionTagRelation($id: ID!) {
    getInterventionInterventionTagRelation(id: $id) {
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
      interventionTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        interventions {
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
export const listInterventionInterventionTagRelations = /* GraphQL */ `
  query ListInterventionInterventionTagRelations(
    $filter: ModelInterventionInterventionTagRelationFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listInterventionInterventionTagRelations(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
    ) {
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
  }
`;
export const syncInterventionInterventionTagRelations = /* GraphQL */ `
  query SyncInterventionInterventionTagRelations(
    $filter: ModelInterventionInterventionTagRelationFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncInterventionInterventionTagRelations(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
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
  }
`;
export const getContentContentTagRelation = /* GraphQL */ `
  query GetContentContentTagRelation($id: ID!) {
    getContentContentTagRelation(id: $id) {
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
          nextToken
          startedAt
        }
        tags {
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
export const listContentContentTagRelations = /* GraphQL */ `
  query ListContentContentTagRelations(
    $filter: ModelContentContentTagRelationFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listContentContentTagRelations(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
    ) {
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
  }
`;
export const syncContentContentTagRelations = /* GraphQL */ `
  query SyncContentContentTagRelations(
    $filter: ModelContentContentTagRelationFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncContentContentTagRelations(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
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
  }
`;
export const getSurveySurveyTagRelation = /* GraphQL */ `
  query GetSurveySurveyTagRelation($id: ID!) {
    getSurveySurveyTagRelation(id: $id) {
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
      surveyTag {
        text {
          languageKeys
          languageTexts
        }
        schemeVersion
        surveys {
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
export const listSurveySurveyTagRelations = /* GraphQL */ `
  query ListSurveySurveyTagRelations(
    $filter: ModelSurveySurveyTagRelationFilterInput
    $limit: Int
    $nextToken: String
  ) {
    listSurveySurveyTagRelations(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
    ) {
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
  }
`;
export const syncSurveySurveyTagRelations = /* GraphQL */ `
  query SyncSurveySurveyTagRelations(
    $filter: ModelSurveySurveyTagRelationFilterInput
    $limit: Int
    $nextToken: String
    $lastSync: AWSTimestamp
  ) {
    syncSurveySurveyTagRelations(
      filter: $filter
      limit: $limit
      nextToken: $nextToken
      lastSync: $lastSync
    ) {
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
  }
`;
