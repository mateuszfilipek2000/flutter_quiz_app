import 'package:flutter_bloc_quiz_app/models/answer_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_model.freezed.dart';
part 'question_model.g.dart';

@freezed
class Question with _$Question {
  const factory Question(
      {@JsonKey(name: 'Content') required String content,
      @JsonKey(name: 'Answers') required List<Answer> answers}) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
