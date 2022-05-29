import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/buttons/icon_text_button_with_label.dart';

class WarhouseAdressesPage extends StatelessWidget {
  const WarhouseAdressesPage({Key? key}) : super(key: key);

  static const routeName = '/warhouse_adresses_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {},
        onAction: () {},
        text: 'Адреса складов',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          left: 24,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 470,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      right: 10,
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
              ),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '* - технику компании Apple можно отправлять только на дополнительный склад',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.regular,
                    letterSpacing: 1,
                    fontSize: AppFonts.sizeXSmall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
