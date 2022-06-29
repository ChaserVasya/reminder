import 'package:reminder/data/dao/task.dart';
import 'package:reminder/data/entity/task.dart';

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'floor.g.dart'; // the generated code will be there

@Database(version: 1, entities: [PlainTask])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}
