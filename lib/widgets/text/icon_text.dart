import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    required this.icon,
    required this.label,
    this.textStyle,
    this.textAlign,
    this.iconPadding = const EdgeInsets.only(),
    this.mainAxisAlignment = MainAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final String label;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final EdgeInsets iconPadding;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Padding(
          padding: iconPadding,
          child: icon,
        ),
        Flexible(
          child: Text(
            label,
            style: textStyle,
            textAlign: textAlign,
          ),
        ),
      ],
    );
  }
}
