import 'package:flutter/material.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/ui/quiz_select_screen.dart';

import '../screens/quiz_details_screen/ui/quiz_details_screen.dart';
import '../screens/quiz_results_screen/ui/quiz_results_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const QuizSelectScreen(),
          settings: const RouteSettings(name: QuizSelectScreen.routeName),
        );
      case QuizDetailsScreen.routeName:
        final arguments = settings.arguments;
        if (arguments is Quiz) {
          return MaterialPageRoute(
            builder: (_) => QuizDetailsScreen(
              quiz: arguments,
            ),
            settings: const RouteSettings(name: QuizDetailsScreen.routeName),
          );
        }
        //TODO implement error route
        return MaterialPageRoute(
          builder: (_) => const QuizSelectScreen(),
          settings: const RouteSettings(name: QuizSelectScreen.routeName),
        );

      case QuizResultsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const QuizResultsScreen(),
          settings: const RouteSettings(name: QuizResultsScreen.routeName),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const QuizSelectScreen(),
          settings: const RouteSettings(name: QuizSelectScreen.routeName),
        );
    }
  }
}
