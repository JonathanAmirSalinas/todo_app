import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize),
                ),
                Flexible(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: titleController,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.left,
                        maxLines: null,
                        maxLength: 128,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add title...",
                            counterText: ""),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                Text(
                  "Description",
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize),
                ),
                Flexible(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: bodyController,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.left,
                        maxLines: null,
                        maxLength: 256,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add caption...",
                            counterText: ""),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                todoProvider.addTodo(Todo(
                  title: titleController.text,
                  body: bodyController.text,
                ));
                Navigator.of(context).pop();
              },
              label: const Text('Done')),
        ),
      ),
    );
  }
}
