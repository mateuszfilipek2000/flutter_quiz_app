import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_quiz_app/data/quiz_repository.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/ui/quiz_details_screen.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_bloc.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_event.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/bloc/quiz_select_state.dart';
import 'dart:math';

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
              },
            );
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

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();

    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedWaves(animation: animation, width: width);
  }
}

class AnimatedWaves extends AnimatedWidget {
  const AnimatedWaves({Key? key, required this.animation, required this.width})
      : super(listenable: animation);

  final Animation<double> animation;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipper(0.11, animation.value, offsetPercent: 0.2),
          child: Container(
            color: const Color(0xFFFFDDE5),
          ),
        ),
        ClipPath(
          clipper: WaveClipper(0.1, animation.value),
          child: Container(
            color: const Color(0xFFEE4266),
          ),
        ),
        ClipPath(
          clipper: WaveClipper(0.08, animation.value, offsetPercent: 0.2),
          child: Container(
            color: const Color(0xFFFFB8C8),
          ),
        ),
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  WaveClipper(this.heightFraction, this.animationValue,
      {this.offsetPercent = 0});

  double heightFraction;
  double animationValue;
  double offsetPercent;

  @override
  Path getClip(Size size) {
    var width = size.width;
    var height = size.height;

    var waveHeight = height - (height * heightFraction);

    var percentOfHeight = height / 100;
    var percentOfWidth = width / 100;

    Path path = Path()
      ..moveTo(width, waveHeight)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..lineTo(0, waveHeight);

    for (int x = 0; x <= width; x++) {
      // current width fraction (0-1)
      var xPos = x / width * 2 * pi;
      var currentWidthShift =
          (animationValue * 2 * pi) + (width * offsetPercent);

      // currentWidthShift *= speed;
      path.lineTo(
          x.toDouble(), waveHeight + sin(2 * pi + xPos + currentWidthShift) * 50
          // waveHeight +
          //     sin(((size.width * offsetPercent + x) / size.width * 4 * pi) +
          //             ((speed * animationValue) * 2 * pi)) *
          //         30,
          );
    }

    // Path path = Path()
    //   ..moveTo(width + widthShift, waveHeight)
    //   ..lineTo(width + widthShift, height)
    //   ..lineTo(0, height)
    //   ..lineTo(0, waveHeight)
    //   ..cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, width + widthShift, waveHeight)
    //   ..close();
    return path..close();
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      heightFraction != oldClipper.heightFraction ||
      animationValue != oldClipper.animationValue;
}
