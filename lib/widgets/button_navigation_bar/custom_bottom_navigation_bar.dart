import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';

import '../../blocs/navigation_bloc/navigation_bloc.dart';

class CustomButtonNavigationBar extends StatefulWidget {
  const CustomButtonNavigationBar({
    required this.onActiveButtonPressed,
    required this.onIndexChanged,
    Key? key,
  }) : super(key: key);

  final Function(int index) onIndexChanged;
  final VoidCallback onActiveButtonPressed;

  @override
  State<CustomButtonNavigationBar> createState() =>
      _CustomButtonNavigationBarState();
}

class _CustomButtonNavigationBarState extends State<CustomButtonNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 25,
      ),
      child: SizedBox(
        width: size.width,
        height: bottomNavBarHeight,
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: _CustomaActionButton(
                      isAcitve: state.showBottomSheet,
                      onTap: widget.onActiveButtonPressed,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          state.index == 0
                              ? AppIcons.homeFilled
                              : AppIcons.home,
                        ),
                        onPressed: () => widget.onIndexChanged(0),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          state.index == 1 ? AppIcons.bagFilled : AppIcons.bag,
                        ),
                        onPressed: () => widget.onIndexChanged(1),
                      ),
                      SizedBox(
                        width: size.width * 0.20,
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          state.index == 2 ? AppIcons.boxFilled : AppIcons.box,
                        ),
                        onPressed: () => widget.onIndexChanged(2),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          state.index == 3
                              ? AppIcons.userFilled
                              : AppIcons.user,
                        ),
                        onPressed: () => widget.onIndexChanged(3),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CustomaActionButton extends StatefulWidget {
  const _CustomaActionButton({
    required this.isAcitve,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final bool isAcitve;
  final VoidCallback onTap;

  @override
  State<_CustomaActionButton> createState() => _CustomaActionButtonState();
}

class _CustomaActionButtonState extends State<_CustomaActionButton>
    with TickerProviderStateMixin {
  late final Animation<double> _buttonRotationAnimation = Tween<double>(
    begin: 0.0,
    end: 0.375,
  ).animate(
    CurvedAnimation(
      curve: Curves.ease,
      parent: _containerAnimationController,
    ),
  );
  late final Animation _buttonColorAnimation = ColorTween(
    begin: AppColors.lightGreen,
    end: AppColors.darkBlue,
  ).animate(
    CurvedAnimation(
      curve: Curves.ease,
      parent: _containerAnimationController,
    ),
  );
  late final Animation _iconColorAnimation = ColorTween(
    begin: AppColors.darkGreen,
    end: Colors.white,
  ).animate(
    CurvedAnimation(
      curve: Curves.ease,
      parent: _containerAnimationController,
    ),
  );

  late final AnimationController _containerAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 1500,
    ),
  );

  @override
  void dispose() {
    _containerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAcitve) {
      _containerAnimationController.forward();
    } else {
      _containerAnimationController.reverse();
    }
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _containerAnimationController,
        builder: (context, _) {
          return RotationTransition(
            turns: _buttonRotationAnimation,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _buttonColorAnimation.value,
              ),
              child: Center(
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: SvgPicture.asset(
                    AppIcons.plus,
                    color: _iconColorAnimation.value,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    const double radius = 20;

    Paint paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    Path path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(width * 0.2, 0, width * 0.35, 0);
    path.quadraticBezierTo(width * 0.4, 0, width * 0.40, 20);
    path.arcToPoint(
      Offset(width * 0.6, 10),
      radius: const Radius.circular(radius),
      clockwise: false,
    );

    path.quadraticBezierTo(width * 0.6, 0, width * 0.65, 0);

    //top right
    path.quadraticBezierTo(width - radius, 0, width - radius, 0);
    path.arcToPoint(
      Offset(width, radius),
      radius: const Radius.circular(radius),
    );
    //top right

    //bottom right
    path.quadraticBezierTo(width, height - radius, width, height - radius);
    path.arcToPoint(
      Offset(width - radius, height),
      radius: const Radius.circular(radius),
    );
    //bottom right

    //bottom left
    path.quadraticBezierTo(radius, height, radius, height);
    path.arcToPoint(
      Offset(0, height - radius),
      radius: const Radius.circular(radius),
    );
    //bottom left

    //top left
    path.quadraticBezierTo(0, radius, 0, radius);
    path.arcToPoint(
      const Offset(radius, 0),
      radius: const Radius.circular(radius),
    );
    //top left

    canvas.drawShadow(
      path,
      const Color(0xFF093B77).withOpacity(0.8),
      11,
      true,
    );
    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
