import 'package:flutter/material.dart';

abstract class TaskViewModel extends ChangeNotifier {
  //CONTENT

  TextEditingController controller = TextEditingController();
  bool _contentIsEmpty = true;
  bool get contentIsEmpty => _contentIsEmpty;
  set contentIsEmpty(bool value) {
    _contentIsEmpty = value;
    Future(() => notifyListeners());
  }

  //IS COMPLETED

  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;
  set isCompleted(bool value) {
    _isCompleted = value;
    Future(() => notifyListeners());
  }

  //DATETIME

  //They are implemented as callbacks to always take the actual time
  final createDefaultDate = () => DateTime.now().add(const Duration(minutes: 1));
  late final createDefaultTime = () => TimeOfDay.fromDateTime(createDefaultDate());

  DateTime? _date;
  DateTime get date => _date ??= createDefaultDate();
  set date(DateTime newDate) {
    _date = newDate;
    Future(() => notifyListeners());
  }

  TimeOfDay? _time;
  TimeOfDay get time => _time ??= createDefaultTime();
  set time(TimeOfDay newTime) {
    _time = newTime;
    Future(() => notifyListeners());
  }

  bool _needToRemind = false;
  bool get needToRemind => _needToRemind;
  set needToRemind(bool value) {
    _needToRemind = value;
    Future(() => notifyListeners());
  }
}

enum Status {
  syncing,
  synced,
}
