import 'package:flutter/material.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/intro_slider_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static const routeName = '/welcome_page';

  @override
  Widget build(BuildContext context) {
    void _nextPage() {
      Navigator.of(context).pushNamedAndRemoveUntil(
        IntroSliderPage.routeName,
        (Route<dynamic> route) => false,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 330,
                child: Image.asset(
                  AppImages.deliveryScene,
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.heavy,
                    fontSize: AppFonts.sizeXXLarge,
                    letterSpacing: 0.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Добро пожаловать в мир шопинга вместе с USA'),
                    TextSpan(
                      text: 'in',
                      style: TextStyle(
                        color: AppColors.lightGreen,
                      ),
                    ),
                    TextSpan(
                      text: 'UA!',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Логин и пароль был отправлен на Ваш e-mail. Если пароль не получен, проверьте папку “СПАМ”',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.regular,
                  fontSize: AppFonts.sizeXSmall,
                  letterSpacing: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
              SubmitButton(
                onTap: _nextPage,
                text: 'Продолжить',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
