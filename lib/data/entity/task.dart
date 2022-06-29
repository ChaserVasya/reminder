import 'package:floor/floor.dart';

@entity
class PlainTask {
  @primaryKey
  final int id;
  final String content;
  final int? reminder;
  final bool isCompleted;

  const PlainTask(this.id, this.content, [this.reminder, this.isCompleted = false]);
}
