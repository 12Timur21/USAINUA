import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/drop_downs/custom_drop_down.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';
import 'package:usainua/widgets/text/icon_text_with_label.dart';
import 'package:usainua/widgets/text_fields/resizable_text_field.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class ApproximateCostPurchaseAndDeliveryPage extends StatefulWidget {
  const ApproximateCostPurchaseAndDeliveryPage({
    this.deliveryMethod = DeliveryMethod.air,
    Key? key,
  }) : super(key: key);

  final DeliveryMethod deliveryMethod;

  static const routeName = '/approximate_cost_purchase_and_delivery_page';

  @override
  State<ApproximateCostPurchaseAndDeliveryPage> createState() =>
      _ApproximateCostPurchaseAndDeliveryPageState();
}

class _ApproximateCostPurchaseAndDeliveryPageState
    extends State<ApproximateCostPurchaseAndDeliveryPage> {
  late DeliveryMethod _deliveryMethod;
  final _linkController = TextEditingController();
  final _countController = TextEditingController();
  final _costController = TextEditingController();
  final _weightController = TextEditingController();
  final _additionalServicesController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _balanceController = TextEditingController(text: '1000\$');

  @override
  void initState() {
    _deliveryMethod = widget.deliveryMethod;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        onAction: () {},
        leadingIcon: SvgPicture.asset(
          AppIcons.leftArrow,
        ),
        actionIcon: SvgPicture.asset(
          AppIcons.video,
        ),
        text: 'Покупка и доставка',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              _selectDelivery(
                selectedDeliveryMethod: _deliveryMethod,
                onChange: (value) {
                  setState(() {
                    _deliveryMethod = value;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldWithCustomLabel(
                controller: _linkController,
                textInputAction: TextInputAction.next,
                maxLength: 35,
                keyboardType: TextInputType.text,
                validator: MultiValidator(
                  [
                    LengthRangeValidator(
                      min: 1,
                      max: 35,
                      errorText: 'Укажите ссылку на свой товар',
                    )
                  ],
                ),
                hintText: 'Укажите ссылку на товар*',
                sufixIcon: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppIcons.question,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWithCustomLabel(
                controller: _countController,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                keyboardType: TextInputType.number,
                validator: MultiValidator(
                  [
                    LengthRangeValidator(
                      min: 1,
                      max: 10,
                      errorText: 'Количество (шт.)',
                    )
                  ],
                ),
                hintText: 'Количество (шт.)*',
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWithCustomLabel(
                controller: _costController,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                keyboardType: TextInputType.number,
                validator: MultiValidator(
                  [
                    LengthRangeValidator(
                      min: 1,
                      max: 10,
                      errorText: 'Цена (\$)',
                    )
                  ],
                ),
                hintText: 'Цена (\$)*',
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWithCustomLabel(
                controller: _weightController,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                keyboardType: TextInputType.number,
                validator: MultiValidator(
                  [
                    LengthRangeValidator(
                      min: 1,
                      max: 10,
                      errorText: 'Примерный вес (кг)',
                    )
                  ],
                ),
                hintText: 'Примерный вес (кг)*',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDropDown(
                textController: _additionalServicesController,
                errorText: 'Дополнительные услуги*',
                hintText: 'Дополнительные услуги*',
              ),
              const SizedBox(
                height: 10,
              ),
              ResiazableTextField(
                height: 130,
                minHeight: 130,
                controller: _descriptionController,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                hintText: 'Размер, цвет, кол-во, другие детали или Ваш вопрос',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppIcons.plus,
                      color: AppColors.lightBlue,
                    ),
                    label: const Text(
                      'Добавить еще один товар в просчет',
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: AppFonts.bold,
                        fontSize: AppFonts.sizeXSmall,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: SvgPicture.asset(
                      AppIcons.leftArrowInBox,
                      color: AppColors.lightBlue,
                    ),
                    label: const Text(
                      'Вернуться к быстрой форме',
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: AppFonts.bold,
                        fontSize: AppFonts.sizeXSmall,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
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
                height: 36,
              ),
              TextFormField(
                controller: _balanceController,
                style: const TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: AppFonts.sizeXXLarge,
                  fontWeight: AppFonts.heavy,
                  letterSpacing: 0.5,
                ),
                readOnly: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(
                    top: 12,
                    bottom: 13,
                    left: 21,
                  ),
                  filled: true,
                  fillColor: AppColors.primary,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              SubmitButton(
                text: 'ДАЛЕЕ',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _selectDelivery({
  required DeliveryMethod selectedDeliveryMethod,
  required Function(DeliveryMethod value) onChange,
}) {
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
