import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    this.height = 56,
    this.backgroundColor = AppColors.lightGreen,
    this.textColor = AppColors.darkGreen,
    required this.text,
    required this.onTap,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  final double height;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: AppFonts.extraBold,
            fontSize: AppFonts.sizeXSmall,
            color: textColor,
            letterSpacing: 1,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
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
