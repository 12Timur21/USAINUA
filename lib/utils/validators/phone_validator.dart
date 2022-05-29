import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PhoneValidator extends TextFieldValidator {
  PhoneValidator({
    required String errorText,
  }) : super(errorText);

  @override
  bool isValid(String? value) => isPhoneValid(value ?? '');
}
