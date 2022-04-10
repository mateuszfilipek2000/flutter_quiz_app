import 'package:flutter_bloc_quiz_app/models/answer_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_model.freezed.dart';

@freezed
class Question with _$Question {
  const factory Question(
      {required String content, required List<Answer> answers}) = _Question;
}
