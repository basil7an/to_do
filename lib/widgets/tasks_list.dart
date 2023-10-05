import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/widgets/tasks_tile.dart';
import '../models/task_data.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) => SlidableAutoCloseBehavior(
        child: ReorderableListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: taskData.listLingth,
          itemBuilder: (context, index) {
            return TaskTile(
                key: ValueKey('$index'),
                title: taskData.tasks![index].task,
                isDone: taskData.tasks![index].isDone,
                callback: (value) {
                  taskData.toggleTask(index);
                },
                index: index);
          },
          onReorder: (int oldIndex, int newIndex) =>
              taskData.updateIndex(oldIndex, newIndex),
        ),
      ),
    );
  }
}
