import 'package:form_field_validator/form_field_validator.dart';

class IsValidValidator extends TextFieldValidator {
  IsValidValidator(
    this.status, {
    required String errorText,
  }) : super(errorText);
  final bool status;

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return status;
  }
}
