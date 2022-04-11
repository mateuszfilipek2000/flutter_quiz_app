import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_quiz_app/data/quiz_repository.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_event.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_state.dart';

class QuizSelectionBloc extends Bloc<QuizSelectionEvent, QuizSelectionState> {
  QuizSelectionBloc({
    required QuizRepository quizRepository,
  })  : _quizRepository = quizRepository,
        super(const QuizSelectionInitial()) {
    on<QuizSelectionButtonPressed>(_onQuizSelectionButtonPressed);
    on<QuizSelectionFinishedChoosing>(_onQuizSelectionFinishedChoosing);
  }

  final QuizRepository _quizRepository;

  void _onQuizSelectionButtonPressed(
    QuizSelectionButtonPressed event,
    Emitter<QuizSelectionState> emit,
  ) async {
    emit(const QuizSelectionInProgress());
    // _quizRepository.getQuiz();

    Quiz? quiz = await _quizRepository.getQuiz();
    if (quiz != null) {
      emit(QuizSelectionSuccess(quiz));
    } else {
      emit(const QuizSelectionFailure());
    }
  }

  void _onQuizSelectionFinishedChoosing(
    QuizSelectionFinishedChoosing event,
    Emitter<QuizSelectionState> emit,
  ) async {
    Quiz? quiz = await _quizRepository.getQuiz();
    if (quiz != null) {
      emit(QuizSelectionSuccess(quiz));
    } else {
      emit(const QuizSelectionFailure());
    }
  }
}
