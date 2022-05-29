import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/models/user_model.dart';
import 'package:usainua/pages/auth_pages/sign_in_page/sign_in_page.dart';
import 'package:usainua/repositories/auth_repository.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({Key? key}) : super(key: key);

  static const routeName = '/personal_data';

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  GenderType _genderType = GenderType.man;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    UserModel userModel = context.read<AuthorizationBloc>().state.userModel!;

    _nameController.text = userModel.name.toString();
    if (userModel.birthday != null) {
      _birthdayController.text = DateFormat('dd.MM.yy').format(
        userModel.birthday!,
      );
    }
    _phoneNumberController.text = userModel.phoneNumber.toString();
    _emailController.text = userModel.email.toString();

    super.initState();
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.darkBlue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: AppColors.darkBlue, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.darkBlue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _birthdayController.text = DateFormat('dd.MM.yy').format(picked);
      });
    }
    FocusScope.of(context).unfocus();
  }

  Future<void> _signOut() async {
    await AuthRepository.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
      SignInPage.routeName,
      (Route<dynamic> route) => false,
    );
  }

  void _pop() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onLeading: () {},
        onAction: () {},
        text: 'Личные данные',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFieldWithCustomLabel(
                controller: _nameController,
                textInputAction: TextInputAction.send,
                maxLength: 35,
                keyboardType: TextInputType.name,
                validator: MultiValidator([
                  LengthRangeValidator(
                    min: 1,
                    max: 35,
                    errorText: 'Укажите ваше имя',
                  )
                ]),
                hintText: 'Ваше имя*',
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWithCustomLabel(
                controller: _birthdayController,
                textInputAction: TextInputAction.send,
                maxLength: 35,
                readOnly: true,
                keyboardType: TextInputType.none,
                onTap: () {
                  _selectDate();
                },
                validator: MultiValidator([
                  LengthRangeValidator(
                    min: 1,
                    max: 35,
                    errorText: 'Укажие дату рождения*',
                  )
                ]),
                hintText: 'Дата рождения*',
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Пол',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: AppFonts.sizeLarge,
                  letterSpacing: 0.5,
                  fontWeight: AppFonts.heavy,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _genderSwitch(
                genderType: _genderType,
                onChange: (GenderType genderType) {
                  setState(() {
                    _genderType = genderType;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Контактная информация',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: AppFonts.sizeLarge,
                  letterSpacing: 0.5,
                  fontWeight: AppFonts.heavy,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWithCustomLabel(
                controller: _phoneNumberController,
                textInputAction: TextInputAction.next,
                maxLength: 35,
                keyboardType: TextInputType.phone,
                validator: MultiValidator([
                  LengthRangeValidator(
                    min: 1,
                    max: 35,
                    errorText: 'Укажие номер телефона*',
                  )
                ]),
                hintText: 'Номер телефона*',
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWithCustomLabel(
                controller: _emailController,
                textInputAction: TextInputAction.done,
                maxLength: 35,
                keyboardType: TextInputType.emailAddress,
                validator: MultiValidator([
                  LengthRangeValidator(
                    min: 1,
                    max: 35,
                    errorText: 'Укажие E-mail*',
                  )
                ]),
                hintText: 'E-mail*',
              ),
              const SizedBox(
                height: 30,
              ),
              IconTextButton(
                onTap: _signOut,
                textStyle: const TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeSmall,
                  letterSpacing: 0.5,
                ),
                text: 'Выйти',
                icon: SvgPicture.asset(
                  AppIcons.logOut,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _genderSwitch({
  required Function(GenderType) onChange,
  GenderType genderType = GenderType.man,
}) {
  return RichTextWrapper(
    axis: Axis.horizontal,
    textStyle: const TextStyle(
      color: AppColors.darkBlue,
      fontWeight: AppFonts.bold,
      letterSpacing: 0.5,
      fontSize: AppFonts.sizeSmall,
    ),
    children: [
      GestureDetector(
        onTap: () {
          onChange(GenderType.man);
        },
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.boy,
              color: genderType == GenderType.man
                  ? AppColors.lightBlue
                  : AppColors.antiFlashWhite,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('Мужчина'),
          ],
        ),
      ),
      const SizedBox(
        width: 35,
      ),
      GestureDetector(
        onTap: () {
          onChange(GenderType.woman);
        },
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.girl,
              color: genderType == GenderType.woman
                  ? AppColors.lightBlue
                  : AppColors.antiFlashWhite,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('Женщина'),
          ],
        ),
      ),
    ],
  );
}
