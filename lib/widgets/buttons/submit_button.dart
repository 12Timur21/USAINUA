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
          style: _textStyle,
        ),
        style: TextButton.styleFrom(
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

TextStyle _textStyle = const TextStyle(
  fontWeight: AppFonts.bold,
  fontSize: AppFonts.sizeXSmall,
);
