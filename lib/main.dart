import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/manage_page.dart';
import 'package:todo_app/pages/saved_page.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => TodoProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late bool isLoading;
  int index = 0;

  @override
  void initState() {
    getTodoList();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
            body: IndexedStack(
              index: index,
              children: const [
                HomePage(),
                SavedPage(),
                ManagePage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white60,
              onTap: (value) => setState(() {
                index = value;
              }),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Main"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark), label: "Saved"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.manage_accounts), label: "Manage"),
              ],
            ),
          );
  }
}
