import 'package:flutter/material.dart';

class ColorsConstant {
  static const Color primaryColor = Color(0xffFB9722);
  static const Color backgroundColor = Color(0xff001428);
  static const LinearGradient gradientTopToBottom = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      backgroundColor,
      Colors.transparent,
    ],
  );
  static const LinearGradient gradientBottomToTop = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      backgroundColor,
      Colors.transparent,
    ],
  );
}
