import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';

class ResiazableTextField extends StatefulWidget {
  final double height;
  final double maxHeight;
  final double minHeight;

  final TextEditingController controller;
  final String? hintText;

  const ResiazableTextField({
    required this.controller,
    this.height = 44,
    this.maxHeight = 200,
    this.minHeight = 120,
    this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  State<ResiazableTextField> createState() => _ResiazableTextFieldState();
}

class _ResiazableTextFieldState extends State<ResiazableTextField> {
  late double _height;

  UniqueKey uniqueKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _height = widget.height;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              contentPadding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 20,
              ),
            ),
            maxLines: 100,
          ),
          SizedBox(
            width: 32,
            height: 32,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: SvgPicture.asset(
                      AppIcons.drag,
                    ),
                  ),
                ),
                GestureDetector(
                  key: uniqueKey,
                
                  onVerticalDragUpdate: (DragUpdateDetails value) {
                    setState(() {
                      _height += value.delta.dy;

                      if (_height > widget.maxHeight) {
                        _height = widget.maxHeight;
                      } else if (_height < widget.minHeight) {
                        _height = widget.minHeight;
                      }
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
