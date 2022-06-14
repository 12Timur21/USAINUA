import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    this.height = 56,
    this.backgroundColor = AppColors.lightGreen,
    this.noActiveBackgroundColor = AppColors.antiFlashWhite,
    this.noActiveTextColor = AppColors.noActiveText,
    this.textColor = AppColors.darkGreen,
    required this.text,
    required this.onTap,
    this.borderRadius,
    this.isActive = true,
    Key? key,
  }) : super(key: key);

  final double height;
  final Color backgroundColor;
  final Color noActiveBackgroundColor;
  final Color noActiveTextColor;
  final Color textColor;
  final String text;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isActive ? onTap : null,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: AppFonts.extraBold,
            fontSize: AppFonts.sizeXSmall,
            color: isActive ? textColor : noActiveTextColor,
            letterSpacing: 1,
          ),
        ),
        style: TextButton.styleFrom(
          shadowColor: isActive ? backgroundColor : noActiveBackgroundColor,
          backgroundColor: isActive ? backgroundColor : noActiveBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ??
                BorderRadius.circular(
                  16,
                ),
          ),
        ),
      ),
    );
  }
}
