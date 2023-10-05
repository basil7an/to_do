import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/constant.dart';
import 'package:to_do/models/task_data.dart';
import 'package:to_do/sqflite.dart';

class AddTaskScreen extends StatelessWidget {
  SqlDb sql = SqlDb();
  @override
  Widget build(BuildContext context) {
    String task = '';
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add Task',
            style: TextStyle(
              color: mainc,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          TextField(
            autofocus: true,
            onChanged: (value) {
              task = value;
            },
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: mainc),
              onPressed: () {
                if (task.isNotEmpty) {
                  Provider.of<TaskData>(context, listen: false).addTask(task);
                  sql.insert('notes', {'task': task, 'isDone': 0});
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'))
        ],
      ),
    );
  }
}
