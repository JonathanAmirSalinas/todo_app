import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/pages/create_todo_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    //final Object? key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
        );
      case '/createtodo':
        return MaterialPageRoute(builder: (_) => const CreateTodoPage());

      default:
        return null;
    }
  }
}
