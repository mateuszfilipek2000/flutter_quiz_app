import 'package:flutter/material.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';

//TODO STYLE IT
class QuizResultsScreen extends StatelessWidget {
  static const String routeName = 'QuizResultsScreen';
  const QuizResultsScreen(
      {Key? key, required this.quiz, required this.userAnswers})
      : super(key: key);

  final List<List<int>> userAnswers;
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: quiz.questions.length,
        itemBuilder: (context, index) {
          final currentQuestionAnswers = quiz.questions[index].answers;
          final currentUserAnswers = userAnswers[index];
          final currentQuestion = quiz.questions[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 15.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      currentQuestion.content,
                      style: Theme.of(context).textTheme.headline5,
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
                                ? currentQuestionAnswers[i].isCorrect &&
                                        !currentUserAnswers.contains(i)
                                    ? Colors.green
                                    : null
                                : !currentQuestionAnswers[i].isCorrect &&
                                        currentUserAnswers.contains(i)
                                    ? Colors.red
                                    : null,
                        title: Text(
                          currentQuestionAnswers[i].content,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: currentQuestionAnswers[i].isCorrect ||
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
            ),
          );
        },
      ),
    );
  }
}
