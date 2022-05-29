import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';

class CustomCheckbox extends StatefulWidget {
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    this.isActive = false,
    required this.onChanged,
    this.activeColor = AppColors.lightBlue,
    this.inactiveColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isActive;

  @override
  void initState() {
    _isActive = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isActive = !_isActive;

          widget.onChanged(_isActive);
        });
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
            width: 8,
            color: _isActive ? widget.activeColor : widget.inactiveColor,
          ),
        ),
      ),
    );
  }
}
