// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  final int index;
  const TodoPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
