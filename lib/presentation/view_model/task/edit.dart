import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reminder/data/utils/date_time.dart';
import 'package:reminder/domain/entity/task.dart';
import 'package:reminder/domain/repository/tasks.dart';
import 'package:reminder/presentation/view_model/task.dart';

class TaskEditViewModel extends TaskViewModel {
  final _repo = GetIt.I.get<TasksRepo>();
  late int id;

  TaskEditViewModel(this.id) {
    fetching = fetchTask(id);
  }

  late Future<void> fetching;

  Future<void> fetchTask(int newId) async {
    id = newId;

    final task = await _repo.get(id);

    controller.text = task.content;

    contentIsEmpty = task.content.isEmpty;
    isCompleted = task.isCompleted;

    final dateTime = task.reminder;

    if (dateTime != null) {
      needToRemind = true;
      time = TimeOfDay.fromDateTime(dateTime);
      date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    }

    notifyListeners();
  }

  Future<void> editTask() async {
    DateTime? reminder;

    if (needToRemind)
      reminder = DateTimeUtils.toNearestNotifiable(DateTimeFactory.from(date, time));

    final task = Task(id, controller.text, reminder, isCompleted);

    await _repo.update(task);
  }
}
