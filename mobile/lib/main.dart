import 'dart:async';
import 'package:all_sensors2/all_sensors2.dart';
import 'package:app/app.dart';
import 'package:app/core/network/hive_service.dart';
import 'package:app/core/utils/notification_services.dart';

import 'package:app/features/starting/presentation/view/get_started.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  double proximityValue = 0.0;
  await Firebase.initializeApp();
  final List<StreamSubscription<dynamic>> streamSubscription = [];
  // List<double> accelerometerValue = [];
  // final List<StreamSubscription<dynamic>> streamSubscription0 = [];
  // streamSubscription0.add(accelerometerEvents!.listen((event) {
  //   accelerometerValue = [event.x, event.y, event.z];
  //   final List<String> accelerometer =
  //       accelerometerValue.map((double v) => v.toStringAsFixed(1)).toList();

  // }));

  // Subscribe to accelerometer events
  streamSubscription.add(proximityEvents!.listen((event) async {
    proximityValue = event.proximity;
    if (proximityValue < 5) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Remove the token from SharedPreferences
      prefs.remove('token');
      // perfs.remove('user');
      // Navigate to the "get started" page
      print("loging outttttttttttttttttttttttttt");
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => const GetStarted()),
      );
    }
  }));
  //ensure hive is initialized before app running
  await HiveService().init();
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  await NotificationService.initializeNotification();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: false,
    sound: true,
  );

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('we have received a notification ${message.notification}');
}
