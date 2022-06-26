import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/widgets/text/icon_text.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';

class ThirdSliderTab extends StatelessWidget {
  const ThirdSliderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 50,
      ),
      alignment: Alignment.center,
      // color: Colors.blueAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  border: Border.all(
                    width: 1,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Positioned(
                top: -50,
                child: Image.asset(
                  AppImages.delivaeryMan,
                  height: 300,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: RichTextWrapper(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textStyle: const TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: AppFonts.sizeXSmall,
                  fontWeight: AppFonts.bold,
                ),
                children: [
                  IconText(
                    icon: SvgPicture.asset(
                      AppIcons.tick,
                      alignment: Alignment.topCenter,
                    ),
                    label: '8 лет на рынке',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IconText(
                    icon: SvgPicture.asset(
                      AppIcons.tick,
                      alignment: Alignment.topCenter,
                    ),
                    label: 'Более 1.000.000 доставленных товаров',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IconText(
                    icon: SvgPicture.asset(
                      AppIcons.tick,
                      alignment: Alignment.topCenter,
                    ),
                    label: '200.000 пользователей',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IconText(
                    icon: SvgPicture.asset(
                      AppIcons.tick,
                      alignment: Alignment.topCenter,
                    ),
                    label:
                        '4,6 из 5 - Рейтинг основанный на более 1000 отзывов',
                    textAlign: TextAlign.center,
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
