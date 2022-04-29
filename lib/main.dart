import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usainua/pages/auth_pages/Introduction_page/introduction_page.dart';
import 'package:usainua/pages/auth_pages/remind_password_page/remind_password_page.dart';
import 'package:usainua/pages/auth_pages/sign_in_page/sign_in_page.dart';
import 'package:usainua/pages/auth_pages/sign_up_page/sign_up_page.dart';
import 'package:usainua/pages/auth_pages/verification_code_page/verification_code_page.dart';
import 'package:usainua/pages/privacy_terms_page/privacy_terms_page.dart';

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
      title: 'USA IN UA',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: IntroductionPage.routeName,
    );
  }
}
