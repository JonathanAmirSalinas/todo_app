import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/main_drawer_widget.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String date =
      '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';

  bool cbValue = false;
  late bool isLoading;
  int index = 0;

  @override
  void initState() {
    getTodoList();
    super.initState();
  }

  // Gets Todo List for Database
  getTodoList() async {
    setState(() {
      isLoading = true;
    });
    try {
      TodoProvider todoProvider = Provider.of(context, listen: false);
      await todoProvider.getTodos();
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  // Shows Bottom Sheet
  void _addTodo(BuildContext context) {
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
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'Add New Todo',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontSize),
                      ),
                    ),
                    const Divider(
                      thickness: 4,
                      color: Colors.blue,
                    ),
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
                          key: const Key('add-title'),
                          controller: titleController,
                          autofocus: true,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Title'),
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          color: Theme.of(context).cardColor),
                      child: TextField(
                        key: const Key('add-description'),
                        controller: descriptionController,
                        maxLines: 4,
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Description'),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(4),
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        key: const Key('add-todo'),
                        onPressed: () {
                          // Adds Todo to Database
                          todoProvider.addTodo(Todo(
                            id: const Uuid().v1(),
                            title: titleController.text,
                            body: descriptionController.text,
                            date: date,
                          ));
                          // Clears Submitted Textfield Data
                          titleController.clear();
                          descriptionController.clear();
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

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of(context);
    return isLoading
        ? const CircularProgressIndicator()
        : SafeArea(
            child: Scaffold(
              drawer: const MainDrawer(),
              appBar: AppBar(
                key: const Key('Home Appbar'),
                title: const Text('Todo'),
                leading: Builder(builder: (context) {
                  return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu));
                }),
              ),
              body: todoProvider.getTodoList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create your first todo task',
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .fontSize),
                          ),
                          TextButton(
                              onPressed: () {
                                _addTodo(context);
                              },
                              child: Text(
                                'Click here to create your first todo!',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize),
                              ))
                        ],
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          // Wont go scroll to very bottom
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: todoProvider.getTodoList.length,
                          itemBuilder: (context, index) {
                            return buildTodoTile(index);
                          }),
                    ),
              floatingActionButton: SizedBox(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    _addTodo(context);
                  },
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  tooltip: "Create Note",
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          );
  }

  // Builds Todo Card
  buildTodoTile(int index) {
    TodoProvider todoProvider = Provider.of(context);
    return Card(
        child: ExpansionTile(
      leading: Checkbox(
        value: cbValue,
        onChanged: (value) {
          setState(() {
            cbValue = value!;
          });
        },
      ),
      title: Text(
        todoProvider.getTodoList[index].title,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
        ),
      ),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(border: Border(top: BorderSide())),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Todo:',
                style: TextStyle(
                  color: Colors.black45,
                  fontStyle: FontStyle.italic,
                  fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  todoProvider.getTodoList[index].body,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
} ////
