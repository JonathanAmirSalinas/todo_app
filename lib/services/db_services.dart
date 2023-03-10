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
          'Create Table Todo(id INTERGER PRIMARY KEY , title TEXT NOT NULL, body TEXT NOT NULL,);');
    }, version: _dbVersion);
  }

  static Future<void> add(Todo todo) async {
    final db = await _getdb();

    await db.insert('Todo', todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> update(Todo todo) async {
    final db = await _getdb();

    return await db.update('Todo', todo.toJson(),
        where: 'id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> delete(Todo todo) async {
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
}
