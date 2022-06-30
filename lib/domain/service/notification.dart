import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/domain/entity/task.dart';
import 'package:timezone/timezone.dart';

class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      '666',
      'noName',
      importance: Importance.max,
      priority: Priority.high,
    ),
  );

  static const _settings = InitializationSettings(
    android: AndroidInitializationSettings("app_icon"),
  );

  Future<void> schedule(Task task) async {
    final tzDateTime = TZDateTime.from(task.reminder!, local);

    await _plugin.zonedSchedule(
      task.id,
      "Напоминание",
      task.content,
      tzDateTime,
      _details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime, //I dont use Ios.
      androidAllowWhileIdle: true,
    );
  }

  Future<void> init() async {
    await _plugin.initialize(_settings);
  }
}
