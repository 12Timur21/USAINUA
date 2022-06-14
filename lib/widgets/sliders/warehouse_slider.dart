import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/buttons/icon_text_button_with_label.dart';

class WarehouseSlider extends StatelessWidget {
  const WarehouseSlider({
    this.scrollDirection = Axis.horizontal,
    Key? key,
  }) : super(key: key);

  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    //3 пока макс
    return ListView.builder(
      itemCount: 3,
      scrollDirection: scrollDirection,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            right: scrollDirection == Axis.horizontal && index == 3 ? 10 : 24,
            bottom: scrollDirection == Axis.vertical && index == 3 ? 10 : 0,
          ),
          width: 300,
          child: _warhouseCard(
            warhouseName: 'Основной склад',
            fullName: 'Ваше Фио',
            street: '645 W 1st Ave. ste DN0132613123123123123',
            city: 'Roselle',
            state: 'New Jersey',
            index: 07203,
            phoneNumber: 19082412190,
          ),
        );
      },
    );
  }
}

Widget _warhouseCard({
  required String warhouseName,
  required String fullName,
  required String street,
  required String city,
  required String state,
  required int index,
  required int phoneNumber,
}) {
  void _copyToBuffer(String value) {}

  const TextStyle _labelStyle = TextStyle(
    color: AppColors.darkBlue,
    letterSpacing: 1,
    fontSize: AppFonts.sizeXSmall,
    fontWeight: AppFonts.regular,
  );

  const TextStyle _textStyle = TextStyle(
    color: AppColors.darkBlue,
    fontWeight: AppFonts.bold,
    fontSize: AppFonts.sizeSmall,
    letterSpacing: 0.5,
  );

  return Container(
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 30,
      horizontal: 20,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          warhouseName,
          style: const TextStyle(
            color: AppColors.darkBlue,
            fontWeight: AppFonts.heavy,
            letterSpacing: 0.5,
            fontSize: AppFonts.sizeXXLarge,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ФИО',
              style: _labelStyle,
            ),
            Text(
              fullName,
              style: _textStyle,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: IconTextButtonWithLabel(
            isReverse: true,
            onTap: (() {
              _copyToBuffer(street);
            }),
            label: 'Улица',
            text: street,
            textOverflow: TextOverflow.ellipsis,
            icon: SvgPicture.asset(
              AppIcons.copy_3,
            ),
            labelStyle: _labelStyle,
            textStyle: _textStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: IconTextButtonWithLabel(
            isReverse: true,
            onTap: (() {
              _copyToBuffer(street);
            }),
            label: 'Город',
            text: city,
            textOverflow: TextOverflow.ellipsis,
            icon: SvgPicture.asset(
              AppIcons.copy_3,
            ),
            labelStyle: _labelStyle,
            textStyle: _textStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: IconTextButtonWithLabel(
            isReverse: true,
            onTap: (() {
              _copyToBuffer(street);
            }),
            label: 'Штат',
            text: state,
            textOverflow: TextOverflow.ellipsis,
            icon: SvgPicture.asset(
              AppIcons.copy_3,
            ),
            labelStyle: _labelStyle,
            textStyle: _textStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: IconTextButtonWithLabel(
            isReverse: true,
            onTap: (() {
              _copyToBuffer(street);
            }),
            label: 'Индекс',
            text: index.toString(),
            textOverflow: TextOverflow.ellipsis,
            icon: SvgPicture.asset(
              AppIcons.copy_3,
            ),
            labelStyle: _labelStyle,
            textStyle: _textStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: IconTextButtonWithLabel(
            isReverse: true,
            onTap: (() {
              _copyToBuffer(street);
            }),
            label: 'Телефон',
            text: PhoneInputFormatter().mask(
              phoneNumber.toString(),
            ),
            textOverflow: TextOverflow.ellipsis,
            icon: SvgPicture.asset(
              AppIcons.copy_3,
            ),
            labelStyle: _labelStyle,
            textStyle: _textStyle,
          ),
        ),
      ],
    ),
  );
}
