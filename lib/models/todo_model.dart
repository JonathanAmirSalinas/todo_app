// ToDo Object
class Todo {
  final int? id;
  final String title;
  final String body;
  //final DateTime timestamp;

  Todo({
    this.id,
    required this.title,
    required this.body,
    //required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      //'timestamp': timestamp,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      //timestamp: json['timestamp']
    );
  }
}
