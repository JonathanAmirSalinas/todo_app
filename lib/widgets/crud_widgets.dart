// Shows Bottom Sheet
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:uuid/uuid.dart';

// Creates a Todo
void createTodo(BuildContext context, TextEditingController titleController,
    TextEditingController descriptionController) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        TodoProvider todoProvider = Provider.of(context);
        return FractionallySizedBox(
          heightFactor: 1.5,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: Theme.of(context).canvasColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Title
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Add New Todo',
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .fontSize),
                    ),
                  ),
                  const Divider(
                    thickness: 4,
                    color: Colors.blue,
                  ),
                  // Title TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                      ),
                      child: TextField(
                        controller: titleController,
                        autofocus: true,
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontSize),
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Title',
                        ),
                      ),
                    ),
                  ),
                  // DEscription TextField
                  Container(
                    height: 130,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        color: Theme.of(context).cardColor),
                    child: TextField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Description'),
                    ),
                  ),
                  // Add Todo Button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        // Adds Todo to Databases from a TodoProvider Function
                        todoProvider.addTodo(Todo(
                          id: const Uuid().v1(),
                          title: titleController.text,
                          description: descriptionController.text,
                          date: DateTime.now().millisecondsSinceEpoch,
                        ));
                        // Clears Submitted Textfield Data
                        titleController.clear();
                        descriptionController.clear();
                        // Pops widget
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.add),
                      label: Text(
                        'Add Todo',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
