import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
//import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationWidget {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String>();
  dynamic locationName;

  Future init({bool sheduled = false}) async {
    const andriod = AndroidInitializationSettings('@mipmap/ic_launcher');
    // ignore: prefer_const_declarations
    final settings = const InitializationSettings(android: andriod);

    await _notification.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload!);
      },
    );

    if (sheduled) {
      tz.initializeTimeZones();

      locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails("channel id", "channel name",
          importance: Importance.max),
    );
  }

  static Future showsheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required Time scheduleDate,
  }) async =>
      _notification.zonedSchedule(id, title, body, _sheduledaily(scheduleDate),
          await notificationDetails(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.time);

  static tz.TZDateTime _sheduledaily(Time time) {
    final now = tz.TZDateTime.now(tz.local)
        .add(Duration(hours: time.hour, minutes: time.minute, seconds: 0));

    final sheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return sheduledDate.isBefore(now)
        ? sheduledDate.add(const Duration(days: 1))
        : sheduledDate;
  }
}
