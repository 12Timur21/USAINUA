import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class CustomDropDownWithSearch extends StatefulWidget {
  const CustomDropDownWithSearch({
    required this.items,
    required this.textController,
    required this.hintText,
    this.overlayHeight = 160,
    this.validator,
    Key? key,
  }) : super(key: key);

  final TextEditingController textController;

  final String hintText;
  final MultiValidator? validator;
  final double overlayHeight;
  final List<String> items;

  @override
  State<CustomDropDownWithSearch> createState() =>
      _CustomDropDownWithSearchState();
}

class _CustomDropDownWithSearchState extends State<CustomDropDownWithSearch> {
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
    _focusNode.dispose();
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
            child: ListView.builder(
              itemCount: widget.items.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    widget.items[index],
                  ),
                  onTap: () {
                    widget.textController.text = widget.items[index];
                    _focusNode.unfocus();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
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
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          // readOnly: true,
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
          ),
        ),
      ),
    );
  }
}
