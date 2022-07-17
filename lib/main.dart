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
import 'package:usainua/blocs/recipient_address_bloc/recipient_address_bloc.dart';
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

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [SystemUiOverlay.top],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.scaffold,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runZonedGuarded(() {
    runApp(const MyApp());
  }, _errorHandler);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthorizationBloc(),
        ),
        BlocProvider(
          create: (_) => AuthentificationBloc(),
        ),
        BlocProvider(
          create: (_) => NavigationBloc(),
        ),
        BlocProvider(
          create: (_) => RecipientAddressBloc()
            ..add(
              const SyncRecipientAddressWithFirebaseEvent(),
            ),
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
        initialRoute: SplashScreenPage.routeName,
      ),
    );
  }
}
