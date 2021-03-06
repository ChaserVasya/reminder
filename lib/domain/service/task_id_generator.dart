import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:reminder/domain/repository/tasks.dart';

class TaskIdGenerator {
  final _repo = GetIt.I.get<TasksRepo>();

  Future<int> generate() async {
    final tasks = await _repo.getAll();

    if (tasks.isEmpty) return 1;
    var maxId = tasks.map((e) => e.id).reduce(max);

    return ++maxId;
  }
}
