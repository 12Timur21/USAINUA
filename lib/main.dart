import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usainua/pages/splash_screen_page/splash_screen_page.dart';
import 'package:usainua/resources/app_themes.dart';
import 'package:usainua/routes/app_router.dart';

void _errorHandler(Object error, StackTrace stack) {
  log(
    '\nError description: $error'
    '\nStackTrace:\n$stack',
    name: 'Error handler',
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runZonedGuarded(
    () {
      runApp(const MyApp());
    },
    _errorHandler,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.light(),
      initialRoute: SplashScreenPage.routeName,
      onGenerateRoute: AppRouter.generateRoute,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
