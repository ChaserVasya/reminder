import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:reminder/domain/repositories/tasks.dart';

class TaskIdGenerator {
  final _repo = GetIt.I.get<TasksRepo>();

  Future<int> generate() async {
    final tasks = await _repo.getAll();

    var maxId = tasks.map((e) => e.id).reduce(max);

    return ++maxId;
  }
}
