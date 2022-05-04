import 'package:flutter/material.dart';
import 'package:usainua/widgets/text/icon_text.dart';

class RichTextWidgets extends StatelessWidget {
  const RichTextWidgets({
    required this.children,
    this.textStyle,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    Key? key,
  }) : super(key: key);

  final List<Widget> children;
  final TextStyle? textStyle;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: textStyle,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      ),
    );
  }
}
