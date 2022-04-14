import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_bloc/quiz_details_event.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_bloc/quiz_details_state.dart';

class QuizDetailsBloc extends Bloc<QuizDetailsEvent, QuizDetailsState> {
  QuizDetailsBloc({
    required Quiz quiz,
  })  : _quiz = quiz,
        answers =
            List<List<int>>.generate(quiz.questions.length, (index) => []),
        super(QuizDetailsQuestionDetails(
            quiz.questions[0], 0, QuizQuestionDetailsStatus.start)) {
    on<QuizDetailsNextQuestion>((event, emit) {
      if (state is QuizDetailsQuestionDetails) {
        int index = (state as QuizDetailsQuestionDetails).questionIndex;
        QuizQuestionDetailsStatus status =
            index + 1 == _quiz.questions.length - 1
                ? QuizQuestionDetailsStatus.end
                : QuizQuestionDetailsStatus.normal;
        answers[index] = (state as QuizDetailsQuestionDetails).selectedAnswers;
        emit(
          QuizDetailsQuestionDetails(
            _quiz.questions[index + 1],
            index + 1,
            status,
            selectedAnswers: answers[index + 1],
          ),
        );
      }
    });
    on<QuizDetailsPreviousQuestion>((event, emit) {
      if (state is QuizDetailsQuestionDetails) {
        int index = (state as QuizDetailsQuestionDetails).questionIndex;
        QuizQuestionDetailsStatus status = index - 1 == 0
            ? QuizQuestionDetailsStatus.start
            : QuizQuestionDetailsStatus.normal;

        answers[index] = (state as QuizDetailsQuestionDetails).selectedAnswers;
        emit(QuizDetailsQuestionDetails(
          _quiz.questions[index - 1],
          index - 1,
          status,
          selectedAnswers: answers[index - 1],
        ));
      }
    });
    on<QuizDetailsChangeCheckAnswer>((event, emit) {
      if (state is QuizDetailsQuestionDetails) {
        List<int> selectedAnswers = (state as QuizDetailsQuestionDetails)
            .selectedAnswers
            .map((e) => e)
            .toList();
        if ((state as QuizDetailsQuestionDetails)
            .selectedAnswers
            .contains(event.answerIndex)) {
          emit((state as QuizDetailsQuestionDetails).copyWith(
              selectedAnswers: selectedAnswers..remove(event.answerIndex)));
        } else {
          emit((state as QuizDetailsQuestionDetails).copyWith(
              selectedAnswers: selectedAnswers..add(event.answerIndex)));
        }
      }
    });
    on<QuizDetailsFinishQuiz>((event, emit) {
      if (state is QuizDetailsQuestionDetails) {
        int index = (state as QuizDetailsQuestionDetails).questionIndex;
        answers[index] = (state as QuizDetailsQuestionDetails).selectedAnswers;

        emit(QuizDetailsFinished(quiz, answers));
      }
    });
  }

  final Quiz _quiz;
  late final List<List<int>> answers;
}
