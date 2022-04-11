abstract class QuizDetailsEvent {
  const QuizDetailsEvent();
}

class QuizDetailsNextQuestion extends QuizDetailsEvent {
  const QuizDetailsNextQuestion();
}

class QuizDetailsPreviousQuestion extends QuizDetailsEvent {
  const QuizDetailsPreviousQuestion();
}
