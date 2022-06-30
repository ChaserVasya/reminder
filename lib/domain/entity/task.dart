class Task {
  final int id;
  final String content;
  final DateTime? reminder;
  final bool isCompleted;

  const Task(
    this.id,
    this.content, [
    this.reminder,
    this.isCompleted = false,
  ]);

  const Task.named({
    required this.id,
    required this.content,
    this.reminder,
    this.isCompleted = false,
  });
}
