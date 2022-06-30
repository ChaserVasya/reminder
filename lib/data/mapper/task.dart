import 'package:reminder/data/entity/task.dart';
import 'package:reminder/domain/entity/task.dart';

class TaskMapper {
  static Task toTask(PlainTask plain) {
    return Task(
      plain.id,
      plain.content,
      (plain.reminder != null) ? DateTime.fromMillisecondsSinceEpoch(plain.reminder!) : null,
      plain.isCompleted,
    );
  }

  static PlainTask toPlainTask(Task task) {
    return PlainTask(
      task.id,
      task.content,
      task.reminder?.millisecondsSinceEpoch,
      task.isCompleted,
    );
  }
}
