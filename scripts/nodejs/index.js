import Amplify, { API } from "aws-amplify";
import * as queries from './src/graphql/queries.js';
import dotenv from 'dotenv'
import awsconfig from './src/aws-exports.js';
import mysql from 'mysql';

import createBaseLevels from "./src/migrators/createBaseLevels.js"
import migrateVillages from "./src/migrators/migrateVillages.js"
import {deleteAppliedInterventions, deleteLevels} from "./src/utils/deleteUtils.js";
import createMigrationUser from "./src/migrators/createMigrationUser.js";
import migrateFamilies from "./src/migrators/migrateFamilies.js";
import migrateAppliedInterventions from "./src/migrators/migrateAppliedInterventions.js";
import migrateQuestionOptions from "./src/migrators/migrateQuestionOptions.js";
import migrateSurveys from "./src/migrators/migrateSurveys.js";
import migrateProjects from "./src/migrators/migrateProjects.js";
import migrateExecutedSurveys from "./src/migrators/migrateExecutedSurveys.js";
import createConfig from "./src/migrators/createConfig.js";
import createMigratorTag from "./src/migrators/createMigratorTag.js";

Amplify.default.configure(awsconfig);

dotenv.config();

console.log(`Initializing migration of data from ${process.env.MARIADB_HOST} ${process.env.MARIADB_DBNAME} to AWS amplify storage.`);

// Initializes connection to (local) MYSQL database from app version 1.
const sqlPool = mysql.createPool({
    host: process.env.MARIADB_HOST,
    user: process.env.MARIADB_USER,
    password: process.env.MARIADB_KEY,
    database: process.env.MARIADB_DBNAME,
    connectionLimit: 10,
  });


console.log(`Successfully connected to old database ${sqlPool}.`)

console.log("Clean up erroneous writes of villageLevel to remove erroneous entries...")
await deleteLevels();
await deleteAppliedInterventions();

//todo: delete interventions -> haben fixe IDs, also wenn dann updaten
//todo: delete surveys -> haben fixe IDs, also wenn dann updaten
//todo: delte entities -> haben fixe IDs, also wenn dann updaten
//todo: delete executedSurveys -> haben fixe IDs, also wenn dann updaten

await createMigratorTag();
const config = await createConfig();



console.log("Creating a single default user, assigned to all migrated data from version 1...");
const defaultUser = createMigrationUser([]);
//bis hierher passt es


// response = await API.graphql({ query: queries.listLevels, variables: { filter: { name: { eq: "village" } } } });
// const villageLevel = filterUndeleted(response.data.listLevels.items).at(-1);
// console.log("Village level id is:" + JSON.stringify(villageLevel));

// const familyLevel = await API.graphql({ query: queries.listLevels, variables: {filter: {name: {eq: "family"}}}}).data.listLevels.items.at(-1);
// console.log("Family level id is:" + JSON.stringify(familyLevel));




console.log("Creating interventions...");
migrateProjects(sqlPool);
/*

//todo: pass supportedInterventions to family Level
console.log("Creating new base levels for villageEntity and familyEntity and retrieve ids...")
let response = await createBaseLevels();
const {villageLevel, familyLevel} = response;

//todo: integrate question and question Options
console.log("Migrating surveys...");
migrateSurveys(sqlPool);

//  TODO: das muss mit in die survey migration 
//console.log("Migrating question options...");
migrateQuestionOptions(sqlPool);




//todo: check for family wether interventions exist
console.log("Migrating villages...");
migrateVillages(sqlPool, villageLevel);


console.log("Migrating families...");
migrateFamilies(sqlPool, familyLevel);


console.log("Migrating applied interventions...") ;
// Applied interventions are not directly documented in old database schema.
// Application of intervention is infered based on executed surveys.
migrateAppliedInterventions(sqlPool, defaultUser);

//TODO: hier überprüfen -> wurde zuvor zu früh übertragen
console.log("Migrating executed surveys and answers...");
migrateExecutedSurveys(sqlPool, defaultUser);
console.log("Successfully finished migration.");
*/