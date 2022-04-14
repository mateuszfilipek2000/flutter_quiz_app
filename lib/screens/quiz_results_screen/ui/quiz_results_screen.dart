import 'package:flutter/material.dart';
import 'package:flutter_bloc_quiz_app/core/extensions/calculate_user_score.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_results_screen/ui/widgets/animated_score_info.dart';

class QuizResultsScreen extends StatelessWidget {
  static const String routeName = 'QuizResultsScreen';
  const QuizResultsScreen(
      {Key? key, required this.quiz, required this.userAnswers, this.duration})
      : super(key: key);

  final List<List<int>> userAnswers;
  final Quiz quiz;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
              margin: const EdgeInsets.all(20.0),
              child: AnimatedScoreInfo(
                scored:
                    quiz.calculateUserScore(userAnswersIndexes: userAnswers),
                total: quiz.questions.length,
                duration: duration,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: quiz.questions.length,
              itemBuilder: (context, index) {
                final currentQuestionAnswers = quiz.questions[index].answers;
                final currentUserAnswers = userAnswers[index];
                final currentQuestion = quiz.questions[index];
                return Card(
                  margin: const EdgeInsets.all(20.0),
                  clipBehavior: Clip.hardEdge,
                  elevation: 15.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          currentQuestion.content,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          height: 2.0,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: currentQuestionAnswers.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            trailing: currentUserAnswers.contains(i)
                                ? const Icon(Icons.check_box_outlined)
                                : const Icon(
                                    Icons.check_box_outline_blank_outlined),
                            tileColor: currentQuestionAnswers[i].isCorrect &&
                                    currentUserAnswers.contains(i)
                                ? Colors.green
                                : currentQuestionAnswers[i].isCorrect &&
                                        !currentUserAnswers.contains(i)
                                    ? Colors.red
                                    : !currentQuestionAnswers[i].isCorrect &&
                                            currentUserAnswers.contains(i)
                                        ? Colors.red
                                        : null,
                            title: Text(
                              currentQuestionAnswers[i].content,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      color:
                                          currentQuestionAnswers[i].isCorrect ||
                                                  currentUserAnswers.contains(i)
                                              ? Colors.white
                                              : null),
                            ),

                            // shape: const RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            // ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
