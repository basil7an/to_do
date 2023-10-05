import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_data.dart';
import 'package:to_do/screens/edit.dart';
import 'package:to_do/screens/tasks_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (context) => TaskData(),
      child: MaterialApp(
        routes: {
          TasksScreen.id: (context) => TasksScreen(),
        },
        home: TasksScreen(),
      ),
    );
  }
}
