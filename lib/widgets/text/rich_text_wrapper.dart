import 'package:flutter/material.dart';

class RichTextWrapper extends StatelessWidget {
  const RichTextWrapper({
    required this.children,
    this.axis = Axis.vertical,
    this.textStyle,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    Key? key,
  }) : super(key: key);

  final List<Widget> children;
  final TextStyle? textStyle;
  final Axis axis;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: textStyle,
      child: axis == Axis.vertical
          ? Column(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: mainAxisAlignment,
              children: children,
            )
          : Row(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: mainAxisAlignment,
              children: children,
            ),
    );
  }
}
