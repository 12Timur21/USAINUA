import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/pages/main_pages/account_pages/recipient_addresses_page/recipient_addresses_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/widgets/animated_widgets/dehiscent_container.dart';
import 'package:usainua/widgets/card/address_card.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';

class AddressTab extends StatefulWidget {
  const AddressTab({Key? key}) : super(key: key);

  @override
  State<AddressTab> createState() => _AddressTabState();
}

class _AddressTabState extends State<AddressTab> {
  bool _hasAdress = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _hasAdress
            ? const _Addresses()
            : _NoAdress(
                onTap: () {
                  setState(() {
                    _hasAdress = true;
                  });
                },
              ),
      ],
    );
  }
}

class _NoAdress extends StatelessWidget {
  const _NoAdress({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.girlWithMarker,
        ),
        TextButton.icon(
          onPressed: onTap,
          icon: SvgPicture.asset(
            AppIcons.plus,
            color: AppColors.lightBlue,
          ),
          label: const Text(
            'Добавить адрес доставки',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.bold,
              fontSize: AppFonts.sizeXSmall,
            ),
          ),
        ),
      ],
    );
  }
}

class _Addresses extends StatefulWidget {
  const _Addresses({Key? key}) : super(key: key);

  @override
  State<_Addresses> createState() => __AddressesState();
}

class __AddressesState extends State<_Addresses> {
  String _selectedAdress = 'Дом';
  final List<String> _addressList = [
    'Дом',
    'Квартира тещи',
    'Офис',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _addressList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return DehiscentContainer(
                    isOpen: _addressList[index] == _selectedAdress,
                    title: _addressHeader(
                      value: _addressList[index],
                      groupValue: _selectedAdress,
                      onChanged: (value) {
                        setState(() {
                          _selectedAdress = value;
                        });
                      },
                      onEdit: () {},
                    ),
                    body: adressBody(),
                  );
                },
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppIcons.plus,
                color: AppColors.lightBlue,
              ),
              label: const Text(
                'Добавить еще адрес',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeXSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _addressHeader({
  required String value,
  required String groupValue,
  required Function(String value) onChanged,
  required VoidCallback onEdit,
}) {
  return Row(
    children: [
      CustomRadioOption<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: AppColors.lightBlue,
        backgroundColor: AppColors.primary,
      ),
      const SizedBox(
        width: 16,
      ),
      Text(
        value,
        style: const TextStyle(
          color: AppColors.darkBlue,
          fontWeight: AppFonts.heavy,
          fontSize: AppFonts.sizeLarge,
          letterSpacing: 0.5,
        ),
      ),
      const Spacer(),
      IconButton(
        onPressed: onEdit,
        icon: SvgPicture.asset(
          AppIcons.editBox,
        ),
      )
    ],
  );
}

Widget adressBody() {
  return const AddressCard(
    city: 'Розсошенцы ',
    deliveryDepartmentNumber: '№1',
    deliveryType: DeliveryType.address,
    fullName: 'Сергей Билан',
    phoneNumber: '0960504316',
    region: 'Полтавская',
  );
}
