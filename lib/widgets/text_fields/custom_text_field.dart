import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.controller,
    this.hintText,
    this.height = 56,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onFocus,
    this.formatters,
    this.maxLength,
    this.obscureText = false,
    required this.keyboardType,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final double height;
  final MultiValidator? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onFocus;
  final List<TextInputFormatter>? formatters;
  final int? maxLength;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isVisiblyMode;

  @override
  void initState() {
    isVisiblyMode = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator ?? MultiValidator([]),
      keyboardType: widget.keyboardType,
      inputFormatters: widget.formatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 24,
        ),
        filled: true,
        hintText: widget.hintText,
        counterText: '',
        suffixIcon: widget.obscureText
            ? IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    isVisiblyMode = !isVisiblyMode;
                  });
                },
                icon: SvgPicture.asset(
                  isVisiblyMode ? AppIcons.openEye : AppIcons.closedEye,
                ),
              )
            : null,
      ),
      obscureText: isVisiblyMode,

      //TODO Пример
      style: const TextStyle(
        color: AppColors.textPrimary,
      ),

      onChanged: widget.onChanged,
      onTap: widget.onFocus,
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}
