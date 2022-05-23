import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_images.dart';

class FirstSliderPage extends StatelessWidget {
  const FirstSliderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 24,
      ),
      color: AppColors.primary,
      child: Column(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(400, 200),
                bottomRight: Radius.elliptical(400, 200),
              ),
              color: Colors.white,
            ),
            child: Center(
              child: Image.asset(
                AppImages.relaxingGirl,
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Покупка и доставка  товаров в США и Европе  с нами легко',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.heavy,
                      fontSize: AppFonts.sizeLarge,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Нада сюди придумати пару строчок тексту просто привітального',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.bold,
                      fontSize: AppFonts.sizeXSmall,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'USAIN.UA',
                    style: TextStyle(
                      color: AppColors.lightGreen,
                      fontWeight: AppFonts.bold,
                      fontSize: AppFonts.sizeXSmall,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
