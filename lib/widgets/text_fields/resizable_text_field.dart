import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';

class ResiazableTextField extends StatefulWidget {
  final double height;
  final double maxHeight;
  final double dividerHeight;

  final TextEditingController controller;
  final String? hintText;

  const ResiazableTextField({
    required this.controller,
    this.height = 44,
    this.maxHeight = 200,
    this.dividerHeight = 40,
    this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  State<ResiazableTextField> createState() => _ResiazableTextFieldState();
}

class _ResiazableTextFieldState extends State<ResiazableTextField> {
  late double _height;
  late double _maxHeight;
  late double _dividerHeight;

  UniqueKey uniqueKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _height = widget.height;
    _maxHeight = widget.maxHeight;
    _dividerHeight = widget.dividerHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: _maxHeight,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: _height,
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
              ),
              maxLines: 100,
            ),
          ),
          Container(
            color: Colors.red,
            height: _dividerHeight,
            width: 60,
            child: Draggable(
              key: uniqueKey,
              child: const FittedBox(
                child: Text(
                  "----",
                ),
              ),
              feedback: Container(),

              onDragUpdate: (DragUpdateDetails value) {
                setState(() {
                  // var maxLimit = _maxHeight - _dividerHeight;
                  var minLimit = 44.0;
                  print(value.localPosition.dy);
                  _height = value.localPosition.dy;
                  if (_height > _maxHeight) {
                    _height = _maxHeight;
                  } else if (_height < minLimit) {
                    _height = minLimit;
                  }
                });
              },
              // onPanUpdate: (details) {
              //   setState(() {
              //     _height += details.delta.dy;

              //     var maxLimit = _maxHeight - _dividerHeight - _dividerSpace;
              //     var minLimit = 44.0;

              //     if (_height > maxLimit) {
              //       _height = maxLimit;
              //     } else if (_height < minLimit) {
              //       _height = minLimit;
              //     }
              //   });
              // },
            ),
          )
        ],
      ),
    );
  }
}
