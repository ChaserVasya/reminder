import 'package:reminder/domain/entity/task.dart';
import 'package:reminder/domain/repository/tasks.dart';

class MoskTasksRepo implements TasksRepo {
  @override
  Future<void> delete(Task deletingTask) async {
    _tasks.removeWhere((task) => task.id == deletingTask.id);
  }

  @override
  Future<Task> get(int id) async {
    return _tasks.singleWhere((task) => task.id == id);
  }

  @override
  Future<List<Task>> getAll() async {
    return List.from(_tasks);
  }

  @override
  Future<void> insert(Task task) async {
    _tasks.add(task);
  }

  @override
  Future<void> update(Task updatedTask) async {
    final i = _tasks.indexWhere((task) => task.id == updatedTask.id);
    _tasks[i] = updatedTask;
  }

  static final List<Task> _tasks = [
    Task(
      1,
      "Task 1",
      DateTime(2023),
    ),
    Task(
      2,
      "Task 2",
      DateTime(2024),
    ),
    Task(
      3,
      "Task 3",
      DateTime(2025),
    ),
    Task(
      4,
      "Task 4",
      DateTime(2026),
    ),
    Task(
      5,
      "Task 5",
      DateTime(2027),
    ),
    Task(
      6,
      "Task 6",
      DateTime(2028),
    ),
  ];
}
