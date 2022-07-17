import 'package:form_field_validator/form_field_validator.dart';

class NotEmptyStringValidator extends TextFieldValidator {
  NotEmptyStringValidator({
    required this.variable,
    required String errorText,
  }) : super(errorText);

  final String variable;

  @override
  bool isValid(_) => variable.isNotEmpty;
}
