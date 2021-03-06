import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/utils/helpers/warehouse_adresses_dialog.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/check_boxes/custom_checkbox.dart';
import 'package:usainua/widgets/select_widgets/select_delivery_method.dart';
import 'package:usainua/widgets/text_fields/resizable_text_field.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class OnlyDeliveryPage extends StatefulWidget {
  const OnlyDeliveryPage({Key? key}) : super(key: key);

  static const routeName = '/only_delivery_page';

  @override
  State<OnlyDeliveryPage> createState() => _OnlyDeliveryPageState();
}

class _OnlyDeliveryPageState extends State<OnlyDeliveryPage> {
  String? _track;
  final _trackNumberController = TextEditingController();
  bool _noTrackingNumber = false;
  DeliveryMethod _deliveryMethod = DeliveryMethod.air;
  final _descriptionController = TextEditingController();
  final _weightController = TextEditingController();
  final _costController = TextEditingController();
  final _balanceController = TextEditingController(text: '13.15\$');
  final _additionalServicesController = TextEditingController();

  @override
  void initState() {
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
        actionIcon: SvgPicture.asset(
          AppIcons.video,
        ),
        text: '???????????? ????????????????',
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
                      color: AppColors.darkBlue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  showWarehouseAdressesDialog(
                    context: context,
                  );
                },
                icon: SvgPicture.asset(
                  AppIcons.adressHouse,
                  color: AppColors.lightBlue,
                ),
                label: const Text(
                  '?????????? ????????????',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.bold,
                    fontSize: AppFonts.sizeXSmall,
                  ),
                ),
              ),
              _downloadTrack(
                track: _track,
                onTap: () {
                  setState(() {
                    _track = 'htyfdsev1234';
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldWithCustomLabel(
                controller: _trackNumberController,
                textInputAction: TextInputAction.next,
                maxLength: 35,
                keyboardType: TextInputType.text,
                validator: MultiValidator(
                  [
                    LengthRangeValidator(
                      min: 1,
                      max: 35,
                      errorText: '?????????????? ????????- ?????????? ??????????????',
                    )
                  ],
                ),
                hintText: '?????????????? ????????- ?????????? ??????????????*',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCheckbox(
                    isActive: _noTrackingNumber,
                    activeColor: AppColors.lightBlue,
                    backgroundColor: AppColors.primary,
                    onChanged: (value) {
                      _noTrackingNumber = value;
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Expanded(
                    child: Text(
                      '?????? ????????-????????????.',
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: AppFonts.regular,
                        fontSize: AppFonts.sizeXSmall,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppIcons.plus,
                  color: AppColors.lightBlue,
                ),
                label: const Text(
                  '???????????????? ?????? ???????? ????????-??????????',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.bold,
                    fontSize: AppFonts.sizeXSmall,
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              SelectDeliveryMethod(
                selectedDeliveryMethod: _deliveryMethod,
                onChange: (DeliveryMethod value) {
                  setState(() {
                    _deliveryMethod = value;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ResiazableTextField(
                height: 130,
                minHeight: 130,
                controller: _descriptionController,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                hintText: '??????????????????????, ??????????',
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWithCustomLabel(
                controller: _weightController,
                textInputAction: TextInputAction.next,
                maxLength: 10,
                keyboardType: TextInputType.text,
                validator: MultiValidator(
                  [
                    LengthRangeValidator(
                      min: 1,
                      max: 35,
                      errorText: '?????????????????? ?????? ?????????????? (????)',
                    )
                  ],
                ),
                hintText: '?????????????????? ?????? ?????????????? (????)*',
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
                controller: _costController,
                textInputAction: TextInputAction.next,
                maxLength: 35,
                keyboardType: TextInputType.text,
                validator: MultiValidator(
                  [
                    LengthRangeValidator(
                      min: 1,
                      max: 35,
                      errorText: '???????? ?????????????? (\$)',
                    )
                  ],
                ),
                hintText: '???????? ?????????????? (\$)*',
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
              // CustomDropDown(
              //   textController: _additionalServicesController,
              //   errorText: '???????????????????????????? ????????????*',
              //   hintText: '???????????????????????????? ????????????*',
              // ),
              const SizedBox(
                height: 30,
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
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '???????????????? ?????? ???????? ??????????????',
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontWeight: AppFonts.bold,
                            fontSize: AppFonts.sizeXSmall,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppIcons.question,
                          ),
                        )
                      ],
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
                      '?????????????????????????????? ??????????????????',
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: AppFonts.bold,
                        fontSize: AppFonts.sizeXSmall,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppIcons.leftArrowInBox,
                      color: AppColors.lightBlue,
                    ),
                    label: const Text(
                      '?????????????????? ?? ?????????????? ??????????',
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: AppFonts.bold,
                        fontSize: AppFonts.sizeXSmall,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    '?????????????????? ?????????? ?? ????????????????: ',
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.regular,
                      fontSize: AppFonts.sizeXSmall,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                    height: 25,
                  ),
                  SubmitButton(
                    text: '??????????',
                    onTap: () {},
                    isActive: false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _downloadTrack({
  required VoidCallback onTap,
  String? track,
}) {
  bool hasTrack = track != null;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 9),
            blurRadius: 14,
            color: AppColors.darkBlue.withOpacity(
              0.13,
            ),
          )
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: hasTrack ? 10 : 40,
                ),
                child: SvgPicture.asset(
                  hasTrack ? AppIcons.check : AppIcons.receipt,
                  color: hasTrack ? AppColors.lightGreen : AppColors.darkBlue,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: hasTrack ? 10 : 20,
                ),
                child: Container(
                  height: hasTrack ? 24 : 60,
                  width: 2,
                  color: AppColors.darkBlue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  hasTrack ? track : '?????????????????? ???????????? ??????????????',
                  style: const TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.regular,
                    fontSize: AppFonts.sizeSmall,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          if (!hasTrack)
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppIcons.question,
                  color: AppColors.darkBlue,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
