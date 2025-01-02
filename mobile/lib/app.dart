import 'package:app/config/routes/app_routes.dart';
import 'package:app/config/themes/theme.dart';
import 'package:app/core/provider/is_dark_theme.dart';
import 'package:app/core/utils/notification_services.dart';
import 'package:app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService.onMessage(message);
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      NotificationService.onMessageOpenedApp(context, message);
    });
    final isDarkTheme = ref.watch(isDarkThemeProvider);

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter app',
      theme: getApplicationTheme(isDarkTheme),
      initialRoute: AppRoutes.splashScreen,
      routes: AppRoutes.getApplicationRoute(),

    );
  }
}
