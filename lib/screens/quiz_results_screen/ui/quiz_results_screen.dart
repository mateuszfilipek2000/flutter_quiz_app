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
          return ListView.builder(
            shrinkWrap: true,
            itemCount: currentQuestionAnswers.length,
            itemBuilder: (context, i) {
              //TODO FIX COLORS
              return Container(
                decoration: BoxDecoration(
                  color: currentQuestionAnswers[i].isCorrect &&
                          currentUserAnswers.contains(i)
                      ? Colors.green
                      : currentQuestionAnswers[i].isCorrect &&
                              !currentUserAnswers.contains(i)
                          ? Colors.red
                          : null,
                ),
                child: Text(currentQuestionAnswers[i].content),
              );
            },
          );
        },
      ),
    );
  }
}
