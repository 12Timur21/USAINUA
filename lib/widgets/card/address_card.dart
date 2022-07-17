import 'package:flutter/material.dart';
import 'package:usainua/models/recipient_address_model.dart';
import 'package:usainua/pages/main_pages/account_pages/recipient_addresses_page/recipient_addresses_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({
    required this.recipentAddressModel,
    Key? key,
  }) : super(key: key);

  final RecipentAddressModel recipentAddressModel;

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  late final String deliveryType;

  @override
  void initState() {
    if (widget.recipentAddressModel.deliveryType == DeliveryType.address) {
      deliveryType = 'адресная доставка';
    } else {
      deliveryType = 'до отделения';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TextRow(
          value: 'Способ доставки',
          description: 'НП ($deliveryType)',
        ),
        _TextRow(
          value: 'Область',
          description: widget.recipentAddressModel.regionModel.regionName,
        ),
        _TextRow(
          value: 'Город',
          description: widget.recipentAddressModel.cityModel.cityName,
        ),
        _TextRow(
          value: 'Отделение',
          description:
              widget.recipentAddressModel.warehouseModel?.warehouseName ?? '',
        ),
        _TextRow(
          value: 'Имя',
          description: widget.recipentAddressModel.name,
        ),
        _TextRow(
          value: 'Фамилия',
          description: widget.recipentAddressModel.surname,
        ),
        _TextRow(
          value: 'Номер телефона',
          description: widget.recipentAddressModel.phoneNumber,
        ),
      ],
    );
  }
}

class _TextRow extends StatelessWidget {
  const _TextRow({
    required this.value,
    required this.description,
    Key? key,
  }) : super(key: key);

  final String value;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.regular,
              fontSize: AppFonts.sizeXSmall,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(
            width: 35,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              description,
              style: const TextStyle(
                overflow: TextOverflow.clip,
                color: AppColors.lightBlue,
                fontWeight: AppFonts.bold,
                fontSize: AppFonts.sizeXSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
