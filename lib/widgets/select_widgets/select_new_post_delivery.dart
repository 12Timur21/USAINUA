import 'package:flutter/material.dart';
import 'package:usainua/pages/main_pages/account_pages/recipient_addresses_page/recipient_addresses_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';

class SelectNewPostDeliveryMethod extends StatefulWidget {
  const SelectNewPostDeliveryMethod({
    required this.selectedDeliveryMethod,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final DeliveryType selectedDeliveryMethod;
  final void Function(DeliveryType value) onChange;

  @override
  State<SelectNewPostDeliveryMethod> createState() =>
      _SelectNewPostDeliveryMethodState();
}

class _SelectNewPostDeliveryMethodState
    extends State<SelectNewPostDeliveryMethod> {
  late DeliveryType _selectedDeliveryMethod;

  @override
  void initState() {
    _selectedDeliveryMethod = widget.selectedDeliveryMethod;
    super.initState();
  }

  void _onChange(DeliveryType value) {
    setState(() {
      _selectedDeliveryMethod = value;
    });
    widget.onChange(value);
  }

  final TextStyle _textStyle = const TextStyle(
    color: AppColors.darkBlue,
    letterSpacing: 0.5,
    fontSize: AppFonts.sizeSmall,
    fontWeight: AppFonts.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomRadioOption<DeliveryType>(
              value: DeliveryType.department,
              groupValue: _selectedDeliveryMethod,
              onChanged: _onChange,
              activeColor: AppColors.lightBlue,
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Новая Почта (до отделения)',
              style: _textStyle,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            CustomRadioOption<DeliveryType>(
              value: DeliveryType.address,
              groupValue: _selectedDeliveryMethod,
              onChanged: _onChange,
              activeColor: AppColors.lightBlue,
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Новая Почта (адресная доставка)',
              style: _textStyle,
            )
          ],
        ),
      ],
    );
  }
}
