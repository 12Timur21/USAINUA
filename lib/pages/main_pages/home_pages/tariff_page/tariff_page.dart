import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/pages/fourth_slider_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';
import 'package:usainua/widgets/text/text_in_box.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class TariffPage extends StatefulWidget {
  const TariffPage({Key? key}) : super(key: key);

  static const routeName = '/tariff_page';

  @override
  State<TariffPage> createState() => _TariffPageState();
}

class _TariffPageState extends State<TariffPage> {
  DispatchType _dispatchType = DispatchType.purchaseAndDelivery;
  final _formKey = GlobalKey<FormState>();
  final _packageWeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {},
        onAction: () {},
        text: 'Тарифы',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
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
                        activeColor: AppColors.lightGreen,
                        backgroundColor: AppColors.primary,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Покупка и доставка',
                        style: _checkBoxTextStyle.copyWith(
                          color:
                              _dispatchType == DispatchType.purchaseAndDelivery
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
                        activeColor: AppColors.lightGreen,
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
            ),
            const SizedBox(
              height: 25,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldWithCustomLabel(
                    controller: _packageWeightController,
                    textInputAction: TextInputAction.next,
                    hintText: 'Примерный вес посылки*',
                    sufixIcon: SvgPicture.asset(
                      AppIcons.kilogram,
                      fit: BoxFit.scaleDown,
                    ),
                    keyboardType: TextInputType.number,
                    validator: MultiValidator(
                      [
                        MinLengthValidator(
                          1,
                          errorText: 'Укажите вес посылки',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWithCustomLabel(
                    controller: _packageWeightController,
                    textInputAction: TextInputAction.next,
                    hintText: 'Общая стоимость*',
                    sufixIcon: SvgPicture.asset(
                      AppIcons.dollar,
                      fit: BoxFit.scaleDown,
                    ),
                    keyboardType: TextInputType.number,
                    validator: MultiValidator(
                      [
                        MinLengthValidator(
                          1,
                          errorText: 'Укажите стоимость посылки',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _rowTile(
                    key: 'Услуги доставки:',
                    value: 59.50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _rowTile(
                    key: 'Страховка:',
                    value: 2.85,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _rowTile(
                    key: 'Прием и оформление::',
                    value: 0.99,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _rowTile(
                    key: 'Комиссия услуги::',
                    value: 7.50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Ориентировочная стоимость товара с доставкой: ',
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.regular,
                      fontSize: AppFonts.sizeXSmall,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const TextInBox(
                    backgroundColor: AppColors.primary,
                    text: '220.84\$',
                    textStyle: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.heavy,
                      fontSize: AppFonts.sizeXXLarge,
                      letterSpacing: 0.5,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
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

Widget _rowTile({
  required String key,
  required double value,
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
          '$value\$',
          style: const TextStyle(
            color: AppColors.darkBlue,
            fontWeight: AppFonts.bold,
            fontSize: AppFonts.sizeSmall,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );
}
