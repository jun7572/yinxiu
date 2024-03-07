import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MPatiner extends CustomPainter{
  Paint p=  Paint()..color=Colors.black;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTRB(0, 0, 100, 100), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}