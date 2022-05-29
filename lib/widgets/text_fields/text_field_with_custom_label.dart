import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';

class TextFieldWithCustomLabel extends StatefulWidget {
  const TextFieldWithCustomLabel({
    required this.controller,
    required this.hintText,
    this.height = 60,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.formatters,
    this.maxLength,
    this.obscureText = false,
    this.readOnly = false,
    required this.keyboardType,
    required this.textInputAction,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final double height;
  final MultiValidator? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? formatters;
  final int? maxLength;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool readOnly;
  final TextInputAction textInputAction;

  @override
  State<TextFieldWithCustomLabel> createState() =>
      _TextFieldWithCustomLabelState();
}

class _TextFieldWithCustomLabelState extends State<TextFieldWithCustomLabel> {
  late bool isVisiblyMode;
  final _focusNode = FocusNode();
  bool _hasFocus = false;
  String? _currentText;

  @override
  void initState() {
    isVisiblyMode = widget.obscureText;
    _currentText = widget.controller.text;

    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
        _currentText = widget.controller.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      alignment: !_hasFocus && _currentText!.isEmpty
          ? Alignment.center
          : Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        child: TextFormField(
          focusNode: _focusNode,
          readOnly: widget.readOnly,
          controller: widget.controller,
          validator: widget.validator ?? MultiValidator([]),
          keyboardType: widget.keyboardType,
          inputFormatters: widget.formatters,
          cursorColor: AppColors.darkBlue,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(
              left: 20,
              top: 10,
              bottom: 0,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            alignLabelWithHint: true,
            filled: true,
            hintText: _currentText == null ? widget.hintText : null,
            counterText: '',
            label: _currentText != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.hintText,
                      style: const TextStyle(
                        color: AppColors.noActiveText,
                        fontWeight: AppFonts.regular,
                        letterSpacing: 1,
                        fontSize: AppFonts.sizeXSmall,
                      ),
                    ),
                  )
                : null,
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
          style: const TextStyle(
            color: AppColors.darkBlue,
          ),
          onChanged: (value) {
            setState(() {
              _currentText = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
              _focusNode.requestFocus();
            }
          },
          onFieldSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }
}
