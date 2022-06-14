import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    required this.textController,
    required this.errorText,
    required this.hintText,
    this.overlayHeight = 160,
    this.validator,
    Key? key,
  }) : super(key: key);

  final TextEditingController textController;
  final String errorText;
  final String hintText;
  final MultiValidator? validator;
  final double overlayHeight;

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final _focusNode = FocusNode();
  final _globalKey = GlobalKey();

  OverlayEntry? _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          _overlayEntry = _createOverlayEntry();
          Overlay.of(context)?.insert(_overlayEntry!);
        } else {
          _overlayEntry?.remove();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.dispose();

    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox =
        _globalKey.currentContext?.findRenderObject() as RenderBox;
    return OverlayEntry(
        builder: (context) => Positioned(
              width: renderBox.size.width,
              height: widget.overlayHeight,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: const Offset(
                  0.0,
                  48 + 18,
                ),
                child: Material(
                  elevation: 4.0,
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: const Text('Syria'),
                        onTap: () {
                          widget.textController.text = 'Syria';
                          _focusNode.unfocus();
                        },
                      ),
                      ListTile(
                        title: const Text('Lebanon'),
                        onTap: () {
                          widget.textController.text = 'Lebanon';
                          _focusNode.unfocus();
                        },
                      ),
                      ListTile(
                        title: const Text('Lebanon'),
                        onTap: () {
                          widget.textController.text = 'Lebanon';
                          _focusNode.unfocus();
                        },
                      ),
                      ListTile(
                        title: const Text('Lebanon'),
                        onTap: () {
                          widget.textController.text = 'Lebanon';
                          _focusNode.unfocus();
                        },
                      ),
                      ListTile(
                        title: const Text('Lebanon'),
                        onTap: () {
                          widget.textController.text = 'Lebanon';
                          _focusNode.unfocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _globalKey,
        child: TextFieldWithCustomLabel(
            controller: widget.textController,
            focusNode: _focusNode,
            readOnly: true,
            validator: widget.validator,
            hintText: widget.hintText,
            sufixIcon: GestureDetector(
              onTap: () {
                if (_focusNode.hasFocus) {
                  _focusNode.unfocus();
                }
              },
              child: RotatedBox(
                quarterTurns: _focusNode.hasFocus ? 90 : 0,
                child: SvgPicture.asset(
                  AppIcons.arrowDown,
                ),
              ),
            )),
      ),
    );
  }
}
