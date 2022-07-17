import 'package:form_field_validator/form_field_validator.dart';

class VariableNotNullValidator<T> extends TextFieldValidator {
  VariableNotNullValidator({
    required this.variable,
    required String errorText,
  }) : super(errorText);

  final T? variable;

  @override
  bool isValid(_) => variable != null;
}
