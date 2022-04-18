import 'package:flutter_bloc_quiz_app/models/question_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_model.freezed.dart';
part 'quiz_model.g.dart';

@freezed
class Quiz with _$Quiz {
  const factory Quiz(
      {@JsonKey(name: 'Name') required final String name,
      @JsonKey(name: 'Questions') required final List<Question> questions,
      @JsonKey(name: 'Description') final String? summary}) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}
