import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loop_page_view/loop_page_view.dart';
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
        height: MediaQuery.of(context).size.height,
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
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
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
            Expanded(
              child: PageView(
                allowImplicitScrolling: true,
                onPageChanged: (_) {},
                controller: _pageViewController,
                children: _pageList,
              ),
            ),
          ],
        ),
      ),
    );
  }
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

  final List<Widget> listWidgets = [
    tabCard(
      onTap: () {
        pageViewController.animateToPage(
          0,
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.easeIn,
        );
      },
      text: 'Отслеживание',
      svgPicture: SvgPicture.asset(
        AppIcons.target,
      ),
    ),
    tabCard(
      onTap: () {
        pageViewController.animateToPage(
          1,
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.easeIn,
        );
      },
      text: 'Адрес доставки',
      svgPicture: SvgPicture.asset(
        AppIcons.adressHouse,
      ),
    ),
    tabCard(
      onTap: () {
        pageViewController.animateToPage(
          2,
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.easeIn,
        );
      },
      text: 'Товары',
      svgPicture: SvgPicture.asset(
        AppIcons.cart,
        color: AppColors.lightBlue,
      ),
    ),
  ];

  return Container(
    height: 150,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 80,
            viewportFraction: 0.5,
          ),
          items: listWidgets,
        ),
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
