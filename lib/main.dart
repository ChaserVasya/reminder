import 'dart:async';

import 'package:flutter/material.dart';

import 'application/app.dart';
import 'application/error/error_handler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runZonedGuarded(() {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    FlutterError.onError = ErrorHandler.onFlutterError;
    runApp(const App());
  }, ErrorHandler.onZoneError);
}
