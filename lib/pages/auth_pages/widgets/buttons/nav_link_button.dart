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
      onPressed: () {},
      icon: icon,
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
