import 'package:flutter/material.dart';

import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

import 'package:usainua/widgets/buttons/circle_checkbox.dart';
import 'package:usainua/widgets/text/delivery_only_list.dart';

import 'package:usainua/widgets/text/purchare_and_delivery_list.dart';

class FourthSliderPage extends StatefulWidget {
  const FourthSliderPage({Key? key}) : super(key: key);

  @override
  State<FourthSliderPage> createState() => _FourthSliderPageState();
}

class _FourthSliderPageState extends State<FourthSliderPage> {
  bool isOnlyDelivery = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 35,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleCheckbox(
                isActive: !isOnlyDelivery,
                onTap: () {
                  setState(() {
                    isOnlyDelivery = false;
                  });
                },
                circleColor: AppColors.lightGreen,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Покупка и доставка',
                    style: _checkBoxTextStyle.copyWith(
                      color: !isOnlyDelivery
                          ? AppColors.darkBlue
                          : AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CircleCheckbox(
                isActive: isOnlyDelivery,
                onTap: () {
                  setState(() {
                    isOnlyDelivery = true;
                  });
                },
                circleColor: AppColors.lightBlue,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Только доставка',
                    style: _checkBoxTextStyle.copyWith(
                      color: isOnlyDelivery
                          ? AppColors.darkBlue
                          : AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 75,
          ),
          isOnlyDelivery
              ? const DeliveryOnlyList()
              : const PurchareAndDeliveryList(),
        ],
      ),
    );
  }
}

TextStyle _checkBoxTextStyle = const TextStyle(
  fontWeight: AppFonts.heavy,
  fontSize: AppFonts.sizeLarge,
  letterSpacing: 0.5,
);
