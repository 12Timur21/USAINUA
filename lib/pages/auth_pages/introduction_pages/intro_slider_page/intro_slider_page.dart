import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/pages/first_slider_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/pages/fourth_slider_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/pages/second_slider_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/pages/third_slider_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_images.dart';

class IntroSliderPage extends StatefulWidget {
  const IntroSliderPage({Key? key}) : super(key: key);

  static const routeName = '/intro_slider_page';

  @override
  State<IntroSliderPage> createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  final PageController _pageViewController = PageController();

  void introShown() async {}

  void onDonePress() {}

  void onTabChangeCompleted(index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageViewController,
              children: const [
                FirstSliderPage(),
                SecondSliderPage(),
                ThirdSliderPage(),
                FourthSliderPage(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: SmoothPageIndicator(
              controller: _pageViewController, // PageController
              count: 4,

              onDotClicked: (index) {},
              effect: const SlideEffect(
                spacing: 14,
                radius: 4,
                dotWidth: 24,
                dotHeight: 6,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 1.5,
                dotColor: AppColors.primary,
                activeDotColor: AppColors.buttonSecondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
