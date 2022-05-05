import queryResult from "../utils/awaitableQuery.js";
import mlString from "../utils/stringFormatter.js";
import * as mutations from "../graphql/mutations.js";
import * as queries from "../graphql/queries.js";
import { API, graphqlOperation } from "aws-amplify";
import { QuestionType } from "../models/index.js";

const migrateProjectData = async (sqlPool, familyLevel, villageLevel, surveys, user) => {
    console.log("survey count main: " + surveys.length);
    const villages = await allVillages(sqlPool, villageLevel);
    const families = await allFamilies(sqlPool, familyLevel);
    console.log("entities created");
    var promises = [];
    for(const family of families) {
        promises.push(interventionsAndSurveysOfFamily(sqlPool, family, surveys, user));
    }
    const results = await Promise.all(promises);
    return results;
}

///returns all Villages
///fetches when existing, creates if not
const allVillages = async(sqlPool, villageLevel) => {
    const listVillagesQuery = "SELECT * FROM village;";
    const oldVillages = await queryResult(sqlPool, listVillagesQuery);
    var returnVillages = [];
    for(const oldVillage of oldVillages) {
        const explicitQueryResult = await API.graphql({
            query: queries.getEntity,
            variables: {
                id: oldVillage.id
            }
        });
        if(explicitQueryResult.data.getEntity===null) {
            const newVillageObject = {
                id: oldVillage.id.toString(),
                entityLevelId: villageLevel.id,
                name: mlString(oldVillage.name),
                description: mlString(""),
                customData: [],
            }
            const createResult = await API.graphql({
                query: mutations.createEntity,
                variables: {
                    input: newVillageObject
                }
            });
            returnVillages.push(createResult.data.createEntity);
        } else {
            returnVillages.push(explicitQueryResult.data.getEntity);
        }
    }
    return returnVillages;
}

///returns all families
///fetches when existing, create if not
const allFamilies = async(sqlPool, familyLevel) => {
    const listFamiliesQuery = `
    SELECT * 
    FROM interviewee;
    `;

    const oldFamilies = await queryResult(sqlPool, listFamiliesQuery);
    var familiesToReturnPromises = [];
    for(const oldFamily of oldFamilies) {
        familiesToReturnPromises.push(newFamilyOfOldFamily(oldFamily, familyLevel));
        //todo: copy pic
    }
    const familiesToReturn = await Promise.all(familiesToReturnPromises);
    return familiesToReturn;
}

const newFamilyOfOldFamily = async(oldFamily, familyLevel) => {
    const explicitQueryResult = await API.graphql({
        query: queries.getEntity,
        variables: {
            id: oldFamily.id
        }
    });
    if(explicitQueryResult.data.getEntity===null) {
        const newFamilyObject = {
            id: oldFamily.id.toString(),
            entityLevelId: familyLevel.id,
            name: mlString(oldFamily.name),
            description: mlString(""),
            customData: [],
            parentEntityID: oldFamily.village_id.toString()
        }
        const createResult = await API.graphql({
            query: mutations.createEntity,
            variables: {
                input: newFamilyObject
            }
        });
        return createResult.data.createEntity;
    } else {
        return explicitQueryResult.data.getEntity;
    }
}

