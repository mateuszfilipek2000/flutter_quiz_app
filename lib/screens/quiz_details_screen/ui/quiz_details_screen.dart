import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_quiz_app/core/utils/ticker.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_bloc/quiz_details_bloc.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_bloc/quiz_details_event.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/quiz_details_bloc/quiz_details_state.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/timer_bloc/timer_bloc.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/timer_bloc/timer_state.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_results_screen/ui/quiz_results_screen.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/ui/widgets/animated_background.dart';

class QuizDetailsScreen extends StatefulWidget {
  static const routeName = 'QuizDetailsScreen';
  const QuizDetailsScreen({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  State<QuizDetailsScreen> createState() => _QuizDetailsScreenState();
}

class _QuizDetailsScreenState extends State<QuizDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController fadeInAnimationController;
  late Animation<double> fadeInAnimation;

  @override
  void initState() {
    fadeInAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    fadeInAnimation = Tween<double>(begin: 1.2, end: 0).animate(CurvedAnimation(
        parent: fadeInAnimationController, curve: Curves.bounceOut));

    fadeInAnimationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    fadeInAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => QuizDetailsBloc(quiz: widget.quiz),
          ),
          BlocProvider(
            create: (context) => TimerBloc(Ticker()),
          ),
        ],
        child: BlocListener<QuizDetailsBloc, QuizDetailsState>(
          listener: (context, state) {
            if (state is QuizDetailsFinished) {
              Navigator.of(context)
                  .pushNamed(QuizResultsScreen.routeName, arguments: {
                'user_answers': state.userAnswers,
                'quiz': state.quiz,
                'duration': context.read<TimerBloc>().state is TimerRunning
                    ? Duration(
                        seconds:
                            (context.read<TimerBloc>().state as TimerRunning)
                                .duration)
                    : null
              });
              // fadeInAnimationController.reset();

              // fadeInAnimation = Tween<double>(begin: -0.5, end: 0).animate(
              //     CurvedAnimation(
              //         parent: fadeInAnimationController,
              //         curve: Curves.easeInBack))
              //   ..addStatusListener((status) {
              //     if (status == AnimationStatus.completed) {
              //       Navigator.of(context)
              //           .pushNamed(QuizResultsScreen.routeName, arguments: {
              //         'user_answers': state.userAnswers,
              //         'quiz': state.quiz,
              //         'duration':
              //             context.read<TimerBloc>().state is TimerRunning
              //                 ? Duration(
              //                     seconds: (context.read<TimerBloc>().state
              //                             as TimerRunning)
              //                         .duration)
              //                 : null
              //       });
              //     }
              //   });
            }
          },
          child: BlocBuilder<QuizDetailsBloc, QuizDetailsState>(
            builder: (context, state) {
              if (state is QuizDetailsQuestionDetails) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<TimerBloc, TimerState>(
                            builder: (context, state) {
                              if (state is TimerRunning) {
                                return Text(
                                  Duration(seconds: state.duration)
                                      .toString()
                                      .split('.')
                                      .first
                                      .padLeft(8, "0"),
                                  style: Theme.of(context).textTheme.subtitle2,
                                );
                              }
                              return Text(
                                "00:00:00",
                                style: Theme.of(context).textTheme.subtitle2,
                              );
                            },
                          ),
                        ),
                      ),
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
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Divider(
                                  height: 2.0,
                                ),
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
                                      state.question.answers[index].content,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
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
                    AnimatedBuilder(
                        animation: fadeInAnimation,
                        builder: (context, _) {
                          return AnimatedBackground(
                              maxHeightFraction: 0.1 + fadeInAnimation.value);
                        }),
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
