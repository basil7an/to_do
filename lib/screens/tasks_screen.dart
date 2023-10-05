import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_data.dart';
import 'package:to_do/sqflite.dart';
import '../constant.dart';
import '../widgets/add_tasks_screen.dart';
import '../widgets/tasks_list.dart';

int i = 0;

class TasksScreen extends StatelessWidget {
  static String id = 'home';
  @override
  Widget build(BuildContext context) {
    if (i == 0) {
      Provider.of<TaskData>(context, listen: false).readData();
      Provider.of<TaskData>(context, listen: false).tasks;

      i = 1;
    }
    double tasksheight = MediaQuery.of(context).size.height * 0.63;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainc,
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            // isScrollControlled: true,
            context: context,
            builder: (context) => AddTaskScreen(),
          );
        },
        child: const Icon(
          Icons.add,
          size: 45,
        ),
      ),
      backgroundColor: mainc,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          size: 58,
                          Icons.list,
                          color: mainc,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Todoey',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${Provider.of<TaskData>(context).listLingth} Tasks',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                height: tasksheight,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20),
                  child: TasksList(),
                ),
              ),
            )
          ]),
    );
  }
}
