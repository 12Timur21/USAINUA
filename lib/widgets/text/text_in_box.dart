import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

class TextInBox extends StatelessWidget {
  const TextInBox({
    required this.backgroundColor,
    required this.text,
    Key? key,
  }) : super(key: key);

  final Color backgroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 30,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.darkBlue,
          fontWeight: AppFonts.regular,
          fontSize: AppFonts.sizeXSmall,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
