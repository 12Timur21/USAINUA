import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

class TextFieldWithCustomLabel extends StatefulWidget {
  const TextFieldWithCustomLabel({
    required this.controller,
    required this.hintText,
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
    this.autovalidateMode,
    this.isDisable = false,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
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
  final AutovalidateMode? autovalidateMode;
  final bool isDisable;

  @override
  State<TextFieldWithCustomLabel> createState() =>
      _TextFieldWithCustomLabelState();
}

class _TextFieldWithCustomLabelState extends State<TextFieldWithCustomLabel> {
  late FocusNode _focusNode;
  String? _currentText;
  FormFieldState<String?>? _currentFormFieldState;
  String? _errorText;
  bool _hasFocus = false;
  bool _isCompressedLayout = false;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _currentText = widget.controller.text;

    _focusNode.addListener(() {
      if (!widget.readOnly) {
        setState(() {
          _hasFocus = _focusNode.hasFocus;
          _currentText = widget.controller.text;
        });
      }
    });

    widget.controller.addListener(_controllerListener);

    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerListener);
    super.dispose();
  }

  void _controllerListener() {
    _currentFormFieldState?.setValue(widget.controller.text);
    setState(() {
      _currentText = widget.controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasFocus || _currentText != '') {
      _isCompressedLayout = true;
    } else {
      _isCompressedLayout = false;
    }

    return Stack(
      children: [
        AnimatedContainer(
          height: _errorText != null ? 85 : 60,
          duration: const Duration(milliseconds: 100),
          child: FormField<String>(
            initialValue: _currentText,
            validator: widget.validator ?? MultiValidator([]),
            builder: (FormFieldState<String?> field) {
              _currentFormFieldState = field;

              if (_errorText != field.errorText) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _errorText = field.errorText;
                  });
                });
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            border: _errorText != null
                                ? Border.all(
                                    color: Colors.red,
                                  )
                                : null,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: _isCompressedLayout ? 17 : 0,
                            ),
                            child: TextFormField(
                              focusNode: _focusNode,
                              readOnly: widget.readOnly,
                              controller: widget.controller,
                              autovalidateMode: widget.autovalidateMode,
                              keyboardType: widget.keyboardType,
                              inputFormatters: widget.formatters,
                              cursorColor: AppColors.darkBlue,
                              textInputAction: widget.textInputAction,
                              maxLines: null,
                              minLines: null,
                              expands: true,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                alignLabelWithHint: true,
                                hintText: _isCompressedLayout
                                    ? null
                                    : widget.hintText,
                                counterText: '',
                                errorStyle: const TextStyle(height: 0),
                                errorText: '',
                                // errorBorder: const OutlineInputBorder(
                                //   borderRadius: BorderRadius.all(
                                //     Radius.circular(20),
                                //   ),

                                // ),
                                label: _isCompressedLayout
                                    ? Text(
                                        widget.hintText,
                                        style: const TextStyle(
                                          color: AppColors.noActiveText,
                                          fontWeight: AppFonts.regular,
                                          letterSpacing: 1,
                                          fontSize: AppFonts.sizeXSmall,
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
                    ),
                  ),
                  if (_errorText != null)
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            _currentFormFieldState?.errorText ?? '',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: AppFonts.sizeXSmall,
                              fontWeight: AppFonts.regular,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        if (widget.isDisable)
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.boxShadow.withOpacity(0.4),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
      ],
    );
  }
}
