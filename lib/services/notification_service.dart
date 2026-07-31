import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import '../data/notification_content.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<void> init() async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));

    const androidInit = AndroidInitializationSettings('ic_notification');

    const initSettings = InitializationSettings(
      android: androidInit,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  static void _onNotificationTap(
    NotificationResponse response,
  ) {
    if (response.payload == 'daily_verse') {
      // A navegação será conectada na próxima etapa.
    }
  }

  static Future<void> requestPermission() async {
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidImpl?.requestNotificationsPermission();
  }

  static Future<void> scheduleDailyNotifications() async {
    await _plugin.cancelAll();

    const slots = [
      (hour: 7, minute: 0, kind: 'verse'),
      (hour: 12, minute: 0, kind: 'motivational'),
      (hour: 18, minute: 0, kind: 'prayer'),
      (hour: 21, minute: 0, kind: 'hope'),
    ];

    const androidDetails = AndroidNotificationDetails(
      'devocional_diario',
      'Lembretes Diários',
      channelDescription:
          'Versículos, frases e lembretes de oração diários',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'ic_notification',
      color: Color(0xFF9C7A5C),
    );

    const details = NotificationDetails(
      android: androidDetails,
    );

    final rnd = Random();
    int id = 0;

    for (final slot in slots) {
      final title = _titleFor(slot.kind);
      final body = _bodyFor(slot.kind, rnd);

      await _plugin.zonedSchedule(
        id++,
        title,
        body,
        _nextInstanceOf(slot.hour, slot.minute),
        details,
        payload: slot.kind == 'verse' ? 'daily_verse' : null,
        androidScheduleMode:
            AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents:
            DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  static tz.TZDateTime _nextInstanceOf(
    int hour,
    int minute,
  ) {
    final now = tz.TZDateTime.now(tz.local);

    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled =
          scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  static String _titleFor(String kind) {
    switch (kind) {
      case 'verse':
        return '📖 Versículo do Dia';
      case 'motivational':
        return '✨ Uma palavra para você';
      case 'prayer':
        return '🙏 Momento de Oração';
      case 'hope':
        return '🌙 Antes de dormir';
      default:
        return 'Devocional+';
    }
  }

  static String _bodyFor(
    String kind,
    Random rnd,
  ) {
    switch (kind) {
      case 'verse':
        final v =
            dailyVerses[rnd.nextInt(dailyVerses.length)];
        return '"${v.text}" — ${v.ref}';

      case 'motivational':
        return motivationalPhrases[
            rnd.nextInt(motivationalPhrases.length)];

      case 'prayer':
        return prayerReminders[
            rnd.nextInt(prayerReminders.length)];

      case 'hope':
        return hopeMessages[
            rnd.nextInt(hopeMessages.length)];

      default:
        return 'Aproxime-se de Deus hoje.';
    }
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
