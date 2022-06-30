import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/pages/main_pages/order_pages/purchase_and_delivery_page/bloc/product_filling_form_cubit/product_filling_form_cubit.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/utils/helpers/overlay_hints.dart';

import 'package:usainua/widgets/drop_downs/drop_down_with_checkbox.dart';
import 'package:usainua/widgets/text_fields/resizable_text_field.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class ProductFillingForm extends StatelessWidget {
  ProductFillingForm({
    required this.overlayController,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  final OverlayController overlayController;
  final VoidCallback onDelete;

  final linkController = TextEditingController();
  final countController = TextEditingController();
  final costController = TextEditingController();
  final weightController = TextEditingController();
  final additionalServicesController = TextEditingController();
  final descriptionController = TextEditingController(
    text:
        'Reprehenderit dolor pariatur sint tempor in commodo est amet eiusmod in. Id cupidatat dolor exercitation pariatur eu aute occaecat consectetur magna consectetur. Occaecat labore non pariatur magna veniam adipisicing nostrud eu nulla voluptate. Nulla do cupidatat deserunt incididunt occaecat nulla minim cupidatat irure anim dolor ad dolor et. Exercitation aliquip proident est nulla nisi ut ex id adipisicing culpa eu ut ad. Eiusmod qui eiusmod ut non qui laborum anim. Consectetur eiusmod amet consequat consectetur adipisicing dolore quis deserunt exercitation ea elit veniam velit eu. Duis Lorem do sunt do elit sit id ad. Ipsum cillum sunt laborum proident in. Laborum elit culpa voluptate enim deserunt nisi excepteur. Dolore esse ad in sit velit voluptate. Tempor adipisicing enim incididunt do. Nisi officia sint cupidatat culpa magna deserunt est irure cillum labore. Enim eu veniam aute sit. Laborum ea culpa pariatur nisi. Voluptate officia ex amet ad incididunt excepteur. Est et elit mollit do. Id fugiat deserunt tempor enim voluptate laboris id. Deserunt fugiat in voluptate minim nisi sunt ex commodo. Ut excepteur fugiat elit sint et sint dolor in velit. Ut veniam deserunt commodo mollit deserunt laborum nulla excepteur nostrud. Cillum do non est consectetur velit. Aliquip do ad dolore occaecat pariatur proident voluptate eu voluptate elit magna aliquip eiusmod. Labore do sint nulla velit sit. Aute duis nulla aute ullamco veniam duis culpa. Id laboris in commodo do.',
  );

  void rebuildf() {}

  Future<bool?> _refineDeletion(BuildContext context) async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Вы хотите удалить форму?',
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    true,
                  );
                },
                child: const Text(
                  'Удалить форму',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: AppFonts.regular,
                    fontSize: AppFonts.sizeXSmall,
                    letterSpacing: 1,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    false,
                  );
                },
                child: const Text(
                  'Отменить',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: AppFonts.regular,
                    fontSize: AppFonts.sizeXSmall,
                    letterSpacing: 1,
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final dividerIndent = MediaQuery.of(context).size.width * 0.1;

    return BlocBuilder<ProductFillingFormCubit, ProductFillingFormState>(
      builder: (context, state) {
        bool isOnlyOneFormExist = state.itemCount == 1;

        return Dismissible(
          background: Container(
            color: Colors.redAccent,
          ),
          direction: isOnlyOneFormExist
              ? DismissDirection.none
              : DismissDirection.endToStart,
          confirmDismiss: (_) async {
            final bool isDismiss = await _refineDeletion(context) ?? false;
            if (isDismiss) () => onDelete();
            return isDismiss;
          },
          key: UniqueKey(),
          onDismissed: (_) => onDelete(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LinkTextField(
                controller: linkController,
                onSuffixTap: () {
                  overlayController.open();
                },
              ),
              if (state.isExtended) ...[
                const SizedBox(height: 10),
                _CountTextField(
                  controller: countController,
                ),
                const SizedBox(height: 10),
                _CostTextField(
                  controller: costController,
                ),
                const SizedBox(height: 10),
                _WeightTextField(
                  controller: weightController,
                ),
                const SizedBox(height: 10),
                DropDownWithCheckbox(
                  textController: additionalServicesController,
                  errorText: 'Дополнительные услуги*',
                  hintText: 'Дополнительные услуги*',
                  items: [
                    AdditionalServices.additionalPackaging.displayTitle,
                    AdditionalServices.inclusionCheck.displayTitle,
                    AdditionalServices.productPhoto.displayTitle,
                  ],
                ),
              ],
              const SizedBox(height: 10),
              _DescriptionTextField(controller: descriptionController),
              if (!isOnlyOneFormExist)
                Divider(
                  color: AppColors.boxShadow,
                  thickness: 2,
                  indent: dividerIndent,
                  endIndent: dividerIndent,
                  height: 20,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _LinkTextField extends StatelessWidget {
  const _LinkTextField({
    required this.controller,
    required this.onSuffixTap,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback onSuffixTap;

  @override
  Widget build(BuildContext context) {
    return TextFieldWithCustomLabel(
      controller: controller,
      textInputAction: TextInputAction.send,
      maxLength: 35,
      keyboardType: TextInputType.name,
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
        onTap: onSuffixTap,
        child: SvgPicture.asset(
          AppIcons.question,
        ),
      ),
    );
  }
}

class _CountTextField extends StatelessWidget {
  const _CountTextField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldWithCustomLabel(
      controller: controller,
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
    );
  }
}

class _CostTextField extends StatelessWidget {
  const _CostTextField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldWithCustomLabel(
      controller: controller,
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
    );
  }
}

class _WeightTextField extends StatelessWidget {
  const _WeightTextField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldWithCustomLabel(
      controller: controller,
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
    );
  }
}

class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    {
      return ResiazableTextField(
        height: 130,
        minHeight: 130,
        controller: controller,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        hintText: 'Размер, цвет, кол-во, другие детали или Ваш вопрос',
      );
    }
  }
}
