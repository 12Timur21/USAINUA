import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    this.height = 56,
    this.backgroundColor = AppColors.buttonPrimary,
    this.textColor = AppColors.textQuaternary,
    required this.text,
    required this.onTap,
    this.style,
    Key? key,
  }) : super(key: key);

  final double height;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final VoidCallback onTap;
  final ButtonStyle? style;

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
        style: style,
      ),
    );
  }
}

TextStyle _textStyle = const TextStyle(
  fontWeight: AppFonts.bold,
  fontSize: AppFonts.sizeXSmall,
);
