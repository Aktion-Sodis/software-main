import * as mutations from "../graphql/mutations.js";

const listQuestionOptions = `
    SELECT
        question_option.id AS id,
        option_choice_name AS text,
        dependent_question_id,
    FROM question_option
    JOIN option_choice
        ON option_choice.id=question_option.option_choice_id;
    `;

const migrateQuestionOptions = async (sqlPool) => {
  const oldQuestionOptions = await sqlPool.query(
    listQuestionOptions,
    function (err, result, fields) {
      if (err) throw err;
      return Object.values(result);
    }
  );

  for (let oldQuestionOption of oldQuestionOptions) {
    const newQuestionOption = {
      id: oldQuestionOption.id,
      text: oldQuestionOption.text,
      followUpQuestionID: oldQuestionOption.dependent_question_id,
    };
    try {
      const newQuestionOptionEntry = await API.graphql({
        query: mutations.createQuestionOption, // missing in graph-QL api?
        variables: { input: newQuestionOption },
      });
      console.log(
        "Created question option" + JSON.stringify(newQuestionOptionEntry)
      );
    } catch (error) {
      console.log(
        "Error writing question option" +
          JSON.stringify(newQuestionOption) +
          error
      );
    }
  }
};

export default migrateQuestionOptions;
