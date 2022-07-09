import 'package:flutter/material.dart';

abstract class TaskViewModel extends ChangeNotifier {
  //CONTENT

  static const _initText = "";

  void _validate() {
    contentIsEmpty = controller.text.isEmpty;
  }

  late final controller = TextEditingController(text: _initText)..addListener(_validate);
  bool _contentIsEmpty = _initText.isEmpty;
  bool get contentIsEmpty => _contentIsEmpty;
  set contentIsEmpty(bool value) {
    _contentIsEmpty = value;
    notifyListeners();
  }

  //IS COMPLETED

  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;
  set isCompleted(bool value) {
    _isCompleted = value;
    notifyListeners();
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
    notifyListeners();
  }

  bool _needToRemind = false;
  bool get needToRemind => _needToRemind;
  set needToRemind(bool value) {
    _needToRemind = value;
    notifyListeners();
  }
}

enum Status {
  syncing,
  synced,
}
