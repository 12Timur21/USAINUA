import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_images.dart';

import 'package:usainua/resources/app_icons.dart';

import 'package:usainua/widgets/sliders/goods_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 25,
                ),
                _userBalance(),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    _signboard(
                      text: 'Покупка и доставка',
                      backgroundColor: AppColors.spreadLightGreen,
                      foregroundColor: AppColors.lightGreen,
                      image: Image.asset(AppImages.car),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _signboard(
                      text: 'Только доставка',
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.darkBlue,
                      image: Image.asset(AppImages.plane),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _tariffButton(),
                const SizedBox(
                  height: 45,
                ),
                _companiesSlider(),
                const SizedBox(
                  height: 40,
                ),
                const GoodsSlider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget _appBar() {
  return AppBar(
    leading: IconButton(
      icon: SvgPicture.asset(
        AppIcons.bell,
      ),
      onPressed: () {},
    ),
    centerTitle: true,
    title: SvgPicture.asset(
      AppIcons.logo,
    ),
    actions: [
      IconButton(
        icon: SvgPicture.asset(
          AppIcons.dialog,
        ),
        onPressed: () {},
      ),
    ],
  );
}

Widget _userBalance() {
  return RichText(
    text: const TextSpan(
      style: TextStyle(
        color: AppColors.darkBlue,
        fontWeight: AppFonts.bold,
        letterSpacing: 0.5,
        fontSize: AppFonts.sizeSmall,
      ),
      children: [
        TextSpan(
          text: 'Ваш баланс:',
        ),
        TextSpan(
          text: ' 358.93 \$',
          style: TextStyle(
            color: AppColors.lightBlue,
          ),
        ),
        TextSpan(
          text: ' \\ ',
        ),
        TextSpan(
          text: '11157 грн',
          style: TextStyle(
            fontWeight: AppFonts.regular,
          ),
        ),
      ],
    ),
  );
}

Widget _tariffButton() {
  return Align(
    alignment: Alignment.centerLeft,
    child: TextButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(
        AppIcons.calculator,
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      label: const Padding(
        padding: EdgeInsets.only(left: 5),
        child: Text(
          'Тарифы на услуги доставки',
          style: TextStyle(
            color: AppColors.darkBlue,
            fontWeight: AppFonts.bold,
            fontSize: AppFonts.sizeXSmall,
          ),
        ),
      ),
    ),
  );
}

Widget _companiesSlider() {
  final List<Widget> _companiesList = [
    Image.asset(AppImages.amazon),
    Image.asset(AppImages.ebay),
    Image.asset(AppImages.macys),
    Image.asset(AppImages.walmart),
  ];

  return SizedBox(
    height: 50,
    child: ListView.builder(
      itemCount: _companiesList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 120,
          margin: const EdgeInsets.only(
            right: 5,
          ),
          alignment: Alignment.centerLeft,
          child: _companiesList[index],
        );
      },
    ),
  );
}

Widget _signboard({
  required String text,
  required Color backgroundColor,
  required Color foregroundColor,
  required Widget image,
}) {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: const BorderRadius.all(
        Radius.circular(
          10,
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.heavy,
              fontSize: AppFonts.sizeLarge,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: foregroundColor,
              ),
            ),
            Positioned(
              child: image,
              right: 0,
            ),
          ],
        ),
      ],
    ),
  );
}
