import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/pages/view_todo_page.dart';
import 'package:todo_app/pages/home_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    // Arguements
    final args = settings.arguments;
    switch (settings.name) {
      // Initial Route/ HomePage
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      // ViewTodoPage
      case '/viewtodo':
        return MaterialPageRoute(
            builder: (_) => ViewTodoPage(todo: args as Todo));

      default:
        return null;
    }
  }
}
