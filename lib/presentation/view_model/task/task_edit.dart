import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reminder/data/utils/date_time.dart';
import 'package:reminder/domain/entity/task.dart';
import 'package:reminder/domain/repository/tasks.dart';
import 'package:reminder/presentation/view_model/task.dart';

// TODO can I notifyListeners from constructor? Several times?
class TaskEditViewModel extends TaskViewModel {
  final _repo = GetIt.I.get<TasksRepo>();
  late final int id;

  TaskEditViewModel(this.id);

  Status status = Status.sync;

  Future<void> fetchTask() async {
    await Future.value(); //TODO check how to do ALL function asyncly.

    status = Status.sync;
    notifyListeners();

    final task = await _repo.get(id);

    controller = TextEditingController(text: task.content);
    controller.addListener(() => Future(notifyListeners));

    contentIsEmpty = task.content == "";
    isCompleted = task.isCompleted;

    final dateTime = task.reminder;

    if (dateTime != null) {
      needToRemind = true;
      time = TimeOfDay.fromDateTime(dateTime);
      date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    }

    status = Status.synced;
    notifyListeners();
  }

  Future<void> editTask() async {
    status = Status.sync;
    notifyListeners();

    final content = controller.text;

    if (content == "") {
      contentIsEmpty = true;
      return;
    }

    var reminder =
        (needToRemind) ? DateTimeUtils.toNearestNotifiable(DateTimeFactory.from(date, time)) : null;
    final task = Task(id, content, reminder, isCompleted);

    await _repo.update(task);

    status = Status.synced;
    notifyListeners();
  }
}

enum Status {
  sync,
  synced,
}
