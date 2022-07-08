import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/models/user_model.dart';
import 'package:usainua/pages/auth_pages/sign_in_page/sign_in_page.dart';
import 'package:usainua/repositories/auth_repository.dart';
import 'package:usainua/repositories/firestore_repository.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/utils/validators/phone_validator.dart';
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
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late UserModel _oldUserModel;
  late UserModel _userModelWithChanges;

  bool _hasChanges = false;

  @override
  void initState() {
    _oldUserModel = context.read<AuthorizationBloc>().state.userModel!;
    _userModelWithChanges = _oldUserModel;

    _nameController.text = _oldUserModel.name.toString();
    if (_oldUserModel.birthday != null) {
      _birthdayController.text = DateFormat('dd.MM.yy').format(
        _oldUserModel.birthday!,
      );
    }
    _phoneNumberController.text = _oldUserModel.phoneNumber.toString();
    _emailController.text = _oldUserModel.email.toString();

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
      _makeChanges(
        _userModelWithChanges.copyWith(
          birthday: picked,
        ),
      );
      setState(() {
        _birthdayController.text = DateFormat('dd.MM.yy').format(picked);
      });
    }
    FocusScope.of(context).unfocus();
  }

  Future<void> _signOut() async {
    await AuthRepository.instance.signOut();
    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      SignInPage.routeName,
      ModalRoute.withName('/'),
    );
  }

  void _saveChanges() {
    bool isFormValid = _formKey.currentState?.validate() ?? false;

    if (isFormValid && _oldUserModel != _userModelWithChanges) {
      setState(() {
        _oldUserModel = _userModelWithChanges;
        _hasChanges = false;
      });

      FirestoreRepository.instance.updateUser(
        userModel: _userModelWithChanges,
      );

      context.read<AuthorizationBloc>().add(
            UpdateUserModel(
              userModel: _oldUserModel,
            ),
          );
    }
  }

  void _makeChanges(UserModel updates) {
    setState(() {
      _userModelWithChanges = updates;
      if (_oldUserModel != _userModelWithChanges) {
        _hasChanges = true;
      } else {
        _hasChanges = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        text: 'Личные данные',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            onChanged: () {},
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
                  onChanged: (value) => _makeChanges(
                    _userModelWithChanges.copyWith(
                      name: value,
                    ),
                  ),
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
                  onTap: _selectDate,
                  validator: MultiValidator([
                    MaxLengthValidator(
                      35,
                      errorText: 'Укажие дату рождения*',
                    ),
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
                _GenderSwitch(
                  initGenderType: _oldUserModel.genderType,
                  onChange: (GenderType value) => _makeChanges(
                    _userModelWithChanges.copyWith(
                      genderType: value,
                    ),
                  ),
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
                    PhoneValidator(
                      errorText: 'Укажите правильный номер телефона',
                    ),
                    LengthRangeValidator(
                      min: 1,
                      max: 35,
                      errorText: 'Укажие номер телефона*',
                    )
                  ]),
                  hintText: 'Номер телефона*',
                  onChanged: (value) => _makeChanges(
                    _userModelWithChanges.copyWith(
                      phoneNumber: toNumericString(value),
                    ),
                  ),
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
                    EmailValidator(
                      errorText: 'Укажите правильную почту',
                    ),
                    LengthRangeValidator(
                      min: 1,
                      max: 35,
                      errorText: 'Укажие E-mail*',
                    )
                  ]),
                  hintText: 'E-mail*',
                  onChanged: (value) => _makeChanges(
                    _userModelWithChanges.copyWith(
                      email: value,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                if (_hasChanges)
                  IconTextButton(
                    onTap: _saveChanges,
                    textStyle: const TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.bold,
                      fontSize: AppFonts.sizeSmall,
                      letterSpacing: 0.5,
                    ),
                    text: 'Сохранить изменения',
                    icon: const Icon(
                      Icons.save,
                      color: AppColors.darkBlue,
                    ),
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
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GenderSwitch extends StatefulWidget {
  const _GenderSwitch({
    required this.onChange,
    this.initGenderType,
    Key? key,
  }) : super(key: key);

  final Function(GenderType) onChange;
  final GenderType? initGenderType;

  @override
  State<_GenderSwitch> createState() => _GenderSwitchState();
}

class _GenderSwitchState extends State<_GenderSwitch> {
  GenderType? _genderType;

  @override
  void initState() {
    _genderType = widget.initGenderType ?? GenderType.man;
    super.initState();
  }

  void _changeGenderType(GenderType genderType) {
    widget.onChange(genderType);
    setState(() {
      _genderType = genderType;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () => _changeGenderType(GenderType.man),
          child: Row(
            children: [
              SvgPicture.asset(
                AppIcons.boy,
                color: _genderType == GenderType.man
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
          onTap: () => _changeGenderType(GenderType.woman),
          child: Row(
            children: [
              SvgPicture.asset(
                AppIcons.girl,
                color: _genderType == GenderType.woman
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
}
