import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_images.dart';

class GoodsSlider extends StatelessWidget {
  const GoodsSlider({
    // required this.itemPhoto,
    Key? key,
  }) : super(key: key);

  // final List<Image> itemPhoto;

  @override
  Widget build(BuildContext context) {
    final List<Image> _goodsList = [
      Image.asset(AppImages.jacket),
      Image.asset(AppImages.watch),
      Image.asset(AppImages.nikeShoes),
      Image.asset(AppImages.handBag),
      Image.asset(AppImages.book),
    ];

    //TODO под модификацию
    return SizedBox(
      height: 215,
      child: ListView.builder(
        itemCount: _goodsList.length,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (BuildContext context, int index) {
          return _card(
            image: _goodsList[index],
          );
        },
      ),
    );
  }
}

Widget _card({
  Image? image,
}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned(
        right: 7,
        top: 26,
        child: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: AppColors.antiFlashWhite,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '75\$',
              style: TextStyle(
                color: Colors.white,
                fontWeight: AppFonts.bold,
                fontSize: AppFonts.sizeXSmall,
              ),
            ),
          ),
        ),
      ),
      Container(
        width: 160,
        margin: const EdgeInsets.only(
          right: 5,
        ),
        decoration: BoxDecoration(
          // color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          //     .withOpacity(1.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            width: 2,
            color: AppColors.primary,
          ),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 115,
                width: 115,
                child: image,
              ),
              Column(
                children: const [
                  Text(
                    'Columbia cxl 123',
                    style: TextStyle(
                      fontSize: AppFonts.sizeXSmall,
                      fontWeight: AppFonts.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'www.columbia.сom',
                    style: TextStyle(
                      fontSize: AppFonts.sizeXSmall,
                      fontWeight: AppFonts.regular,
                      color: AppColors.darkBlue,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      Positioned(
        right: 7,
        top: -5,
        child: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: AppColors.darkBlue,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '50\$',
              style: TextStyle(
                color: Colors.white,
                fontWeight: AppFonts.bold,
                fontSize: AppFonts.sizeXSmall,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
