import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/db_services.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todo = [];
  String time = DateTime.now().toString();

  List<Todo> get getTodoList => _todo;

  Future<void> getTodos() async {
    _todo = (await DBServices.getTodos())!;
    notifyListeners();
  }

  // Adds Todo object to the database
  Future<void> addTodo(Todo todo) async {
    await DBServices.add(todo);
    _todo.add(todo);
    notifyListeners();
  }

  // Updates Todo object to the database
  Future<void> updateTodo(Todo todo) async {
    await DBServices.update(todo);
    notifyListeners();
  }

  // Deletes Todo object to the database
  Future<void> deleteTodo(Todo todo) async {
    await DBServices.delete(todo);
    notifyListeners();
  }
}
