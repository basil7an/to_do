import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:to_do/models/task.dart';

import '../sqflite.dart';

class TaskData extends ChangeNotifier {
  SqlDb sqlDb = SqlDb();

  Future readData() async {
    List<Map> s = await sqlDb.read("notes");
    var ss = await sqlDb.intialDb();
    for (int i = 0; i < s.length; i++) {
      Task response = Task(task: s[i]["task"], isDone: s[i]['isDone']);
      _tasks.add(response);
    }

    notifyListeners();
  }

  void updateIndex(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final tile = _tasks.removeAt(oldIndex);
    _tasks.insert(newIndex, tile);

    notifyListeners();
  }

  List<Task> _tasks = [];
  int get listLingth => _tasks.length;
  void toggleTask(int index) async {
    dynamic query = await sqlDb.readData(
        'SELECT id FROM notes WHERE task = "${_tasks[index].task}" AND isDone = ${_tasks[index].isDone}');
    int id = query[0]['id'];
    _tasks[index].toggleDone();

    sqlDb.update('notes', {"isDone": _tasks[index].isDone}, "id=$id");

    notifyListeners();
  }

  UnmodifiableListView<Task>? get tasks => UnmodifiableListView(_tasks);
  void addTask(String title) {
    final task = Task(task: title);
    _tasks.add(task);
    notifyListeners();
  }

  //
  void clearAndRead() {
    _tasks.clear();
    readData();
  }

  void removeTask(index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
