import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:reminder/domain/entities/task.dart';
import 'package:reminder/domain/repositories/tasks.dart';

class TasksViewModel extends ChangeNotifier {
  final _repo = GetIt.I.get<TasksRepo>();

  late List<Task> tasks;

  Future<void> sync() async {
    tasks = await _repo.getAll();
    notifyListeners();
  }

  Future<void> set(Task task) async {
    await _repo.insert(task);
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await _repo.delete(tasks.singleWhere((e) => e.id == id));
    notifyListeners();
  }
}
