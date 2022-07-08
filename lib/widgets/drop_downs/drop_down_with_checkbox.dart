import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/check_boxes/custom_checkbox.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';

class DropDownWithCheckbox extends StatefulWidget {
  const DropDownWithCheckbox({
    required this.items,
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
  final List<String> items;

  @override
  _DropDownWithCheckboxState createState() => _DropDownWithCheckboxState();
}

class _DropDownWithCheckboxState extends State<DropDownWithCheckbox> {
  final _globalKey = GlobalKey();
  final _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  bool _isOverlayOpened = false;

  final LayerLink _layerLink = LayerLink();

  final List<String> _selectedItems = [];
  @override
  void initState() {
    _focusNode.addListener(() {
      print(_focusNode.hasFocus);
      if (!_focusNode.hasFocus) {
        _overlayEntry?.remove();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toogleSelectedItem(String item) {
    bool isSelected = _selectedItems.contains(item);
    if (isSelected) {
      _selectedItems.remove(item);
    } else {
      _selectedItems.add(item);
    }

    widget.textController.text = _selectedItems.join(', ');
    print(widget.textController.text.split(', '));
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
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                String item = widget.items[index];
                return ListTile(
                  title: _CheckBox(
                    isSelected: _selectedItems.contains(item),
                    onChanged: (_) => _toogleSelectedItem(item),
                    value: item,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _toogleOverlayStatus() {
    print('wtf');
    setState(() {
      _isOverlayOpened = _overlayEntry == null ? false : true;
      if (_isOverlayOpened) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      } else {
        _overlayEntry = _createOverlayEntry();

        Overlay.of(context)?.insert(_overlayEntry!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _globalKey,
        child: TextFieldWithCustomLabel(
          controller: widget.textController,
          onTap: _toogleOverlayStatus,
          focusNode: _focusNode,
          readOnly: true,
          validator: widget.validator,
          hintText: widget.hintText,
          // sufixIcon: GestureDetector(
          //   onTap: _toogleOverlayStatus,
          //   child: Padding(
          //     padding: const EdgeInsets.all(10),
          //     child: RotatedBox(
          //       quarterTurns: _isOverlayOpened ? 90 : 0,
          //       child: SvgPicture.asset(
          //         AppIcons.arrowDown,
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  const _CheckBox({
    required this.value,
    required this.isSelected,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final String value;
  final bool isSelected;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomCheckbox(
          isActive: isSelected,
          activeColor: AppColors.lightBlue,
          backgroundColor: Colors.white,
          onChanged: onChanged,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.regular,
              fontSize: AppFonts.sizeXSmall,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
