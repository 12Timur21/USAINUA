import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usainua/blocs/authentication_bloc/authentification_bloc.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:usainua/pages/main_pages/home_pages/home_page/home_page.dart';
import 'package:usainua/pages/splash_screen_page/splash_screen_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_themes.dart';
import 'package:usainua/routes/app_router.dart';

void _errorHandler(Object error, StackTrace stack) {
  log(
    '\nError description: $error'
    '\nStackTrace:\n$stack',
    name: 'Error handler',
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.scaffold,
      systemNavigationBarColor: AppColors.scaffold,
      systemNavigationBarDividerColor: AppColors.scaffold,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthorizationBloc(),
        ),
        BlocProvider(
          create: (context) => AuthentificationBloc(),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'USA IN UA',
        builder: BotToastInit(),
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light(),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
