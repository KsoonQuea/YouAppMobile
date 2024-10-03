import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const GradientButton({
    Key? key,
    required this.child,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5DE0E6), Color(0xFF004AAD)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(width: width, child: child)
    );
  }
}