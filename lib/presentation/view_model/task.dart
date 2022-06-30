import 'package:flutter/material.dart';

abstract class TaskViewModel extends ChangeNotifier {
  //CONTENT

  TextEditingController controller = TextEditingController();
  bool _contentIsEmpty = true;
  bool get contentIsEmpty => _contentIsEmpty;
  set contentIsEmpty(bool value) {
    _contentIsEmpty = value;
    notifyListeners();
  }

  set contentIsEmptySilently(bool value) => _contentIsEmpty = value;

  //IS COMPLETED

  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;
  set isCompleted(bool value) {
    _isCompleted = value;
    notifyListeners();
  }

  set isCompletedSilently(bool value) => _isCompleted = value;

  //DATETIME

  //They are implemented as callbacks to always take the actual time
  final createDefaultDate = () => DateTime.now().add(const Duration(minutes: 1));
  late final createDefaultTime = () => TimeOfDay.fromDateTime(createDefaultDate());

  DateTime? _date;
  DateTime get date => _date ??= createDefaultDate();
  set date(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }

  set dateSilently(DateTime value) => _date = value;

  TimeOfDay? _time;
  TimeOfDay get time => _time ??= createDefaultTime();
  set time(TimeOfDay newTime) {
    _time = newTime;
    notifyListeners();
  }

  set timeSilently(TimeOfDay value) => _time = value;

  bool _needToRemind = false;
  bool get needToRemind => _needToRemind;
  set needToRemind(bool value) {
    _needToRemind = value;
    notifyListeners();
  }

  set needToRemindSilently(bool value) => _needToRemind = value;
}

enum TextStatus {
  right,
  wrong,
}

enum Status {
  sync,
  synced,
}
