import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/widgets/text/icon_text.dart';
import 'package:usainua/widgets/text/rich_text_widget.dart';

class ThirdSliderPage extends StatelessWidget {
  const ThirdSliderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width - 48;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 50,
      ),
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
          SizedBox(
            height: 180,
            child: RichTextWidgets(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textStyle: const TextStyle(
                color: Colors.black,
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
                IconText(
                  icon: SvgPicture.asset(
                    AppIcons.tick,
                    alignment: Alignment.topCenter,
                  ),
                  label: 'Более 1.000.000 доставленных товаров',
                  textAlign: TextAlign.center,
                ),
                IconText(
                  icon: SvgPicture.asset(
                    AppIcons.tick,
                    alignment: Alignment.topCenter,
                  ),
                  label: '200.000 пользователей',
                  textAlign: TextAlign.center,
                ),
                IconText(
                  icon: SvgPicture.asset(
                    AppIcons.tick,
                    alignment: Alignment.topCenter,
                  ),
                  label: '4,6 из 5 - Рейтинг основанный на более 1000 отзывов',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
