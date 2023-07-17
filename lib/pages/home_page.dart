import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time/time.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/crud_widgets.dart';
import 'package:todo_app/services/db_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late bool isLoading;
  List color = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
  ];

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
      await todoProvider.getTodos(); // Calls data from database
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    TodoDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of(context);
    return isLoading
        ? const CircularProgressIndicator()
        : SafeArea(
            child: Scaffold(
              // Conditional UI if Database is Empty
              body: todoProvider.getTodoList.isEmpty
                  // Without/Empty List
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create your first todo task',
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .fontSize),
                          ),
                          // Same Functionality as our FloatActionButton
                          TextButton(
                              onPressed: () {
                                createTodo(context, titleController,
                                    descriptionController);
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
                  // With Data
                  : Container(
                      margin: const EdgeInsets.all(4),
                      child: GridView.custom(
                        //reverse: true,
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 4,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          pattern: [
                            // (x, y) -> Cross, Main
                            const QuiltedGridTile(3, 2),
                            const QuiltedGridTile(1, 2),
                            const QuiltedGridTile(2, 2),
                            const QuiltedGridTile(2, 2),
                            const QuiltedGridTile(2, 2),
                          ],
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: todoProvider.getTodoList.length,
                          (context, index) => buildTodoGridTile(index),
                        ),
                      )),
              floatingActionButton: SizedBox(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    createTodo(context, titleController, descriptionController);
                  },
                  backgroundColor: Colors.white,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tooltip: "Create Todo",
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          );
  }

  // Todo Tile
  buildTodoGridTile(int index) {
    TodoProvider todoProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/viewtodo', arguments: todoProvider.getTodoList[index]);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: color[index % 7]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Todo Tilte
              Text(
                todoProvider.getTodoList[index].title,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                ),
              ),
              // Todo Description
              Expanded(
                  child: Text(
                todoProvider.getTodoList[index].description,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                ),
                overflow: TextOverflow.fade,
              )),
              // Todo Date
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('MM-dd-yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(
                              todoProvider.getTodoList[index].date)
                          .date),
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  ),
                ),
              )
            ]),
      ),
    );
  }
} ////
