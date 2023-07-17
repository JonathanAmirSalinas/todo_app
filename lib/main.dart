import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/home_page.dart';
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
  // Initilize Router
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: ThemeData(
        brightness: Brightness.dark, // Dark Mode
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      initialRoute: '/',
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
