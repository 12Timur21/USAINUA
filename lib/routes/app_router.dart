import 'package:flutter/material.dart';
import 'package:usainua/pages/main_page.dart';
import 'package:usainua/pages/splash_screen_page/splash_screen_page.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;

    WidgetBuilder builder;

    switch (settings.name) {
      case SplashScreenPage.routeName:
        builder = (_) => const MainPage();
        break;

      case MainPage.routeName:
        builder = (_) => const MainPage();
        break;

      // [START] Auth pages
      // [END] Auth pages

      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
