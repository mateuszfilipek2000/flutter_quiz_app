import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_quiz_app/data/quiz_repository.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/ui/quiz_details_screen.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_bloc.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_event.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_state.dart';
import 'dart:math';

import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/ui/widgets/animated_background.dart';

class QuizSelectScreen extends StatefulWidget {
  static const String routeName = '/';

  const QuizSelectScreen({Key? key}) : super(key: key);

  @override
  State<QuizSelectScreen> createState() => _QuizSelectScreenState();
}

class _QuizSelectScreenState extends State<QuizSelectScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController fadeOutAnimationController;
  late Animation<double> fadeOutAnimation;

  @override
  void initState() {
    fadeOutAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    fadeOutAnimation = Tween<double>(begin: 0.0, end: 1.2).animate(
        CurvedAnimation(
            parent: fadeOutAnimationController, curve: Curves.easeInBack));

    // fadeOutAnimationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    fadeOutAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double smallerDimension = min(size.width, size.height);
    return Scaffold(
      body: BlocProvider(
        create: (context) => QuizSelectionBloc(
          quizRepository: RepositoryProvider.of<QuizRepository>(context),
        ),
        child: BlocListener<QuizSelectionBloc, QuizSelectionState>(
          listener: (context, state) {
            if (state is QuizSelectionSuccess) {
              fadeOutAnimationController
                ..addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    Navigator.of(context).pushNamed(QuizDetailsScreen.routeName,
                        arguments: state.quiz);
                  }
                })
                ..forward();
            }
            if (state is QuizSelectionFailure) {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Quiz selection error"),
                    actions: [
                      TextButton(
                        child: const Text("Ok"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Stack(
            children: [
              Center(
                child: BlocBuilder<QuizSelectionBloc, QuizSelectionState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is QuizSelectionInProgress
                          ? null
                          : () => context
                              .read<QuizSelectionBloc>()
                              .add(const QuizSelectionButtonPressed()),
                      child: SizedBox(
                        height: smallerDimension * 0.5,
                        width: smallerDimension * 0.5,
                        child: Center(
                          child: Text(
                            "Select Quiz",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              AnimatedBuilder(
                  animation: fadeOutAnimation,
                  builder: (context, _) {
                    return AnimatedBackground(
                        maxHeightFraction: 0.16 + fadeOutAnimation.value);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
