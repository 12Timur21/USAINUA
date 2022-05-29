import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/pages/first_slider_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/pages/fourth_slider_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/pages/second_slider_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/pages/third_slider_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/statistics_page/statistics_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

class IntroSliderPage extends StatefulWidget {
  const IntroSliderPage({Key? key}) : super(key: key);

  static const routeName = '/intro_slider_page';

  @override
  State<IntroSliderPage> createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  final PageController _pageViewController = PageController();

  void _nextSlide() async {
    if (_pageViewController.page?.toInt() == _pageList.length - 1) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        StatisticsPage.routeName,
        (Route<dynamic> route) => false,
      );
    } else {
      await _pageViewController.nextPage(
        curve: Curves.easeInBack,
        duration: const Duration(
          milliseconds: 500,
        ),
      );
    }
  }

  void _previewPage() async {
    await _pageViewController.previousPage(
      curve: Curves.easeInBack,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    await _pageViewController.previousPage(
      curve: Curves.easeInBack,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
  }

  void _changeSlideByIndex(int index) async {
    await _pageViewController.animateToPage(
      index,
      curve: Curves.easeInBack,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
  }

  final List<Widget> _pageList = const [
    FirstSliderPage(),
    SecondSliderPage(),
    ThirdSliderPage(),
    FourthSliderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              allowImplicitScrolling: true,
              onPageChanged: (_) {},
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
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _previewPage,
                  child: const Text(
                    'Назад',
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.bold,
                      fontSize: AppFonts.sizeXSmall,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _pageViewController,
                  count: _pageList.length,
                  onDotClicked: _changeSlideByIndex,
                  effect: const SlideEffect(
                    spacing: 14,
                    radius: 4,
                    dotWidth: 24,
                    dotHeight: 6,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: AppColors.primary,
                    activeDotColor: AppColors.lightBlue,
                  ),
                ),
                TextButton(
                  onPressed: _nextSlide,
                  child: const Text(
                    'Далее',
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.bold,
                      fontSize: AppFonts.sizeXSmall,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
