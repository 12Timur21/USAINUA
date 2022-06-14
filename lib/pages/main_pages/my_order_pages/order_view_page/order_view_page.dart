import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:usainua/pages/main_pages/my_order_pages/order_view_page/widgets/address_tab.dart';
import 'package:usainua/pages/main_pages/my_order_pages/order_view_page/widgets/goods_tab.dart';
import 'package:usainua/pages/main_pages/my_order_pages/order_view_page/widgets/tracking_tab.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';

class OrderViewPage extends StatefulWidget {
  const OrderViewPage({Key? key}) : super(key: key);

  static const routeName = '/order_view_page';

  @override
  State<OrderViewPage> createState() => _OrderViewPageState();
}

class _OrderViewPageState extends State<OrderViewPage> {
  final _pageViewController = PageController();

  final List<Widget> _pageList = [
    const AddressTab(),
    const TrackingTab(),
    const GoodsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        onAction: () {},
        text: 'Заказ №735689',
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Только доставка',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.regular,
                fontSize: AppFonts.sizeXSmall,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.antiFlashWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Расчет стоимости',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeXSmall,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _tabSelectionSlider(
              pageViewController: _pageViewController,
            ),
            // Expanded(
            //   child: PageView(
            //     allowImplicitScrolling: true,
            //     onPageChanged: (_) {},
            //     controller: _pageViewController,
            //     children: _pageList,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget _tabSelectionSlider({
  required PageController pageViewController,
  int dotCount = 3,
}) {
  Future<void> _changeSlideByIndex(int index) async {
    await pageViewController.animateToPage(
      index,
      curve: Curves.easeIn,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
  }

  Widget tabCard({
    required SvgPicture svgPicture,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(
          right: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svgPicture,
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeXXSmall,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final listWidgets = [
    tabCard(
      onTap: () {},
      text: 'Отслеживание',
      svgPicture: SvgPicture.asset(
        AppIcons.target,
      ),
    ),
    tabCard(
      onTap: () {},
      text: 'Адрес доставки',
      svgPicture: SvgPicture.asset(
        AppIcons.adressHouse,
      ),
    ),
    tabCard(
      onTap: () {},
      text: 'Товары',
      svgPicture: SvgPicture.asset(
        AppIcons.cart,
        color: AppColors.lightBlue,
      ),
    ),
  ];

  return Container(
    height: 160,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(
        //   height: 80,
        //   child: LoopPageView.builder(
        //     controller: LoopPageController(
        //       initialPage: 0,
        //       viewportFraction: 0.5,
        //     ),
        //     itemCount: 3,
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (BuildContext context, int index) {
        //       return listWidgets[index];
        //     },
        //   ),
        // ),
        const SizedBox(
          height: 15,
        ),
        SmoothPageIndicator(
          controller: pageViewController,
          count: dotCount,
          onDotClicked: _changeSlideByIndex,
          effect: const SlideEffect(
            spacing: 14,
            radius: 4,
            dotWidth: 24,
            dotHeight: 6,
            paintStyle: PaintingStyle.stroke,
            strokeWidth: 1.5,
            dotColor: AppColors.antiFlashWhite,
            activeDotColor: AppColors.lightBlue,
          ),
        ),
      ],
    ),
  );
}
