import 'dart:async';

import 'package:flutter/material.dart';

import 'application/app.dart';
import 'application/error/error_handler.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = ErrorHandler.onFlutterError;
    runApp(const App());
  }, ErrorHandler.onZoneError);
}
