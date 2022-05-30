import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';

class CustomRadioOption<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T> onChanged;

  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;

  const CustomRadioOption({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor = AppColors.lightBlue,
    this.inactiveColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return InkWell(
      onTap: () {
        onChanged(value);
      },
      borderRadius: BorderRadius.circular(
        15,
      ),
      splashColor: activeColor,
      radius: 20,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
            width: 8,
            color: isSelected ? activeColor : inactiveColor,
          ),
        ),
      ),
    );
  }
}
