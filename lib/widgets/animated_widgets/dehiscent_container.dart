import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';

class DehiscentContainer extends StatefulWidget {
  const DehiscentContainer({
    Key? key,
    required this.title,
    required this.body,
    this.isOpen = false,
  }) : super(key: key);

  final Widget title;
  final Widget body;

  final bool isOpen;

  @override
  State<DehiscentContainer> createState() => _DehiscentContainerState();
}

class _DehiscentContainerState extends State<DehiscentContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController expandController;
  late final Animation<double> animation;

  @override
  void initState() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );

    super.initState();
  }

  void _runExpandCheck() {
    if (widget.isOpen) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    _runExpandCheck();
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 500,
      ),
      child: Column(
        children: [
          widget.title,
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Column(
              children: [
                widget.body,
                const Divider(
                  thickness: 2,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
