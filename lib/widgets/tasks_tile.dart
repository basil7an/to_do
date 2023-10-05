import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_data.dart';
import 'package:to_do/screens/edit.dart';
import 'package:to_do/sqflite.dart';

import '../constant.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final int isDone;
  late int everIndex;
  final int index;
  final Function(bool?) callback;
  TaskTile(
      {required this.title,
      required this.isDone,
      super.key,
      required this.callback,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        key: key,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Color(0xFFFE4A49),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Slidable(
          key: key,
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditScreen(isDone: isDone, oldValue: title),
                      ));
                },
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                padding: EdgeInsets.only(right: 40),
                label: 'Edit',
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              SlidableAction(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                onPressed: (context) async {
                  Provider.of<TaskData>(context, listen: false)
                      .removeTask(index);
                  dynamic query = await Provider.of<TaskData>(context,
                          listen: false)
                      .sqlDb
                      .readData(
                          'SELECT id FROM notes WHERE task = "$title" AND isDone = $isDone');
                  int everIndex = query[0]['id'];
                  int response =
                      await Provider.of<TaskData>(context, listen: false)
                          .sqlDb
                          .delete('notes', 'id = $everIndex');
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                padding: EdgeInsets.only(right: 40),
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                )),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff8ed4fa),
                  borderRadius: BorderRadius.circular(30)),
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                      decoration:
                          isDone == 1 ? TextDecoration.lineThrough : null,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                trailing: Checkbox(
                  value: isDone == 1 ? true : false,
                  onChanged: callback,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
