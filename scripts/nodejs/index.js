import Amplify, { API, Auth } from "aws-amplify";
import * as queries from "./src/graphql/queries.js";
import * as mutations from "./src/graphql/mutations.js";
import dotenv from "dotenv";
import awsconfig from "./src/aws-exports.js";
import mysql from "mysql";
import mlString from "./src/utils/stringFormatter.js";
import * as schema from "./src/models/index.js";
import uuid from "uuid";

import createTestSurvey from "./src/migrators/createTestSurvey.js";
import createBaseLevels from "./src/migrators/createBaseLevels.js";
import migrateVillages from "./src/migrators/migrateVillages.js";
import {
  deleteAppliedInterventions,
  deleteLevels,
  deleteEntities,
} from "./src/utils/deleteUtils.js";
import createMigrationUser from "./src/migrators/createMigrationUser.js";
import migrateFamilies from "./src/migrators/migrateFamilies.js";
import migrateAppliedInterventions from "./src/migrators/migrateAppliedInterventions.js";
import migrateQuestionOptions from "./src/migrators/migrateQuestionOptions.js";
import migrateSurveys from "./src/migrators/migrateSurveys.js";
import migrateProjects from "./src/migrators/migrateProjects.js";
import migrateExecutedSurveys from "./src/migrators/migrateExecutedSurveys.js";
import createConfigMigrator from "./src/migrators/createConfig.js";
import createMigratorTag from "./src/migrators/createMigratorTag.js";
import createLevelToInterventionConnections from "./src/migrators/createLevelToInterventionConnections.js";
import createTestEntities from "./src/migrators/createTestEntities.js";
import uploadTestFiles from "./src/migrators/uploadTestFiles.js";
import migrateProjectData from "./src/migrators/migrateProjectData.js";

import {initializeApp, cert} from 'firebase-admin/app';
import { getStorage } from "firebase-admin/storage";
import serviceAccount from './service-account.json' assert {type: "json"};
//import * as AWS from ""

initializeApp({
  credential: cert(serviceAccount),
  storageBucket: 'aktion-sodis.appspot.com'
});

const googleCloudBucket = getStorage().bucket();

Amplify.default.configure(awsconfig);


dotenv.config();

console.log(
  `Initializing migration of data from ${process.env.MARIADB_HOST} ${process.env.MARIADB_DBNAME} to AWS amplify storage.`
);

// Initializes connection to (local) MYSQL database from app version 1.
const sqlPool = mysql.createPool({
  host: process.env.MARIADB_HOST,
  user: process.env.MARIADB_USER,
  password: process.env.MARIADB_KEY,
  database: process.env.MARIADB_DBNAME,
  connectionLimit: 10,
});

await createMigratorTag();

console.log("create/update config");
//const config = await createConfigMigrator();

console.log(
  "Creating a single default user, assigned to all migrated data from version 1..."
);
const defaultUser = await createMigrationUser([]);
//bis hierher passt es

// response = await API.graphql({ query: queries.listLevels, variables: { filter: { name: { eq: "village" } } } });
// const villageLevel = filterUndeleted(response.data.listLevels.items).at(-1);
// console.log("Village level id is:" + JSON.stringify(villageLevel));

// const familyLevel = await API.graphql({ query: queries.listLevels, variables: {filter: {name: {eq: "family"}}}}).data.listLevels.items.at(-1);
// console.log("Family level id is:" + JSON.stringify(familyLevel));

console.log("Creating interventions...");
const allInterventions = await migrateProjects(sqlPool);

//bis hierher läuft es

//todo: integrate question and question Options

//todo: pass supportedInterventions to family Level
console.log(
  "Creating new base levels for villageEntity and familyEntity and retrieve ids..."
);

let responseTwo = await createBaseLevels();
const { villageLevel, familyLevel } = responseTwo;

console.log("levels created");

//todo: create level to project connections

await createLevelToInterventionConnections(familyLevel);

console.log("levelinterventionconnections created");

//await createTestEntities(villageLevel, familyLevel);

//console.log("test entities created");

//await createTestSurvey();

//console.log("test survey created");

//console.log("InterventionLevel connections drawn");

//läuft bis hier her

//  TODO: das muss mit in die survey migration 
//console.log("Migrating question options...");
//migrateQuestionOptions(sqlPool);

console.log("Migrating surveys...");
const allSurveys = await migrateSurveys(sqlPool);
console.log('allSurveysLength: ' + allSurveys.length.toString());
console.log(allSurveys[0]);
console.log("Migrating Entities, AppliedInterventions and ExecutedSurveys");

const allProjectData = await migrateProjectData(sqlPool, familyLevel, villageLevel, allSurveys, defaultUser);

console.log("Finished");