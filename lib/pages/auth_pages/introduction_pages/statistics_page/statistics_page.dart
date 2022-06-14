import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/pages/main_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  static const routeName = '/statistics_page';

  @override
  Widget build(BuildContext context) {
    void _nextPage() {
      Navigator.of(context).pushReplacementNamed(
        MainPage.routeName,
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                child: SizedBox(
                  height: 500,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const RichTextWrapper(
                        textStyle: TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: AppFonts.heavy,
                          letterSpacing: 1,
                        ),
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                '9000',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 125,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: FittedBox(
                              alignment: Alignment.topCenter,
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'высаженных',
                                style: TextStyle(
                                  fontSize: 37,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'деревьев',
                                style: TextStyle(
                                  fontSize: 56,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        AppImages.tree,
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 22,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Наша плантация деревьев ежегодно:',
                        style: TextStyle(
                          color: AppColors.darkBlue,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                            child: SvgPicture.asset(AppIcons.co2),
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: AppColors.darkBlue,
                                fontWeight: AppFonts.bold,
                                fontSize: AppFonts.sizeXSmall,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Поглощено ',
                                ),
                                TextSpan(
                                  text: '130 тон ',
                                  style: TextStyle(
                                    color: AppColors.lightBlue,
                                  ),
                                ),
                                TextSpan(
                                  text: 'углекислого газа',
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                            child: SvgPicture.asset(AppIcons.o2),
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: AppColors.darkBlue,
                                fontWeight: AppFonts.bold,
                                fontSize: AppFonts.sizeXSmall,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Произведено ',
                                ),
                                TextSpan(
                                  text: '36 тон ',
                                  style: TextStyle(
                                    color: AppColors.lightBlue,
                                  ),
                                ),
                                TextSpan(
                                  text: 'кислорода',
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                '10 грн с каждого кг идут на высадку деревьев',
                style: TextStyle(
                  color: AppColors.darkBlue,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SubmitButton(text: 'Начать', onTap: _nextPage),
            ],
          ),
        ),
      ),
    );
  }
}
