import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_bloc.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_event.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_state.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_results_screen/ui/quiz_results_screen.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/ui/quiz_select_screen.dart';

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
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    //TODO PRESERVE ANIMATION STATE DURING HERO TRANSITION
                    const Hero(
                      tag: "AnimatedBackground",
                      child: AnimatedBackground(maxHeightFraction: 0.1),
                    ),
                    Center(
                      child: Card(
                        elevation: 10.0,
                        margin: const EdgeInsets.all(20.0),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.question.content,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: state.question.answers.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    value:
                                        state.selectedAnswers.contains(index),
                                    onChanged: (_) => context
                                        .read<QuizDetailsBloc>()
                                        .add(
                                          QuizDetailsChangeCheckAnswer(index),
                                        ),
                                    title: Text(
                                        state.question.answers[index].content),
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: state.status ==
                                            QuizQuestionDetailsStatus.start
                                        ? null
                                        : () => context.read<QuizDetailsBloc>().add(
                                            const QuizDetailsPreviousQuestion()),
                                    child: const Text("Previous Question"),
                                  ),
                                  ElevatedButton(
                                    onPressed: state.status ==
                                            QuizQuestionDetailsStatus.end
                                        ? () => context
                                            .read<QuizDetailsBloc>()
                                            .add(const QuizDetailsFinishQuiz())
                                        : () => context
                                            .read<QuizDetailsBloc>()
                                            .add(
                                                const QuizDetailsNextQuestion()),
                                    child: state.status ==
                                            QuizQuestionDetailsStatus.end
                                        ? const Text("Finish Quiz")
                                        : const Text("Next Question"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
