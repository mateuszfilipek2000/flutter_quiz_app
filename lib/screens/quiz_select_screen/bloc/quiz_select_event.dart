import 'package:equatable/equatable.dart';

abstract class QuizSelectionEvent {
  const QuizSelectionEvent();
}

class QuizSelectionButtonPressed extends QuizSelectionEvent {
  const QuizSelectionButtonPressed();
}

class QuizSelectionFinishedChoosing extends QuizSelectionEvent {
  const QuizSelectionFinishedChoosing();
}
