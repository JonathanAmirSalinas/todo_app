// Database Values //////////////////////////////////////////////////
const String tableTodo = 'todos';

class TodoFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String date = 'date';
}
//////////////////////////////////////////////////////////////////////////

class Todo {
  final String id;
  final String title;
  final String description;
  final int date;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  Todo copy({
    String? id,
    String? title,
    String? description,
    int? date,
  }) =>
      Todo(
          id: id ?? this.id,
          title: title ?? this.title,
          description: description ?? this.description,
          date: date ?? this.date);

  Map<String, dynamic> toJson() {
    return {
      TodoFields.id: id,
      TodoFields.title: title,
      TodoFields.description: description,
      TodoFields.date: date,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
    );
  }
}
