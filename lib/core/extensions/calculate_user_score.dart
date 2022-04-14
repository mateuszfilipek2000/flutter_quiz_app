import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';

import 'package:collection/collection.dart';

extension UserScore on Quiz {
  int calculateUserScore({required List<List<int>> userAnswersIndexes}) {
    var score = 0;

    questions.forEachIndexed((index, question) {
      var correctAnswers =
          question.answers.where((element) => element.isCorrect).toList();

      final userAnswers =
          userAnswersIndexes[index].map((e) => question.answers[e]);

      if (correctAnswers.length == userAnswersIndexes[index].length) {
        if (correctAnswers.every((element) => userAnswers.contains(element))) {
          score += 1;
        }
      }
    });

    return score;
  }
}
