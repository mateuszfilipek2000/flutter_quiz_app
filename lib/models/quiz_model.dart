import 'package:flutter_bloc_quiz_app/models/question_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_model.freezed.dart';

@freezed
class Quiz with _$Quiz {
  const factory Quiz(
      {required String name,
      required List<Question> questions,
      String? summary}) = _Quiz;
}
