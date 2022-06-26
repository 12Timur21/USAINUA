import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/utils/helpers/overlay_hints.dart';
import 'package:usainua/utils/helpers/warehouse_adresses_dialog.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/drop_downs/custom_drop_down.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';
import 'package:usainua/widgets/select_widgets/select_delivery.dart';
import 'package:usainua/widgets/text/icon_text_with_label.dart';
import 'package:usainua/widgets/text_fields/resizable_text_field.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class PurchaseAndDeliveryPage extends StatefulWidget {
  const PurchaseAndDeliveryPage({Key? key}) : super(key: key);

  static const routeName = '/purchase_and_delivery_page';

  @override
  State<PurchaseAndDeliveryPage> createState() =>
      _PurchaseAndDeliveryPageState();
}

class _PurchaseAndDeliveryPageState extends State<PurchaseAndDeliveryPage> {
  final _overlayController = OverlayController();
  final _formKey = GlobalKey<FormState>();

  DeliveryMethod _deliveryMethod = DeliveryMethod.air;
  final _linkController = TextEditingController();

  final _countController = TextEditingController();
  final _costController = TextEditingController();
  final _weightController = TextEditingController();
  final _additionalServicesController = TextEditingController();
  final _descriptionController = TextEditingController(
    text:
        'Reprehenderit dolor pariatur sint tempor in commodo est amet eiusmod in. Id cupidatat dolor exercitation pariatur eu aute occaecat consectetur magna consectetur. Occaecat labore non pariatur magna veniam adipisicing nostrud eu nulla voluptate. Nulla do cupidatat deserunt incididunt occaecat nulla minim cupidatat irure anim dolor ad dolor et. Exercitation aliquip proident est nulla nisi ut ex id adipisicing culpa eu ut ad. Eiusmod qui eiusmod ut non qui laborum anim. Consectetur eiusmod amet consequat consectetur adipisicing dolore quis deserunt exercitation ea elit veniam velit eu. Duis Lorem do sunt do elit sit id ad. Ipsum cillum sunt laborum proident in. Laborum elit culpa voluptate enim deserunt nisi excepteur. Dolore esse ad in sit velit voluptate. Tempor adipisicing enim incididunt do. Nisi officia sint cupidatat culpa magna deserunt est irure cillum labore. Enim eu veniam aute sit. Laborum ea culpa pariatur nisi. Voluptate officia ex amet ad incididunt excepteur. Est et elit mollit do. Id fugiat deserunt tempor enim voluptate laboris id. Deserunt fugiat in voluptate minim nisi sunt ex commodo. Ut excepteur fugiat elit sint et sint dolor in velit. Ut veniam deserunt commodo mollit deserunt laborum nulla excepteur nostrud. Cillum do non est consectetur velit. Aliquip do ad dolore occaecat pariatur proident voluptate eu voluptate elit magna aliquip eiusmod. Labore do sint nulla velit sit. Aute duis nulla aute ullamco veniam duis culpa. Id laboris in commodo do.',
  );
  final _balanceController = TextEditingController(text: '1000\$');

  @override
  void dispose() {
    _overlayController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    OverlayHints.initDotHint(
      context: context,
      overlayController: _overlayController,
    );
    context.read<NavigationBloc>().add(
          ChangeBottomNavigationBarStatus(
            showBottomNavBar: false,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {
          context.read<NavigationBloc>().add(
                ChangeBottomNavigationBarStatus(
                  showBottomNavBar: true,
                ),
              );
          Navigator.of(context).pop();
        },
        leadingIcon: SvgPicture.asset(
          AppIcons.leftArrow,
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
              Align(
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
              SelectDeliveryMethod(
                selectedDeliveryMethod: _deliveryMethod,
                onChange: (DeliveryMethod value) {
                  setState(() {
                    _deliveryMethod = value;
                  });
                },
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWithCustomLabel(
                      controller: _linkController,
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
                        onTap: () {
                          _overlayController.open();
                        },
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
                      hintText:
                          'Размер, цвет, кол-во, другие детали или Ваш вопрос',
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            showWarehouseAdressesDialog(
                              context: context,
                            );
                          },
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
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppIcons.calculator,
                            color: AppColors.lightBlue,
                          ),
                          label: const Text(
                            'Ориентировочная стоимость',
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontWeight: AppFonts.bold,
                              fontSize: AppFonts.sizeXSmall,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
