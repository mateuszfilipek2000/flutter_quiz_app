import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_model.freezed.dart';
part 'answer_model.g.dart';

@freezed
class Answer with _$Answer {
  const factory Answer(@JsonKey(name: 'Content') String content,
      @JsonKey(name: 'IsCorrect') bool isCorrect) = _Answer;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
}
