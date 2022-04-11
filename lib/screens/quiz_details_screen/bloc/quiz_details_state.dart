import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_quiz_app/models/question_model.dart';

enum QuizQuestionDetailsStatus { start, normal, end }

abstract class QuizDetailsState extends Equatable {
  const QuizDetailsState();

  @override
  List<Object> get props => [];
}

class QuizDetailsQuestionDetails extends QuizDetailsState {
  const QuizDetailsQuestionDetails(
      this.question, this.questionIndex, this.status);

  final Question question;
  final int questionIndex;
  final QuizQuestionDetailsStatus status;

  @override
  List<Object> get props => [question, questionIndex, status];
}

class QuizDetailsFinish extends QuizDetailsState {
  const QuizDetailsFinish();
}
