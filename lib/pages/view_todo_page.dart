import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';

class ViewTodoPage extends StatefulWidget {
  final Todo todo;
  const ViewTodoPage({super.key, required this.todo});

  @override
  State<ViewTodoPage> createState() => _ViewTodoPageState();
}

class _ViewTodoPageState extends State<ViewTodoPage> {
  // TextEditing Used in Editing Mode
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // PlaceHolder values for when edited values are canceled before they are saved
  String title = "";
  String descritpion = "";
  // Editing Mode used to UI/UX Functionality
  bool editMode = false;

  @override
  void initState() {
    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description;
    title = titleController.text;
    descritpion = descriptionController.text;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // Sets Edited Changes to the PlaceHolder Values
  void editChanges(String newTitle, String newDescription) {
    title = newTitle;
    descritpion = newDescription;
  }

  // Reverts TextEditing Controllers with PlaceHolder Values
  void cancelChanges() {
    titleController.text = title;
    descriptionController.text = descritpion;
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: editMode
              ? Text(
                  'Editing',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  ),
                )
              : Text(
                  "Todo",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  ),
                ),
          actions: [
            Row(
              children: [
                editMode
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            // Creates Todo with new updated values
                            Todo editedTodo = widget.todo.copy(
                                title: titleController.text,
                                description: descriptionController.text);
                            // Updates Todo Values from todoProvider functions
                            todoProvider.updateTodo(editedTodo);
                            // Updates PlaceHolder Values with new updated ones
                            editChanges(titleController.text,
                                descriptionController.text);
                            // Completion Message
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Saved')));
                            // Exits Editing Mode
                            editMode = false;
                          });
                        },
                        splashRadius: 20,
                        icon: const Icon(Icons.save),
                        tooltip: 'Save',
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            editMode = true;
                          });
                        },
                        splashRadius: 20,
                        icon: const Icon(Icons.edit),
                        tooltip: 'Edit',
                      ),
                editMode
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            cancelChanges();
                            editMode = false;
                          });
                        },
                        splashRadius: 20,
                        icon: const Icon(Icons.cancel_rounded),
                        tooltip: 'Cancel',
                      )
                    : Container(),
                IconButton(
                  onPressed: () {
                    todoProvider.deleteTodo(widget.todo);
                    Navigator.of(context).pop();
                  },
                  splashRadius: 20,
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete',
                )
              ],
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: editMode
                // editMode == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.topLeft,
                        child: TextField(
                          controller: titleController,
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .fontSize,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Todo Title',
                          ),
                          maxLines: null,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: descriptionController,
                          maxLength: 256,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            hintText: 'Todo Description',
                            isCollapsed: true,
                          ),
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontSize,
                          ),
                          maxLines: null,
                        ),
                      )
                    ],
                  )
                // editmode == false
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            titleController.text,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .fontSize,
                            ),
                          )),
                      Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            descriptionController.text,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                          ))
                    ],
                  )),
      ),
    );
  }
}
