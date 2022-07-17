import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';
import 'package:usainua/widgets/text/icon_text_with_label.dart';

class SelectDeliveryMethod extends StatelessWidget {
  const SelectDeliveryMethod({
    required this.selectedDeliveryMethod,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final DeliveryMethod selectedDeliveryMethod;
  final void Function(DeliveryMethod value) onChange;

  @override
  Widget build(BuildContext context) {
    const TextStyle _iconTextWithLabelStyle = TextStyle(
      color: AppColors.darkBlue,
      letterSpacing: 0.5,
      fontSize: AppFonts.sizeSmall,
      fontWeight: AppFonts.bold,
    );

    const TextStyle _iconTextWithText = TextStyle(
      color: AppColors.darkBlue,
      fontWeight: AppFonts.regular,
      fontSize: AppFonts.sizeXSmall,
      letterSpacing: 1,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomRadioOption<DeliveryMethod>(
              value: DeliveryMethod.air,
              groupValue: selectedDeliveryMethod,
              onChanged: onChange,
              activeColor: AppColors.lightBlue,
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(
              width: 20,
            ),
            IconTextWithLabel(
              label: 'Авиадоставка',
              text: '4-9 рабочих дней',
              icon: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: SvgPicture.asset(
                  AppIcons.plane,
                ),
              ),
              labelStyle: _iconTextWithLabelStyle,
              textStyle: _iconTextWithText,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            CustomRadioOption<DeliveryMethod>(
              value: DeliveryMethod.sea,
              groupValue: selectedDeliveryMethod,
              onChanged: onChange,
              activeColor: AppColors.lightBlue,
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(
              width: 20,
            ),
            IconTextWithLabel(
              label: 'Бысторое море',
              text: '28-35 рабочих дней',
              icon: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: SvgPicture.asset(
                  AppIcons.boat,
                ),
              ),
              labelStyle: _iconTextWithLabelStyle,
              textStyle: _iconTextWithText,
            ),
          ],
        ),
      ],
    );
  }
}
