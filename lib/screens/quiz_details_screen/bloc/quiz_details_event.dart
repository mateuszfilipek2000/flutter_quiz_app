abstract class QuizDetailsEvent {
  const QuizDetailsEvent();
}

class QuizDetailsNextQuestion extends QuizDetailsEvent {
  const QuizDetailsNextQuestion();
}

class QuizDetailsPreviousQuestion extends QuizDetailsEvent {
  const QuizDetailsPreviousQuestion();
}

class QuizDetailsChangeCheckAnswer extends QuizDetailsEvent {
  const QuizDetailsChangeCheckAnswer(this.answerIndex);

  final int answerIndex;
}

class QuizDetailsFinishQuiz extends QuizDetailsEvent {
  const QuizDetailsFinishQuiz();
}
