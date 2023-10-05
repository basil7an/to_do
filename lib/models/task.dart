class Task {
  String task;
  int isDone;
  Task({required this.task, this.isDone = 0});
  toggleDone() {
    if (isDone == 0) {
      isDone = 1;
    } else if (isDone == 1) {
      isDone = 0;
    }
  }
}
