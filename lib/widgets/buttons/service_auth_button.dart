import 'package:flutter/material.dart';

class ServiceAuthButton extends StatelessWidget {
  const ServiceAuthButton({
    required this.onTap,
    required this.text,
    required this.icon,
    this.height = 56,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final String text;
  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFF1FDF8),
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        //!CHANGE

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text,
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
