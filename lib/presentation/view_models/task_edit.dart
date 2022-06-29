import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reminder/data/utils/date_time.dart';
import 'package:reminder/domain/entities/task.dart';
import 'package:reminder/domain/repositories/tasks.dart';

// TODO can i notifyListeners from constructor? Several times?
class TaskEditViewModel extends ChangeNotifier {
  final _repo = GetIt.I.get<TasksRepo>();
  late final int id;

  TaskEditViewModel(this.id);
  TaskEditViewModel.from(Task task) {
    id = task.id;
    controller = TextEditingController(text: task.content);
    _isCompleted = task.isCompleted;

    final dateTime = task.reminder;
    if (dateTime == null) return;
    _needToRemind = true;
    _date = dateTime;
    _time = TimeOfDay.fromDateTime(dateTime);

    status = Status.fetched;
  }

  Status status = Status.fetching;

  late final TextEditingController controller;
  DateTime? _date;
  TimeOfDay? _time;
  late bool _isCompleted;
  bool _needToRemind = false;

  void refreshWith(Task task) {
    controller.text = task.content;
    _isCompleted = task.isCompleted;

    final dateTime = task.reminder;

    if (dateTime != null) {
      _needToRemind = true;
      _time = TimeOfDay.fromDateTime(dateTime);
      _date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    }

    Future(() => notifyListeners()); //TODO refactor this
  }

  Future<void> fetchTask() async {
    await Future.value(); //TODO check how to do ALL function asyncly.

    status = Status.fetching;
    notifyListeners();

    final task = await _repo.get(id);

    controller = TextEditingController(text: task.content);
    _isCompleted = task.isCompleted;

    final dateTime = task.reminder;

    if (dateTime != null) {
      _needToRemind = true;
      _time = TimeOfDay.fromDateTime(dateTime);
      _date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    }

    status = Status.fetched;
    notifyListeners();
  }

  Future<void> editTask() async {
    status = Status.editing;
    notifyListeners();

    final content = controller.text;

    DateTime? reminder;
    if (_needToRemind) {
      reminder = DateTimeFactory.from(_date!, _time!);
    }

    final task = Task(id, content, reminder, _isCompleted);

    await _repo.update(task);

    status = Status.edited;
    notifyListeners();
  }

  DateTime? get date => _date;
  set date(DateTime? newDate) {
    _date = newDate;
    notifyListeners();
  }

  TimeOfDay? get time => _time;
  set time(TimeOfDay? newTime) {
    _time = newTime;
    notifyListeners();
  }

  bool get isCompleted => _isCompleted;
  set isCompleted(bool value) {
    _isCompleted = value;
    notifyListeners();
  }

  bool get needToRemind => _needToRemind;
  set needToRemind(bool value) {
    _needToRemind = value;
    notifyListeners();
  }
}

enum Status {
  fetching,
  fetched,
  editing,
  edited,
}
