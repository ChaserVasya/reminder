import 'package:reminder/domain/entity/task.dart';

abstract class TasksRepo {
  Future<List<Task>> getAll();
  Future<Task> get(int id);
  Future<void> insert(Task task);
  Future<void> update(Task task);
  Future<void> delete(Task task);
}