const interventionsAndSurveysOfFamily = async (sqlPool, family, allSurveys, user) => {
    try {
         var executedSurveys = await allExecutedSurveysWithoutAppliedInterventionOfFamily(sqlPool, family, allSurveys, user);
    //applied intervention ids sind aktuell noch project ids
    var appliedInterventions = [];
    for(var executedSurvey of executedSurveys) {
        const fittingAppliedInterventions = appliedInterventions.filter(e => e.appliedInterventionInterventionId.toString()===executedSurvey.appliedInterventionExecutedSurveysId.toString());
        if(fittingAppliedInterventions.length > 0) {
            executedSurvey.appliedInterventionExecutedSurveysId = fittingAppliedInterventions[0].id;
        } else {
            const toAdd = {
                id: (family.id+"_"+executedSurvey.appliedInterventionExecutedSurveysId.toString()),
                isOkay: true,
                location: executedSurvey.location,
                entityAppliedInterventionsId: family.id,
                appliedInterventionWhoDidItId: user.id,
                appliedInterventionInterventionId: executedSurvey.appliedInterventionExecutedSurveysId
            };
            appliedInterventions.push(toAdd);
            executedSurvey.appliedInterventionExecutedSurveysId = toAdd.id;
        }
    }
    var onlineAppliedInterventions = [];
    var onlineExecutedSurveys = [];
    for(var appliedIntervention of appliedInterventions) {
        try {
            const queryResult = await API.graphql({
            query: queries.getAppliedIntervention,
            variables: {
                id: appliedIntervention.id
            }
        });
        if(queryResult.data.getAppliedIntervention===null) {
            try {
                const createResult = await API.graphql({
                                query: mutations.createAppliedIntervention,
                                variables: {
                                    input: appliedIntervention
                                }
                            });
                            onlineAppliedInterventions.push(createResult.data.createAppliedIntervention);
                        
            }catch(e) {
                console.log("id error in creating applied intervention");
                console.log(e);
            }
            } else {
                try {
                    appliedIntervention._version = queryResult.data.getAppliedIntervention._version;
                                const updateResult = await API.graphql({
                                    query: mutations.updateAppliedIntervention,
                                    variables: {
                                        input: appliedIntervention
                                    }
                                });
                                onlineAppliedInterventions.push(updateResult.data.updateAppliedIntervention);
                            
                }
                catch(e) {
                    console.log("id error in updating applied intervention");
                    console.log(e);
                }
            }
        }catch(e) {
            console.log("id error in querying applied intervention");
            console.log(e);
        }
        
        
    }

    for(var executedSurvey of executedSurveys) {
        try {
            const queryResult = await API.graphql({
                        query: queries.getExecutedSurvey,
                        variables: {
                            id: executedSurvey.id
                        }
                    });
                    if(queryResult.data.getExecutedSurvey===null) {
            try {
                const createResult = await API.graphql({
                                query: mutations.createExecutedSurvey,
                                variables: {
                                    input: executedSurvey
                                }
                            });
                            onlineExecutedSurveys.push(createResult.data.createExecutedSurvey);
            }catch(e) {
                console.log("id erroor in creating executed survey");
                console.log(e);
            }
            
        } else {
            try {
                executedSurvey._version = queryResult.data.getExecutedSurvey._version;
                            const updateResult = await API.graphql({
                                query: mutations.updateExecutedSurvey,
                                variables: {
                                    input: executedSurvey
                                }
                            });
                            onlineExecutedSurveys.push(updateResult.data.updateExecutedSurvey);
            }catch(e) {
                console.log("id error in updating executed Survey");
                console.log(e);
            }
            
        }
        }catch(e) {
            console.log("id error in querying executed Survey");
            console.log(e);
        }
        
        
    }
    return {onlineAppliedInterventions, onlineExecutedSurveys};
    }catch(e) {
        console.log("error in transition");
        console.log(e);
    }
   
}

const allExecutedSurveysWithoutAppliedInterventionOfFamily = async (sqlPool, family, allSurveys, user) => {
    const listExecutedSurveyQuery = `
    SELECT
        *
    FROM completed_survey
    WHERE interviewee_id='${family.id}';
    `;
    const oldExecutedSurveys = await queryResult(sqlPool, listExecutedSurveyQuery);
    var executedSurveysToReturn = [];
    for(const oldExecutedSurvey of oldExecutedSurveys) {
        
        const survey = allSurveys.filter(e => e.id === oldExecutedSurvey.survey_header_id.toString())[0];
        const answers = await answersForExecutedSurvey(sqlPool, oldExecutedSurvey, survey);
        const dateTime = new Date(oldExecutedSurvey.creation_date);
        const toPush = {
            id: oldExecutedSurvey.id.toString(),
            date: dateTime.toISOString(),
            location: {
                latitude: oldExecutedSurvey.latitude,
                longitude: oldExecutedSurvey.longitude
            },
            answers: answers,
            executedSurveySurveyId: oldExecutedSurvey.survey_header_id.toString(),
            executedSurveyWhoExecutedIt: user.id,
            appliedInterventionExecutedSurveysId: survey.interventionSurveysId
        }
        executedSurveysToReturn.push(toPush);
    }
    return executedSurveysToReturn;
}

const answersForExecutedSurvey = async (sqlPool, oldExecutedSurvey, survey) => {
    const answerQuery = `
        SELECT 
            *
        FROM answer
        WHERE completed_survey_id='${oldExecutedSurvey.id}'
    `;
    const oldAnswers = await queryResult(sqlPool, answerQuery);
    var answersToReturn = [];
    for(const oldAnswer of oldAnswers) {
        const dateTime = new Date(oldExecutedSurvey.creation_date);
        const question = survey.questions.filter(e=>e.id === oldAnswer.question_id.toString())[0];
        if(question) {
            var textValue;
            var questionOptions;
            var doubleValue;
            if(question.type===QuestionType.TEXT) {
                textValue = oldAnswer.answer_text;
            } else if (question.type === QuestionType.DOUBLE) {
                doubleValue = parseFloat(oldAnswer.answer_text);
            } else if(question.type===QuestionType.MULTIPLECHOICE) {
                questionOptions = question.questionOptions.filter(e => e.id === oldAnswer.question_option_id.toString());
            } else if (question.type === QuestionType.PICTURE) {
                //todo: copy picture
            }
            const toPush = {
                id: oldAnswer.id.toString(),
                questionID: question.id,
                date: dateTime.toISOString(),
                type: question.type,
                text: textValue,
                doubleValue: doubleValue,
                questionOptions: questionOptions
            };
            answersToReturn.push(toPush);
        }
        else {
            console.log("executed Survey: " + oldExecutedSurvey.id);
            console.log("survey: " + survey.id);
            console.log("question not found: " + oldAnswer.question_id);
        }
    }
    return answersToReturn;
}



export default migrateProjectData;