import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_quiz_app/data/quiz_repository.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/ui/quiz_details_screen.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_bloc.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_event.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_state.dart';

class QuizSelectScreen extends StatelessWidget {
  static const String routeName = '/';

  const QuizSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizSelectionBloc(
        quizRepository: RepositoryProvider.of<QuizRepository>(context),
      ),
      child: BlocListener<QuizSelectionBloc, QuizSelectionState>(
        listener: (context, state) {
          if (state is QuizSelectionSuccess) {
            Navigator.of(context)
                .pushNamed(QuizDetailsScreen.routeName, arguments: state.quiz);
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
                });
          }
        },
        child: Stack(
          children: [
            const AnimatedBackground(),
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
                      height: 300,
                      width: 300,
                      child: Center(
                        child: Text(
                          "Select Quiz",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
