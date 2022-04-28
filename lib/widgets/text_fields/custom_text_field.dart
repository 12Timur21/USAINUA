import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.hintText,
    this.height = 56,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onFocus,
    this.formatters,
    this.maxLength,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  final String? hintText;
  final double height;
  final MultiValidator? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onFocus;
  final List<TextInputFormatter>? formatters;
  final int? maxLength;
  final bool obscureText;

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

  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: TextFormField(
        validator: widget.validator ?? MultiValidator([]),

        maxLength: widget.maxLength,

        inputFormatters: widget.formatters,

        decoration: InputDecoration(
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
      ),
    );
  }
}
