// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/providers/todo_provider.dart';

void main() {
  /*testWidgets('HomePage AppBar', (WidgetTester tester) async {
    final appbar = find.byKey(const Key("Home Appbar"));
    TestWidgetsFlutterBinding.ensureInitialized();
    // Build our app and trigger a frame.
    await tester.runAsync(
      () => tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TodoProvider())
        ],
        child: MyApp(),
      )),
    );
    await tester.pumpAndSettle();

    expect(appbar, findsOneWidget);
  });*/
}
