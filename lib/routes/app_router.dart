import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/intro_slider_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/statistics_page/statistics_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/welcome_page/welcome_page.dart';
import 'package:usainua/pages/auth_pages/remind_password_page/remind_password_page.dart';
import 'package:usainua/pages/auth_pages/sign_in_page/sign_in_page.dart';
import 'package:usainua/pages/auth_pages/sign_up_page/sign_up_page.dart';
import 'package:usainua/pages/auth_pages/verification_code_page/verification_code_page.dart';

import 'package:usainua/pages/main_pages/home_screen/home_page.dart';
import 'package:usainua/pages/privacy_terms_page/privacy_terms_page.dart';
import 'package:usainua/pages/splash_screen_page/splash_screen_page.dart';

class AppRouter {
  const AppRouter._();

  static PageTransition generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;

    Widget builder;
    print(settings.name);
    switch (settings.name) {
      case SplashScreenPage.routeName:
        builder = const SplashScreenPage();
        break;

      case PrivacyTermsPage.routeName:
        String? mdFileName = arguments as String?;
        builder = PrivacyTermsPage(
          mdFileName: mdFileName!,
        );
        break;

      //? [START] Auth pages
      case SignInPage.routeName:
        builder = const SignInPage();
        break;

      case SignUpPage.routeName:
        builder = const SignUpPage();
        break;

      case VerificationCodePage.routeName:
        builder = const VerificationCodePage();
        break;

      case RemindPasswordPage.routeName:
        builder = const RemindPasswordPage();
        break;

      //? [END] Auth pages

      //? [START] Intro page
      case WelcomePage.routeName:
        builder = const WelcomePage();
        break;

      case IntroSliderPage.routeName:
        builder = const IntroSliderPage();
        break;

      case StatisticsPage.routeName:
        builder = const StatisticsPage();
        break;
      //? [END] Intro page

      //? [START] Main pages
      case HomePage.routeName:
        builder = const HomePage();
        break;
      //? [START] Main pages

      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return PageTransition(
      child: builder,
      settings: settings,
      type: PageTransitionType.rightToLeft,
    );
  }
}
