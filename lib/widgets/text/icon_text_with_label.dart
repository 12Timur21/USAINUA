import 'package:flutter/material.dart';

class IconTextWithLabel extends StatelessWidget {
  const IconTextWithLabel({
    required this.label,
    required this.text,
    required this.icon,
    this.labelStyle,
    this.textStyle,
    this.maxLines = 1,
    this.isReverse = false,
    this.textOverflow,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final String label;
  final String text;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextOverflow? textOverflow;
  final int maxLines;
  final bool isReverse;

  Widget _text({
    required EdgeInsets padding,
  }) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: labelStyle,
          ),
          Text(
            text.characters
                .replaceAll(
                  Characters(''),
                  Characters(
                    '\u{200B}',
                  ),
                )
                .toString(),
            maxLines: maxLines,
            overflow: textOverflow,
            style: textStyle,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: isReverse
          ? [
              _text(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
              ),
              icon,
            ]
          : [
              icon,
              _text(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
              ),
            ],
    );
  }
}
