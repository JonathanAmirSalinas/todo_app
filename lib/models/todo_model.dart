// ToDo Object
class Todo {
  final int? id;
  final String title;
  final String body;
  final String date;

  Todo({
    this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'date': date,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      date: json['date'],
    );
  }
}
