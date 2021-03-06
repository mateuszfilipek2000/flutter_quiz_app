import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_quiz_app/models/quiz_model.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_select_screen/ui/quiz_select_screen.dart';

import '../screens/quiz_details_screen/ui/quiz_details_screen.dart';
import '../screens/quiz_results_screen/ui/quiz_results_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const QuizSelectScreen(),
          transitionsBuilder: (_, a, __, c) => FadeTransition(
            opacity: a,
            child: c,
          ),
          transitionDuration: const Duration(milliseconds: 1000),
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
        final arguments = settings.arguments;
        if (arguments is Map<String, Object?> &&
            arguments['user_answers'] is List<List> &&
            arguments['quiz'] is Quiz) {
          // return MaterialPageRoute(
          //   builder: (_) => QuizResultsScreen(
          //     quiz: arguments['quiz'] as Quiz,
          //     userAnswers: arguments['user_answers'] as List<List<int>>,
          //     duration: arguments['duration'] is Duration
          //         ? arguments['duration'] as Duration
          //         : null,
          //   ),
          //   settings: const RouteSettings(name: QuizResultsScreen.routeName),
          // );
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => QuizResultsScreen(
              quiz: arguments['quiz'] as Quiz,
              userAnswers: arguments['user_answers'] as List<List<int>>,
              duration: arguments['duration'] is Duration
                  ? arguments['duration'] as Duration
                  : null,
            ),
            settings: const RouteSettings(name: QuizResultsScreen.routeName),
            transitionsBuilder: (_, a, __, c) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: a,
                curve: curve,
              );
              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: c,
              );
            },
            transitionDuration: const Duration(milliseconds: 1000),
          );
        } else {
          log(arguments.toString());
          //TODO implement error route
          return MaterialPageRoute(
            builder: (_) => const QuizSelectScreen(),
            settings: const RouteSettings(name: QuizSelectScreen.routeName),
          );
        }
      default:
        return MaterialPageRoute(
          builder: (_) => const QuizSelectScreen(),
          settings: const RouteSettings(name: QuizSelectScreen.routeName),
        );
    }
  }
}
