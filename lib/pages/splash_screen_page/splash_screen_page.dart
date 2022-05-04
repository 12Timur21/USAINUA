import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/pages/auth_pages/sign_in_page/sign_in_page.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    print('WTF');
    // Future.delayed(const Duration(seconds: 3), () {
    //   Navigator.of(context).pushNamed(
    //     SignInPage.routeName,
    //   );
    // });

    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          AppIcons.logo,
          semanticsLabel: 'USA in UA logo',
        ),
      ),
    );
  }
}
