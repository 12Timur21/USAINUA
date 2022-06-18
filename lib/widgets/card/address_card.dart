import 'package:flutter/material.dart';
import 'package:usainua/pages/main_pages/account_pages/recipient_addresses_page/recipient_addresses_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    required this.deliveryDepartmentNumber,
    required this.region,
    required this.city,
    required this.deliveryType,
    required this.fullName,
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  final DeliveryType deliveryType;
  final String region;
  final String city;
  final String deliveryDepartmentNumber;
  final String fullName;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    String _deliveryType = 'Неизвестный способ доставки';

    if (deliveryType == DeliveryType.address) {
      _deliveryType = 'адресная доставка';
    }

    if (deliveryType == DeliveryType.department) {
      _deliveryType = 'до отделения';
    }
    return Column(
      children: [
        _textRow(
          key: 'Способ доставки',
          value: 'НП ($_deliveryType)',
        ),
        _textRow(
          key: 'Область',
          value: region,
        ),
        _textRow(
          key: 'Город',
          value: city,
        ),
        _textRow(
          key: 'Отделение',
          value: '№$deliveryDepartmentNumber',
        ),
        _textRow(
          key: 'ФИО',
          value: fullName,
        ),
        _textRow(
          key: 'Номер телефона',
          value: phoneNumber,
        ),
      ],
    );
  }
}

Widget _textRow({
  required String key,
  required String value,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 6,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: const TextStyle(
            color: AppColors.darkBlue,
            fontWeight: AppFonts.regular,
            fontSize: AppFonts.sizeXSmall,
            letterSpacing: 1,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.lightBlue,
            fontWeight: AppFonts.bold,
            fontSize: AppFonts.sizeXSmall,
          ),
        ),
      ],
    ),
  );
}
