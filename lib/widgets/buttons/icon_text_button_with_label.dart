import 'package:flutter/material.dart';

class IconTextButtonWithLabel extends StatelessWidget {
  const IconTextButtonWithLabel({
    required this.onTap,
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
  final VoidCallback onTap;
  final TextOverflow? textOverflow;
  final int maxLines;
  final bool isReverse;

  Widget _text({
    required EdgeInsets padding,
  }) {
    return Expanded(
      child: Padding(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment,
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
      ),
    );
  }
}
