class Task {
  final int id;
  final String content;
  final DateTime? reminder;
  final bool isCompleted;

  const Task(this.id, this.content, [this.reminder, this.isCompleted = false]);
}
