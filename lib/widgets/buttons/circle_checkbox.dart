import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';

class CircleCheckbox extends StatelessWidget {
  const CircleCheckbox({
    required this.isActive,
    required this.circleColor,
    this.inactiveColor = AppColors.primary,
    required this.child,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final bool isActive;
  final Color circleColor;
  final Color inactiveColor;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 8,
                color: isActive ? circleColor : inactiveColor,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
