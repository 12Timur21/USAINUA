import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/utils/helpers/overlay_hints.dart';

import '../../resources/app_icons.dart';

class AnimatedDotHint extends StatefulWidget {
  const AnimatedDotHint({
    required this.overlayController,
    Key? key,
  }) : super(key: key);

  final OverlayController overlayController;

  @override
  State<AnimatedDotHint> createState() => _AnimatedDotHintState();
}

class _AnimatedDotHintState extends State<AnimatedDotHint>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<double> _radiusTweenAnimation = Tween<double>(
    begin: 0.0,
    end: 340,
  ).animate(
    CurvedAnimation(
      curve: Curves.ease,
      parent: _animationController,
    ),
  );

  @override
  void initState() {
    widget.overlayController.open = () {
      _animationController.forward();
    };
    widget.overlayController.close = () {
      _animationController.reverse();
    };

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          _animationController.reverse();
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Stack(
                children: [
                  Positioned(
                    right: -_radiusTweenAnimation.value,
                    top: -_radiusTweenAnimation.value,
                    child: Container(
                      width: _radiusTweenAnimation.value * 2,
                      height: _radiusTweenAnimation.value * 2.8,
                      decoration: const BoxDecoration(
                        color: AppColors.lightBlue,
                        shape: BoxShape.circle,
                      ),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 40,
                              ),
                              const SizedBox(
                                width: 220,
                                height: 100,
                                child: Text(
                                  'Ссылка на выбранный товар для доставки из магазина США / Европы, по этой ссылке будет произведен расчет стоимости доставки груза в Украину.!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: AppFonts.regular,
                                    fontSize: AppFonts.sizeXSmall,
                                    letterSpacing: 1,
                                  ),
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
                          )),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
