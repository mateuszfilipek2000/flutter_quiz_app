import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_bloc.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_event.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_state.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_results_screen/ui/quiz_results_screen.dart';

class QuizDetailsScreen extends StatelessWidget {
  static const routeName = 'QuizDetailsScreen';
  const QuizDetailsScreen({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => QuizDetailsBloc(quiz: quiz),
        child: BlocListener<QuizDetailsBloc, QuizDetailsState>(
          listener: (context, state) {
            if (state is QuizDetailsFinished) {
              Navigator.of(context)
                  .pushNamed(QuizResultsScreen.routeName, arguments: {
                'user_answers': state.userAnswers,
                'quiz': state.quiz,
              });
            }
          },
          child: BlocBuilder<QuizDetailsBloc, QuizDetailsState>(
            builder: (context, state) {
              if (state is QuizDetailsQuestionDetails) {
                return Column(
                  children: [
                    Text(state.question.content),
                    ElevatedButton(
                      onPressed: state.status == QuizQuestionDetailsStatus.start
                          ? null
                          : () => context
                              .read<QuizDetailsBloc>()
                              .add(const QuizDetailsPreviousQuestion()),
                      child: const Text("Previous Question"),
                    ),
                    ElevatedButton(
                      onPressed: state.status == QuizQuestionDetailsStatus.end
                          ? () => context
                              .read<QuizDetailsBloc>()
                              .add(const QuizDetailsFinishQuiz())
                          : () => context
                              .read<QuizDetailsBloc>()
                              .add(const QuizDetailsNextQuestion()),
                      child: state.status == QuizQuestionDetailsStatus.end
                          ? const Text("Finish Quiz")
                          : const Text("Next Question"),
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.question.answers.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: state.selectedAnswers.contains(index),
                          onChanged: (_) => context.read<QuizDetailsBloc>().add(
                                QuizDetailsChangeCheckAnswer(index),
                              ),
                          title: Text(state.question.answers[index].content),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
