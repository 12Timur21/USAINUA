import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';

class SecondSliderPage extends StatelessWidget {
  const SecondSliderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoopPageController _pageViewController = LoopPageController();

    void _previewSlide() {
      _pageViewController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }

    void _nextSlide() {
      _pageViewController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }

    List<Widget> _pages = [
      _slide(
        context: context,
        title: 'Nike Pegasus Trail 2',
        imageURL: AppImages.nikeShoes,
        costInUSA: 130,
        costInUkraine: 202,
        onRightArrowTap: _nextSlide,
        onLeftArrowTap: _previewSlide,
      ),
      _slide(
        context: context,
        title: 'Published',
        imageURL: AppImages.book,
        costInUSA: 10,
        costInUkraine: 35,
        onRightArrowTap: _nextSlide,
        onLeftArrowTap: _previewSlide,
      ),
      _slide(
        context: context,
        title: 'Louis Vuitton',
        imageURL: AppImages.handBag,
        costInUSA: 250,
        costInUkraine: 300,
        onRightArrowTap: _nextSlide,
        onLeftArrowTap: _previewSlide,
      ),
    ];

    return Container(
      height: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 24,
      ),
      child: Column(
        children: [
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: LoopPageView.builder(
                controller: _pageViewController,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _pages[index];
                },
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
            color: AppColors.secondary,
            height: 75,
            child: Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.regular,
                    fontSize: AppFonts.sizeXSmall,
                    letterSpacing: 0.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'Срок доставки примерно '),
                    TextSpan(
                      text: '10 дней',
                      style: TextStyle(
                        fontWeight: AppFonts.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _slide({
  required BuildContext context,
  required String title,
  required String imageURL,
  required int costInUkraine,
  required int costInUSA,
  required VoidCallback onLeftArrowTap,
  required VoidCallback onRightArrowTap,
}) {
  final double _width = MediaQuery.of(context).size.width - 48;
  final int _priceDifference = costInUkraine - costInUSA;

  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 380,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 15),
                  blurRadius: 23,
                  color: AppColors.boxShadow.withOpacity(0.09),
                ),
              ],
              border: Border.all(
                width: 1,
                color: AppColors.primary,
              ),
              color: Colors.white,
            ),
          ),
          Positioned(
            top: -50,
            width: _width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: SizedBox(
                width: 300,
                height: 150,
                child: Image.asset(
                  imageURL,
                  fit: BoxFit.contain,
                  width: 400,
                ),
              ),
            ),
          ),

          Positioned(
            width: _width,
            top: 120,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: onLeftArrowTap,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: SvgPicture.asset(
                        AppIcons.leftArrow,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: AppFonts.sizeLarge,
                        fontWeight: AppFonts.heavy,
                        letterSpacing: 0.5,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    IconButton(
                      onPressed: onRightArrowTap,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: SvgPicture.asset(
                        AppIcons.rightArrow,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Column(
                          children: [
                            _costInCountries(
                              title: 'Цена в украине',
                              cost: costInUkraine,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _costInCountries(
                              title: 'Цена в США',
                              cost: costInUSA,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 75,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: AppColors.darkBlue,
                                fontWeight: AppFonts.heavy,
                                fontSize: AppFonts.sizeXXLarge,
                                letterSpacing: 0.5,
                              ),
                              children: <TextSpan>[
                                const TextSpan(text: 'Экономия '),
                                TextSpan(
                                  text: '$_priceDifference\$',
                                  style: const TextStyle(
                                    fontWeight: AppFonts.heavy,
                                    color: AppColors.lightGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // const SizedBox(
          //   height: 12,
          // ),
        ],
      ),
    ],
  );
}

Widget _costInCountries({
  required String title,
  required int cost,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: AppColors.darkBlue,
          fontWeight: AppFonts.regular,
          fontSize: AppFonts.sizeXSmall,
          letterSpacing: 1,
        ),
      ),
      Text(
        '$cost\$',
        style: const TextStyle(
          color: AppColors.darkBlue,
          fontWeight: AppFonts.bold,
          fontSize: AppFonts.sizeSmall,
          letterSpacing: 0.5,
        ),
      ),
    ],
  );
}
