import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    this.onLeading,
    this.onAction,
    this.text,
    this.leadingIcon,
    this.actionIcon,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onLeading;
  final VoidCallback? onAction;
  final String? text;
  final Widget? leadingIcon;
  final SvgPicture? actionIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: leadingIcon ??
            SvgPicture.asset(
              AppIcons.leftArrow,
              color: AppColors.lightBlue,
            ),
        onPressed: onLeading,
      ),
      centerTitle: true,
      title: text != null
          ? Text(
              text!,
              style: const TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.bold,
                letterSpacing: 0.5,
                fontSize: AppFonts.sizeLarge,
              ),
            )
          : null,
      actions: [
        if (onAction != null)
          IconButton(
            icon: actionIcon ??
                SvgPicture.asset(
                  AppIcons.dialog,
                  color: AppColors.lightBlue,
                ),
            onPressed: onAction,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
