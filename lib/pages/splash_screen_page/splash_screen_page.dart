import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/blocs/orders_bloc/orders_bloc.dart';
import 'package:usainua/blocs/recipient_address_bloc/recipient_address_bloc.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/welcome_page/welcome_page.dart';
import 'package:usainua/pages/auth_pages/sign_in_page/sign_in_page.dart';
import 'package:usainua/pages/main_page.dart';
import 'package:usainua/resources/app_icons.dart';

import '../../blocs/authorization_bloc/authorization_bloc.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  // const Duration splashScreenDuration = Duration(
  //   seconds: 1,
  // );

  @override
  void initState() {
    context.read<RecipientAddressBloc>().add(
          const SyncRecipientAddressWithFirebaseEvent(),
        );

    context.read<OrdersBloc>().add(
          const SyncOrdersWithFirebaseEvent(),
        );
    // Timer(splashScreenDuration, () {
    context.read<AuthorizationBloc>().add(
          AppLoaded(),
        );
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {
        if (state.authorizationStatus == AuthorizationStatus.unauthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            SignInPage.routeName,
            (Route<dynamic> route) => false,
          );
        }
        if (state.authorizationStatus == AuthorizationStatus.authenticated) {
          context.read<AuthorizationBloc>().add(
                UserLoggedIn(
                  userModel: state.userModel!,
                  isNewUser: state.isNewUser,
                ),
              );
          if (state.isNewUser) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              WelcomePage.routeName,
              (Route<dynamic> route) => false,
            );
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
              MainPage.routeName,
              (Route<dynamic> route) => false,
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
