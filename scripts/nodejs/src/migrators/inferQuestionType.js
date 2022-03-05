export function inferQuestionType(oldQuestion) {
    if (oldQuestion.input_type == "image") {
        return QuestionType.PICTURE;
    }
    if (oldQuestion.input_type == "numeric" || oldQuestion.input_type == "text") {
        return QuestionType.TEXT;
    }
    if (oldQuestion.input_type == "single choice") {
        return QuestionType.SINGLECHOICE;
    }
    return QuestionType.TEXT;
}
