import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
            child: Column(
          children: [
            todoProvider.getTodoList.isEmpty
                ? Card(
                    color: Theme.of(context).disabledColor,
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "List Is Empty",
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 800,
                    child: ListView.builder(
                        itemCount: todoProvider.getTodoList.length,
                        itemBuilder: (context, index) {
                          return buildTodoCard(index);
                        }),
                  ),
          ],
        )),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/createtodo');
          },
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          tooltip: "Create Note",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  buildTodoCard(int index) {
    TodoProvider todoProvider = Provider.of(context);
    return Flexible(
      child: Card(
        color: Colors.grey,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: Colors.blue),
              child: Text(
                todoProvider.getTodoList[index].title,
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall!.fontSize),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                todoProvider.getTodoList[index].body,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
              ),
            ),
            Text(DateTime.now().toString())
          ],
        ),
      ),
    );
  }
}
