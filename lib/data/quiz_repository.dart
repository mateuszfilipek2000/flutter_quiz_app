import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc_quiz_app/models/answer_model.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';

import '../models/question_model.dart';

class QuizRepository {
  Quiz? _quiz;

  Future<Quiz?> getQuiz() async {
    if (_quiz != null) return _quiz;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['json'],
    );

    if (result?.files.single.path != null) {
      File file = File(result!.files.single.path!);

      // fake quiz for now
      _quiz = const Quiz(
        name: "Test Quiz",
        summary: "Just testing if everything works // to be implemented",
        questions: [
          Question(
            content: "How many stripes are there on the US flag?",
            answers: [
              Answer(
                '13',
                true,
              ),
              Answer(
                '14',
                false,
              ),
              Answer(
                '11',
                false,
              ),
              Answer(
                '12',
                false,
              ),
            ],
          ),
          Question(
            content:
                "How many days does it take for the Earth to orbit the Sun?",
            answers: [
              Answer(
                '365',
                true,
              ),
              Answer(
                '14',
                false,
              ),
              Answer(
                '367',
                false,
              ),
              Answer(
                '111',
                false,
              ),
            ],
          ),
          Question(
            content: "What’s the smallest country in the world?",
            answers: [
              Answer(
                'The Vatican',
                true,
              ),
              Answer(
                'Poland',
                false,
              ),
              Answer(
                'America',
                false,
              ),
              Answer(
                'Sweden',
                false,
              ),
            ],
          ),
          Question(
            content: "What is often seen as the smallest unit of memory?",
            answers: [
              Answer(
                'kilobyte',
                true,
              ),
              Answer(
                'byte',
                true,
              ),
              Answer(
                'petabyte',
                false,
              ),
              Answer(
                'gram',
                false,
              ),
            ],
          ),
          Question(
            content: "Which email service is owned by Microsoft?",
            answers: [
              Answer(
                'Outlook',
                true,
              ),
              Answer(
                'Hotmail',
                true,
              ),
              Answer(
                'Gmail',
                false,
              ),
              Answer(
                'onet',
                false,
              ),
            ],
          ),
          Question(
            content:
                "What’s the shortcut for the “copy” function on most computers?",
            answers: [
              Answer(
                'copy',
                false,
              ),
              Answer(
                'c+o+p+y',
                true,
              ),
              Answer(
                'alt+copy',
                true,
              ),
              Answer(
                'ctrl+c',
                false,
              ),
            ],
          ),
        ],
      );
      return _quiz;
    }
  }
}
