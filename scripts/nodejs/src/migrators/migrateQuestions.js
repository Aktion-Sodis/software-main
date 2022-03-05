import * as mutations from '../graphql/mutations.js';

const listQuestionOptions = `
    SELECT *
    FROM question
    LEFT JOIN survey_section
        ON survey_section.id=question.survey_section_id
    LEFT JOIN survey_header
        ON survey_header.id=survey_section.survey_header_id;
    `;

        
const migrateQuestions = async (sqlPool) => {
    const oldQuestions = await sqlPool.query(listQuestionOptions, function (err, result, fields) {
        if (err) throw err;
        return Object.values(result);
    });

    for (let oldQuestion of oldQuestions){
        const newQuestion = {
            id: oldQuestion.id,
            text: oldQuestion.question_name
        }
        try {
            const newQuestionEntry = await API.graphql({
                query: mutations.createQuestion, // missing in graph-QL api?
                variables: {input: newQuestion}
            })
            console.log("Created question" + JSON.stringify(newQuestionEntry));
            
        } catch (error) {
            console.log("Error writing question option" + JSON.stringify(newQuestionOption) + error);
        }
    }   
}

export default migrateQuestions;