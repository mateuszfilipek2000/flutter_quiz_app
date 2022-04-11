import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_event.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_state.dart';

class QuizDetailsBloc extends Bloc<QuizDetailsEvent, QuizDetailsState> {
  QuizDetailsBloc({
    required Quiz quiz,
  })  : _quiz = quiz,
        super(QuizDetailsQuestionDetails(
            quiz.questions[0], 0, QuizQuestionDetailsStatus.start)) {
    on<QuizDetailsNextQuestion>((event, emit) {
      if (state is QuizDetailsQuestionDetails) {
        int index = (state as QuizDetailsQuestionDetails).questionIndex;
        QuizQuestionDetailsStatus status =
            index + 1 == _quiz.questions.length - 1
                ? QuizQuestionDetailsStatus.end
                : QuizQuestionDetailsStatus.normal;
        emit(QuizDetailsQuestionDetails(
            _quiz.questions[index + 1], index + 1, status));
      }
    });
    on<QuizDetailsPreviousQuestion>((event, emit) {
      if (state is QuizDetailsQuestionDetails) {
        int index = (state as QuizDetailsQuestionDetails).questionIndex;
        QuizQuestionDetailsStatus status = index - 1 == 0
            ? QuizQuestionDetailsStatus.start
            : QuizQuestionDetailsStatus.normal;
        emit(QuizDetailsQuestionDetails(
            _quiz.questions[index - 1], index - 1, status));
      }
    });
  }

  final Quiz _quiz;
}
