import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_model.freezed.dart';

@freezed
class Answer with _$Answer {
  const factory Answer(String content, bool isCorrect) = _Answer;
}
