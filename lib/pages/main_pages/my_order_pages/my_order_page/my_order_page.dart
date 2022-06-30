import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/models/delivery_status.dart';
import 'package:usainua/models/product_model.dart';
import 'package:usainua/pages/main_pages/my_order_pages/order_view_page/order_view_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/text/icon_text.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  static const routeName = '/my_order_page';

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  final List<DeliveryStatusModel> _deliveryStatusModels = const [
    DeliveryStatusModel(
      textStatus: 'Не оплечено',
      svgIconUrl: AppIcons.moneyBag,
      deliveryStatus: DeliveryStatus.notPaid,
    ),
    DeliveryStatusModel(
      textStatus: 'Ожидает на отправку',
      svgIconUrl: AppIcons.box,
      deliveryStatus: DeliveryStatus.awaitingToSend,
    ),
    DeliveryStatusModel(
      textStatus: 'Отправлен Вам',
      svgIconUrl: AppIcons.plane,
      deliveryStatus: DeliveryStatus.sentToYou,
    ),
    DeliveryStatusModel(
      textStatus: 'Успешно получен',
      svgIconUrl: AppIcons.likeInBox,
      deliveryStatus: DeliveryStatus.successfullyRecived,
    ),
    DeliveryStatusModel(
      textStatus: 'Оставлен отзыв',
      svgIconUrl: AppIcons.like,
      deliveryStatus: DeliveryStatus.leaveFeedback,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Мои заказы',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.heavy,
                fontSize: AppFonts.sizeXXLarge,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemCount: _deliveryStatusModels.length,
                itemBuilder: (BuildContext context, int index) {
                  return _filterCard(
                    deliveryStatusModel: _deliveryStatusModels[index],
                    onTap: (DeliveryStatus status) {},
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: _orderedProductCard(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          OrderViewPage.routeName,
                        );
                      },
                      productModel: ProductModel(
                        id: '123213123',
                        deliveryDate: DateTime.now(),
                        deliveryMethod: DeliveryMethod.air,
                        price: 1233.22,
                        weight: 123.1,
                        deliveryStatus: DeliveryStatus.awaitingToSend,
                        link: '',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _orderedProductCard({
  required ProductModel productModel,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: AppColors.primary,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  children: [
                    Image.asset(
                      AppImages.protein,
                    ),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: Container(
                        child: const Center(
                          child: Text(
                            '+2',
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontWeight: AppFonts.bold,
                              letterSpacing: 1,
                              fontSize: AppFonts.sizeXXSmall,
                            ),
                          ),
                        ),
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.antiFlashWhite,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontWeight: AppFonts.bold,
                          fontSize: AppFonts.sizeSmall,
                        ),
                        children: [
                          const TextSpan(
                            text: '№ ',
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontWeight: AppFonts.regular,
                            ),
                          ),
                          TextSpan(
                            text: productModel.id,
                            style: const TextStyle(
                              color: AppColors.lightGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontWeight: AppFonts.bold,
                          fontSize: AppFonts.sizeSmall,
                          color: AppColors.darkBlue,
                        ),
                        children: [
                          TextSpan(
                            text: 'Дата доставки ',
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontWeight: AppFonts.regular,
                            ),
                          ),
                          TextSpan(
                            text: '13/12/2021',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: IconText(
                    mainAxisAlignment: MainAxisAlignment.start,
                    icon: SvgPicture.asset(
                      AppIcons.boat,
                      color: AppColors.lightBlue,
                    ),
                    iconPadding: const EdgeInsets.only(
                      right: 6,
                    ),
                    label: 'Море',
                    textStyle: const TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.bold,
                      fontSize: AppFonts.sizeXSmall,
                    ),
                  ),
                ),
                Expanded(
                  child: IconText(
                    icon: SvgPicture.asset(
                      AppIcons.dollarCoin,
                      color: AppColors.lightBlue,
                    ),
                    iconPadding: const EdgeInsets.only(
                      right: 6,
                    ),
                    label: '8500.00\$',
                    textStyle: const TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.bold,
                      fontSize: AppFonts.sizeXSmall,
                    ),
                  ),
                ),
                Expanded(
                  child: IconText(
                    mainAxisAlignment: MainAxisAlignment.end,
                    icon: SvgPicture.asset(
                      AppIcons.kettlebell,
                      color: AppColors.lightBlue,
                    ),
                    iconPadding: const EdgeInsets.only(
                      right: 6,
                    ),
                    label: '1000.0кг',
                    textStyle: const TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.bold,
                      fontSize: AppFonts.sizeXSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Text(
                    'Готов к оплате',
                    style: TextStyle(
                      color: AppColors.lightBlue,
                      fontSize: AppFonts.sizeXSmall,
                      fontWeight: AppFonts.regular,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Expanded(
                  child: SubmitButton(
                    text: 'Оплатить',
                    onTap: () {},
                    borderRadius: BorderRadius.circular(
                      40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _filterCard({
  required DeliveryStatusModel deliveryStatusModel,
  required Function(DeliveryStatus) onTap,
}) {
  return GestureDetector(
    onTap: (() {
      onTap(deliveryStatusModel.deliveryStatus);
    }),
    child: Container(
      width: 70,
      margin: const EdgeInsets.only(
        right: 20,
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                deliveryStatusModel.svgIconUrl,
                color: AppColors.lightBlue,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            deliveryStatusModel.textStatus,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.regular,
              fontSize: AppFonts.sizeXXSmall,
            ),
          ),
        ],
      ),
    ),
  );
}
