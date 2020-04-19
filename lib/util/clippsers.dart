import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    return Path()
      ..lineTo(0, height * .8)
      ..quadraticBezierTo(width * .25, height, width / 2, height)
      ..quadraticBezierTo(width * 0.75, height, width, height * .8)
      ..lineTo(width, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
