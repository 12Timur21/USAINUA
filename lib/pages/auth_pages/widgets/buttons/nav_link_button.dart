import 'package:flutter/material.dart';

class NavLinkButton extends StatelessWidget {
  const NavLinkButton({
    required this.onTap,
    required this.text,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: icon,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        splashFactory: NoSplash.splashFactory,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      label: Padding(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
