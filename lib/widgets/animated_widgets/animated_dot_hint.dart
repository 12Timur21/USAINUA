import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';

class AnimatedDotHint extends StatefulWidget {
  const AnimatedDotHint({Key? key}) : super(key: key);

  @override
  State<AnimatedDotHint> createState() => _AnimatedDotHintState();
}

class _AnimatedDotHintState extends State<AnimatedDotHint>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Container(
        width: MediaQuery.of(context).size.height / 2,
        height: MediaQuery.of(context).size.height / 3,
        alignment: Alignment.topRight,
        color: Colors.green,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 220,
              height: 100,
              child: Text(
                'Ссылка на выбранный товар для доставки из магазина США / Европы, по этой ссылке будет произведен расчет стоимости доставки груза в Украину.!',
              ),
            ),
            Container(
              width: 66,
              height: 66,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.question,
                ),
              ),
            ),
          ],
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scaleY: _controller.value,
          scaleX: _controller.value,
          // scaleY: _controller.value,
          child: child,
        );
      },
    );
  }
}
