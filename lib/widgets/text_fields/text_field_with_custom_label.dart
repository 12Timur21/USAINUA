import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

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
    this.sufixIcon,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
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
  final TextInputType? keyboardType;
  final bool readOnly;
  final Widget? sufixIcon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  @override
  State<TextFieldWithCustomLabel> createState() =>
      _TextFieldWithCustomLabelState();
}

class _TextFieldWithCustomLabelState extends State<TextFieldWithCustomLabel> {
  late final FocusNode _focusNode;
  bool _hasFocus = false;
  late String _currentText;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
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
    return Stack(
      children: [
        Container(
          height: widget.height,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(
              bottom: _currentText.isNotEmpty || _hasFocus ? 15 : 20,
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
                contentPadding: EdgeInsets.only(
                  left: 20,
                  right: widget.sufixIcon != null ? 50 : 20,
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 2,
                  minHeight: 2,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                alignLabelWithHint: true,
                filled: true,
                hintText:
                    _currentText.isEmpty && !_hasFocus ? widget.hintText : null,
                counterText: '',
                label: _currentText.isNotEmpty || _hasFocus
                    ? Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
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
              ),
              obscureText: widget.obscureText,
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
        ),
        Positioned(
          right: 5,
          top: 10,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: widget.sufixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
