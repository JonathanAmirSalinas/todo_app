import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/models/todo_model.dart';

void main() {
  test("Todo Model", () async {
    final Todo todo =
        Todo(id: '1', title: "Title", body: "Body", date: "3/13/2023");
    expect(todo.title, 'Title');
    expect(todo.body, 'Body');
    expect(todo.date, '3/13/2023');
  });
  test("Get Todo", () async {});
  test("Add Todo", () => null);
  test("Update Todo", () => null);
  test("Delete Todo", () => null);
}
