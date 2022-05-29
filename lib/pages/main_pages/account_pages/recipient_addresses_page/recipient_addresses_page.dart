import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';

enum DeliveryType {
  department,
  address,
}

class RecipientAddressesPage extends StatefulWidget {
  const RecipientAddressesPage({Key? key}) : super(key: key);

  static const routeName = '/recipient_addresses_page';

  @override
  State<RecipientAddressesPage> createState() => _RecipientAddressesPageState();
}

class _RecipientAddressesPageState extends State<RecipientAddressesPage> {
  final List<String> _values = [
    'Дом',
    'Офис',
    'Работа',
  ];
  late String _selecetedValue;

  @override
  void initState() {
    _selecetedValue = _values[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {},
        onAction: () {},
        text: 'Адреса получателей',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _addressCard(
                deliveryType: DeliveryType.address,
                region: 'регион',
                city: 'qeqwewq',
                deliveryDepartmentNumber: '12321',
                fullName: 'full name',
                phoneNumber: '38097',
                value: _values[0],
                groupValue: _selecetedValue,
                onChanged: (String value) {
                  print(value);
                  setState(() {
                    _selecetedValue = value;
                  });
                },
              ),
              _addressCard(
                deliveryType: DeliveryType.address,
                region: 'zxczxczxc',
                city: 'vcvcxb',
                deliveryDepartmentNumber: '5555555',
                fullName: 'full ff',
                phoneNumber: '111',
                value: _values[1],
                groupValue: _selecetedValue,
                onChanged: (String value) {
                  print(value);
                  setState(() {
                    _selecetedValue = value;
                  });
                },
              ),
              _addressCard(
                deliveryType: DeliveryType.address,
                region: 'zxczxczxc',
                city: 'vcvcxb',
                deliveryDepartmentNumber: '5555555',
                fullName: 'full ff',
                phoneNumber: '111',
                value: _values[2],
                groupValue: _selecetedValue,
                onChanged: (String value) {
                  print(value);
                  setState(() {
                    _selecetedValue = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              IconTextButton(
                onTap: () {},
                text: 'Добавить еще адрес',
                textStyle: const TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeXSmall,
                ),
                icon: SvgPicture.asset(
                  AppIcons.plus,
                  color: AppColors.lightBlue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _addressCard<T>({
  required DeliveryType deliveryType,
  required String region,
  required String city,
  required String deliveryDepartmentNumber,
  required String fullName,
  required String phoneNumber,
  required String value,
  required String groupValue,
  required ValueChanged<String> onChanged,
}) {
  String _deliveryType = 'Неизвестный способ доставки';

  if (deliveryType == DeliveryType.address) {
    _deliveryType = 'адресная доставка';
  }

  if (deliveryType == DeliveryType.department) {
    _deliveryType = 'до отделения';
  }
  return Container(
    margin: const EdgeInsets.only(
      bottom: 10,
    ),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomRadioOption<String>(
                  value: value,
                  groupValue: groupValue,
                  onChanged: onChanged,
                  backgroundColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.heavy,
                      fontSize: AppFonts.sizeLarge,
                    ),
                  ),
                )
              ],
            ),
            IconButton(
              icon: SvgPicture.asset(
                AppIcons.editBox,
              ),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _rowTile(
          key: 'Способ доставки',
          value: 'НП ($_deliveryType)',
        ),
        _rowTile(
          key: 'Область',
          value: region,
        ),
        _rowTile(
          key: 'Город',
          value: city,
        ),
        _rowTile(
          key: 'Отделение',
          value: '№$deliveryDepartmentNumber',
        ),
        _rowTile(
          key: 'ФИО',
          value: fullName,
        ),
        _rowTile(
          key: 'Номер телефона',
          value: phoneNumber,
        ),
      ],
    ),
  );
}

Widget _rowTile({
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
