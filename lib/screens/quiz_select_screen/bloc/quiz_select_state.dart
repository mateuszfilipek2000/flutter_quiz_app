import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';

// enum QuizSelectionStatus { initial, inProgress, success, failure }

abstract class QuizSelectionState {
  const QuizSelectionState();
}

class QuizSelectionInitial extends QuizSelectionState {
  const QuizSelectionInitial();
}

class QuizSelectionInProgress extends QuizSelectionState {
  const QuizSelectionInProgress();
}

class QuizSelectionSuccess extends QuizSelectionState {
  const QuizSelectionSuccess(this.quiz);

  final Quiz quiz;
}

class QuizSelectionFailure extends QuizSelectionState {
  const QuizSelectionFailure();
}
