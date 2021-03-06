import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:reminder/domain/entity/task.dart';
import 'package:reminder/domain/repository/tasks.dart';

class TasksViewModel extends ChangeNotifier {
  final _repo = GetIt.I.get<TasksRepo>();

  late List<Task> tasks;

  Future<void> sync() async {
    tasks = await _repo.getAll();
    notifyListeners();
  }

  Future<void> set(Task task) async {
    if (tasks.map((e) => e.id).contains(task.id))
      await _repo.update(task);
    else
      await _repo.insert(task);
    await sync();
  }

  Future<void> delete(int id) async {
    await _repo.delete(tasks.singleWhere((e) => e.id == id));
    await sync();
  }
}
