import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/welcome_page/welcome_page.dart';
import 'package:usainua/pages/auth_pages/sign_in_page/sign_in_page.dart';
import 'package:usainua/pages/main_pages/home_page/home_page.dart';
import 'package:usainua/pages/main_pages/main_page.dart';
import 'package:usainua/resources/app_icons.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    const Duration splashScreenDuration = Duration(
      seconds: 1,
    );

    // Timer(splashScreenDuration, () {
    context.read<AuthorizationBloc>().add(
          AppLoaded(),
        );
    // });

    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {
        print(state);
        if (state is AuthorizationUnauthenticated) {
          Navigator.of(context).pushNamed(
            SignInPage.routeName,
            // (Route<dynamic> route) => false,
          );
        }
        if (state is AuthorizationAuthenticated) {
          if (state.isNewUser) {
            Navigator.of(context).pushNamed(
              WelcomePage.routeName,
              // (Route<dynamic> route) => false,
            );
          } else {
            Navigator.of(context).pushNamed(
              MainPage.routeName,
              // (Route<dynamic> route) => false,
            );
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: SvgPicture.asset(
            AppIcons.logo,
            semanticsLabel: 'USA in UA logo',
          ),
        ),
      ),
    );
  }
}
