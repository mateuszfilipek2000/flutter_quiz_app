import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_quiz_app/models/question_model.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';

enum QuizQuestionDetailsStatus { start, normal, end }

abstract class QuizDetailsState extends Equatable {
  const QuizDetailsState();

  @override
  List<Object> get props => [];
}

class QuizDetailsQuestionDetails extends QuizDetailsState {
  const QuizDetailsQuestionDetails(
    this.question,
    this.questionIndex,
    this.status, {
    this.selectedAnswers = const [],
  });

  final Question question;
  final int questionIndex;
  final QuizQuestionDetailsStatus status;
  final List<int> selectedAnswers;

  @override
  List<Object> get props => [question, questionIndex, status, selectedAnswers];

  QuizDetailsQuestionDetails copyWith({
    Question? question,
    int? questionIndex,
    QuizQuestionDetailsStatus? status,
    List<int>? selectedAnswers,
  }) {
    return QuizDetailsQuestionDetails(
      question ?? this.question,
      questionIndex ?? this.questionIndex,
      status ?? this.status,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }
}

class QuizDetailsFinished extends QuizDetailsQuestionDetails {
  const QuizDetailsFinished(this.quiz, this.userAnswers, question,
      questionIndex, status, selectedAnswers)
      : super(question, questionIndex, status,
            selectedAnswers: selectedAnswers);

  final List<List<int>> userAnswers;
  final Quiz quiz;
}
