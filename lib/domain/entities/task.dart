import 'package:reminder/domain/entities/reminder.dart';

class Task {
  final Reminder? reminder;
  final String content;
  final bool isCompleted;

  Task(this.content, [this.reminder, this.isCompleted = false]);
}
