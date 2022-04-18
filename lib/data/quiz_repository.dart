import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc_quiz_app/core/utils/caesar.dart';
import 'package:flutter_bloc_quiz_app/core/utils/cipher_interface.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';

class QuizRepository {
  Quiz? _quiz;

  Future<Quiz?> getQuiz() async {
    if (_quiz != null) return _quiz;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      allowMultiple: false,
    );

    if (result?.files.single.path != null) {
      File file = File(result!.files.single.path!);

      try {
        CipherInterface cipher = Caesar();

        String encryptedString = await file.readAsString();
        String decryptedString = cipher.decode(encryptedString);
        _quiz = Quiz.fromJson(json.decode(decryptedString));
        return _quiz;
      } catch (e) {
        log(e.toString());
        log("quiz parsing error");
      }
    }
    return null;
  }
}
