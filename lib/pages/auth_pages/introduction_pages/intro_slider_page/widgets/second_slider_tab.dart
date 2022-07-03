import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';

class SecondSliderTab extends StatelessWidget {
  const SecondSliderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CarouselController _carouselController = CarouselController();

    void _previewSlide() {
      _carouselController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }

    void _nextSlide() {
      _carouselController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }

    List<_Slide> _pages = [
      _Slide(
        context: context,
        title: 'Nike Pegasus Trail 2',
        imageURL: AppImages.nikeShoes,
        costInUSA: 130,
        costInUkraine: 202,
        onRightArrowTap: _nextSlide,
        onLeftArrowTap: _previewSlide,
      ),
      _Slide(
        context: context,
        title: 'Published',
        imageURL: AppImages.book,
        costInUSA: 10,
        costInUkraine: 35,
        onRightArrowTap: _nextSlide,
        onLeftArrowTap: _previewSlide,
      ),
      _Slide(
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
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 1,
              ),
              items: _pages,
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

class _Slide extends StatefulWidget {
  const _Slide({
    required this.context,
    required this.title,
    required this.imageURL,
    required this.costInUkraine,
    required this.costInUSA,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    Key? key,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String imageURL;
  final int costInUkraine;
  final int costInUSA;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  @override
  State<_Slide> createState() => _SlideState();
}

class _SlideState extends State<_Slide> {
  late final double _width;
  late final int _priceDifference;

  @override
  void initState() {
    _width = MediaQuery.of(widget.context).size.width - 48;
    _priceDifference = widget.costInUkraine - widget.costInUSA;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 380,
                  width: double.infinity,
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
                        widget.imageURL,
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
                            onPressed: widget.onLeftArrowTap,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: SvgPicture.asset(
                              AppIcons.leftArrow,
                              color: AppColors.darkBlue,
                            ),
                          ),
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: AppFonts.sizeLarge,
                              fontWeight: AppFonts.heavy,
                              letterSpacing: 0.5,
                              color: AppColors.darkBlue,
                            ),
                          ),
                          IconButton(
                            onPressed: widget.onRightArrowTap,
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
                                  _CostInCountries(
                                    title: 'Цена в украине',
                                    cost: widget.costInUkraine,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _CostInCountries(
                                    title: 'Цена в США',
                                    cost: widget.costInUSA,
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
        ),
      ),
    );
  }
}

class _CostInCountries extends StatelessWidget {
  const _CostInCountries({
    required this.title,
    required this.cost,
    Key? key,
  }) : super(key: key);

  final String title;
  final int cost;

  @override
  Widget build(BuildContext context) {
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
}
