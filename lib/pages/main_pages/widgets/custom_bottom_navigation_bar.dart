import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_icons.dart';

class CustomButtonNavigationBar extends StatefulWidget {
  const CustomButtonNavigationBar({
    required this.currentIndex,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final int currentIndex;
  final Function(int) onChange;

  @override
  State<CustomButtonNavigationBar> createState() =>
      _CustomButtonNavigationBarState();
}

class _CustomButtonNavigationBarState extends State<CustomButtonNavigationBar> {
  late int _currentIndex;

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
        //overflow: Overflow.visible,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
                backgroundColor: Colors.green[700],
                child: const Icon(Icons.search), // Analyze Button
                elevation: 0.1,
                onPressed: () {}),
          ),
          SizedBox(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.home,
                  ),
                  onPressed: () {
                    _setBottomBarIndex(0);
                  },
                  splashColor: Colors.white,
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.bag,
                  ),
                  onPressed: () {
                    _setBottomBarIndex(1);
                  },
                ),
                Container(
                  width: size.width * 0.20,
                ),
                IconButton(
                    icon: SvgPicture.asset(
                      AppIcons.box,
                    ),
                    onPressed: () {
                      _setBottomBarIndex(3);
                    }),
                IconButton(
                    icon: SvgPicture.asset(
                      AppIcons.user,
                    ),
                    onPressed: () {
                      _setBottomBarIndex(4);
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
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Path path = Path();
    print(size.width);
    print(size.height);
    path.moveTo(0, 0); // Start
    path.quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.4, 0, size.width * 0.40, 20);

    // path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.6, 20);
    path.arcToPoint(
      Offset(size.width * 0.6, 10),
      radius: const Radius.circular(20),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.8, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
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
