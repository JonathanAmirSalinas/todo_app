import 'package:flutter/material.dart';
import 'package:todo_app/pages/create_todo_page.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/todo_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    //final Object? key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case '/createtodo':
        return MaterialPageRoute(builder: (_) => const CreateTodoPage());
      case '/todo':
        return MaterialPageRoute(
            builder: (_) => TodoPage(
                  index: settings.arguments as int,
                ));

      default:
        return null;
    }
  }
}
