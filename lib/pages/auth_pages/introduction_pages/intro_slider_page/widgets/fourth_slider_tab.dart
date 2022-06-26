import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/widgets/designs/delivery_only_list.dart';
import 'package:usainua/widgets/designs/purchare_and_delivery_list.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';

class FourthSliderTab extends StatefulWidget {
  const FourthSliderTab({Key? key}) : super(key: key);

  @override
  State<FourthSliderTab> createState() => _FourthSliderTabState();
}

class _FourthSliderTabState extends State<FourthSliderTab> {
  DispatchType _dispatchType = DispatchType.purchaseAndDelivery;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 35,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    CustomRadioOption<DispatchType>(
                      value: DispatchType.purchaseAndDelivery,
                      groupValue: _dispatchType,
                      onChanged: (DispatchType dispatchType) {
                        setState(() {
                          _dispatchType = dispatchType;
                        });
                      },
                      backgroundColor: AppColors.primary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Покупка и доставка',
                      style: _checkBoxTextStyle.copyWith(
                        color: _dispatchType == DispatchType.purchaseAndDelivery
                            ? AppColors.darkBlue
                            : AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CustomRadioOption<DispatchType>(
                      value: DispatchType.deliveryOnly,
                      groupValue: _dispatchType,
                      onChanged: (DispatchType dispatchType) {
                        setState(() {
                          _dispatchType = dispatchType;
                        });
                      },
                      backgroundColor: AppColors.primary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Только доставка',
                      style: _checkBoxTextStyle.copyWith(
                        color: _dispatchType == DispatchType.deliveryOnly
                            ? AppColors.darkBlue
                            : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            if (_dispatchType == DispatchType.deliveryOnly)
              const DeliveryOnlyList(),
            if (_dispatchType == DispatchType.purchaseAndDelivery)
              const PurchareAndDeliveryList(),
          ],
        ),
      ),
    );
  }
}

TextStyle _checkBoxTextStyle = const TextStyle(
  fontWeight: AppFonts.heavy,
  fontSize: AppFonts.sizeLarge,
  letterSpacing: 0.5,
);
