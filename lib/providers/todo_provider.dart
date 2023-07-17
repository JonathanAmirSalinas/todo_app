import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/db_services.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todo = [];

  List<Todo> get getTodoList => _todo;

  // Assigns All Data from Database to TodoProvider List Variable _todo
  Future<void> getTodos() async {
    _todo = await TodoDatabase.instance.getTodos();
    notifyListeners();
  }

  // Adds Todo object to the database
  Future<void> addTodo(Todo todo) async {
    await TodoDatabase.instance.createTodo(todo);
    _todo.add(
        todo); // Could clear _todo and call getTodos to ENSURE same state between both Database and TodoProvider
    //_todo.clear();
    //getTodos();
    notifyListeners();
  }

  // Updates Todo object to the database
  Future<void> updateTodo(Todo todo) async {
    await TodoDatabase.instance.updateTodo(todo);
    _todo
        .clear(); // Could update both provider value and database seperataly or just update database value and re-intilize provider values with getTodos
    getTodos();
    notifyListeners();
  }

  // Deletes Todo object to the database
  Future<void> deleteTodo(Todo todo) async {
    await TodoDatabase.instance.deleteTodo(todo);
    _todo.remove(todo); // Simple function in removing todo form List
    //_todo.clear();
    //getTodos();
    notifyListeners();
  }
}
