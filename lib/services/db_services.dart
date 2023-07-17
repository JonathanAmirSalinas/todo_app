import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT'; /////// Returns NULL -> Currently replaced with a Uuid (unique id dependency)
    const stringType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE $tableTodo (
      ${TodoFields.id} $stringType, 
      ${TodoFields.title} $stringType,
      ${TodoFields.description} $stringType,
      ${TodoFields.date} $intType    
    )
    ''');
  }

  // Creates Todo item
  Future<int> createTodo(Todo todo) async {
    final db = await instance.database;

    return await db.insert(tableTodo, todo.toJson());
  }

  // Gets list of Todos
  Future<List<Todo>> getTodos() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> todos = await db.query(tableTodo);

    if (todos.isNotEmpty) {
      return List.generate(
          todos.length, (index) => Todo.fromJson(todos[index]));
    } else {
      throw Exception('Empty Database');
    }
  }

  // Update Todo
  Future<int> updateTodo(Todo todo) async {
    final db = await instance.database;

    return db.update(tableTodo, todo.toJson(),
        where: '${TodoFields.id} = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Delete Todo
  Future<int> deleteTodo(Todo todo) async {
    final db = await instance.database;

    return await db.delete(
      tableTodo,
      where: '${TodoFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  // Closes database connection
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
