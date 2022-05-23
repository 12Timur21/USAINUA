import 'package:flutter/material.dart';

class NavLinkButton extends StatelessWidget {
  const NavLinkButton({
    required this.onTap,
    required this.text,
    required this.icon,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
