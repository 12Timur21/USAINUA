import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/blocs/authentication_bloc/authentification_bloc.dart';
import 'package:usainua/models/user_model.dart';
import 'package:usainua/pages/privacy_terms_page/privacy_terms_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/utils/validators/phone_validator.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class AdditionalDataCollectionPageParameters {
  const AdditionalDataCollectionPageParameters({
    required this.authCredential,
    required this.userModel,
  });

  final UserModel userModel;
  final AuthCredential authCredential;
}

class AdditionalDataCollectionPage extends StatefulWidget {
  const AdditionalDataCollectionPage({
    required this.parameters,
    Key? key,
  }) : super(key: key);

  static const routeName = '/additional_data_collection_page';

  final AdditionalDataCollectionPageParameters parameters;

  @override
  State<AdditionalDataCollectionPage> createState() =>
      _AdditionalDataCollectionPageState();
}

class _AdditionalDataCollectionPageState
    extends State<AdditionalDataCollectionPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget.parameters.userModel.name,
    );

    _emailController = TextEditingController(
      text: widget.parameters.userModel.email,
    );
    _phoneController = TextEditingController(
      text: widget.parameters.userModel.phoneNumber,
    );
    super.initState();
  }

  void _showPrivacyPolicy() {
    Navigator.of(context).pushNamed(
      PrivacyTermsPage.routeName,
      arguments: 'privacy_policy.md',
    );
  }

  void _validateFormAndRegister(BuildContext context) {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      final UserModel updatedUserModel = widget.parameters.userModel.copyWith(
        name: _nameController.text,
        email: _emailController.text,
        phoneNumber: toNumericString(_phoneController.text),
      );

      context.read<AuthentificationBloc>().add(
            AuthentificationCreateNewUser(
              userModel: updatedUserModel,
              authCredential: widget.parameters.authCredential,
            ),
          );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '??????????????????????',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.042,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldWithCustomLabel(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    maxLength: 35,
                    keyboardType: TextInputType.name,
                    validator: MultiValidator([
                      LengthRangeValidator(
                        min: 1,
                        max: 35,
                        errorText: '?????????????? ???????? ??????',
                      )
                    ]),
                    hintText: '???????? ??????*',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWithCustomLabel(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator(
                      [
                        EmailValidator(
                          errorText: '?????????????? ???????????????????? email',
                        ),
                        MinLengthValidator(
                          1,
                          errorText: '?????????????? ???????? ??????????',
                        ),
                      ],
                    ),
                    hintText: '?????? email*',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWithCustomLabel(
                    controller: _phoneController,
                    textInputAction: TextInputAction.next,
                    hintText: '?????? ?????????? ????????????????*',
                    keyboardType: TextInputType.phone,
                    formatters: [
                      PhoneInputFormatter(),
                    ],
                    validator: MultiValidator(
                      [
                        MinLengthValidator(
                          1,
                          errorText: '?????????????? ?????????? ????????????????',
                        ),
                        PhoneValidator(
                          errorText: '?????????????? ???????????????????? ?????????? ????????????????',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: AppFonts.sizeXSmall,
                  fontWeight: AppFonts.regular,
                  letterSpacing: 0.75,
                  color: AppColors.darkBlue,
                ),
                children: <TextSpan>[
                  const TextSpan(text: '??????????????????????????, ???? ???????????????????????? ?? '),
                  TextSpan(
                    text: '???????????????????????????????? ??????????????????????',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _showPrivacyPolicy(),
                    style: const TextStyle(
                      height: 1.5,
                      shadows: [
                        Shadow(
                          color: AppColors.darkBlue,
                          offset: Offset(0, -3),
                        )
                      ],
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
            BlocBuilder<AuthentificationBloc, AuthentificationState>(
              builder: (context, state) {
                return SubmitButton(
                  onTap: () {
                    _validateFormAndRegister(context);
                  },
                  text: '????????????????????????????????????',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
