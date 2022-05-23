import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';

class CustomButtonNavigationBar extends StatefulWidget {
  const CustomButtonNavigationBar({
    required this.currentIndex,
    required this.onChange,
    required this.onFloatingActionButtonPressed,
    Key? key,
  })  : assert(currentIndex < 3),
        super(key: key);

  final int currentIndex;
  final Function(int) onChange;
  final VoidCallback onFloatingActionButtonPressed;

  @override
  State<CustomButtonNavigationBar> createState() =>
      _CustomButtonNavigationBarState();
}

class _CustomButtonNavigationBarState extends State<CustomButtonNavigationBar> {
  int? _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  _setBottomBarIndex(index) {
    setState(() {
      _currentIndex = index;
      widget.onChange(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 80,
      child: Stack(
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
              child: FloatingActionButton(
                backgroundColor: AppColors.lightGreen,
                // elevation: 15,
                onPressed: widget.onFloatingActionButtonPressed,
                child: Container(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: SvgPicture.asset(AppIcons.plus),
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightGreen.withOpacity(0.16),
                        blurRadius: 15,
                        spreadRadius: 10,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                ),
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
                    _currentIndex == 0 ? AppIcons.homeFilled : AppIcons.home,
                  ),
                  onPressed: () {
                    _setBottomBarIndex(0);
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    _currentIndex == 1 ? AppIcons.bagFilled : AppIcons.bag,
                  ),
                  onPressed: () {
                    _setBottomBarIndex(1);
                  },
                ),
                SizedBox(
                  width: size.width * 0.20,
                ),
                IconButton(
                    icon: SvgPicture.asset(
                      _currentIndex == 2 ? AppIcons.boxFilled : AppIcons.box,
                    ),
                    onPressed: () {
                      _setBottomBarIndex(2);
                    }),
                IconButton(
                    icon: SvgPicture.asset(
                      _currentIndex == 3 ? AppIcons.userFilled : AppIcons.user,
                    ),
                    onPressed: () {
                      _setBottomBarIndex(3);
                    }),
              ],
            ),
          )
        ],
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
      30,
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
