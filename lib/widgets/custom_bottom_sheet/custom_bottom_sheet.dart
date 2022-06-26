import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/pages/main_pages/order_pages/only_delivery_page/only_delivery_page.dart';
import 'package:usainua/pages/main_pages/order_pages/purchase_and_delivery_page/purchase_and_delivery_page.dart';

import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';

class CustomButtomSheet extends StatelessWidget {
  const CustomButtomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(
        10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          deliveryCard(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                PurchaseAndDeliveryPage.routeName,
              );
            },
            cardColor: AppColors.lightGreen,
            icon: SvgPicture.asset(
              AppIcons.cart,
              color: AppColors.darkGreen,
              fit: BoxFit.scaleDown,
            ),
            text: 'Заказать покупку и доставку',
          ),
          const SizedBox(
            height: 10,
          ),
          deliveryCard(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                OnlyDeliveryPage.routeName,
              );
            },
            cardColor: AppColors.lightBlue,
            icon: SvgPicture.asset(
              AppIcons.cube,
              color: Colors.white,
            ),
            text: 'Заказать только доставку',
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Widget deliveryCard({
  required Color cardColor,
  required SvgPicture icon,
  required String text,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 56,
      color: AppColors.primary,
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
            child: Center(
              child: icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.bold,
                fontSize: AppFonts.sizeSmall,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
