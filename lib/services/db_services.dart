import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo_model.dart';

class DBServices {
  static const int _dbVersion = 1;
  static const String _dbName = 'todo.db';

  static Future<Database> _getdb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) {
      return db.execute(
          'Create Table Todo(id TEXT NOT NULL , title TEXT NOT NULL, body TEXT NOT NULL, date TEXT NOT NULL);');
    }, version: _dbVersion);
  }

  static Future<void> addTodo(Todo todo) async {
    final db = await _getdb();

    await db.insert('Todo', todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateTodo(Todo todo) async {
    final db = await _getdb();

    return await db.update('Todo', todo.toJson(),
        where: 'id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteTodo(Todo todo) async {
    final db = await _getdb();

    return await db.delete(
      'Todo',
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  static Future<List<Todo>?> getTodos() async {
    final db = await _getdb();

    final List<Map<String, dynamic>> todos = await db.query('Todo');

    if (todos.isEmpty) {
      return null;
    } else {
      return List.generate(
          todos.length, (index) => Todo.fromJson(todos[index]));
    }
  }

  static Future<void> deleteDB() async {
    final db = await _getdb();

    await db.execute('DROP TABLE IF EXISTS Todo');
  }
}
