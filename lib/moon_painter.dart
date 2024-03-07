import 'package:flutter/material.dart';
import 'package:yinxiu/moon.dart';

class MoonPainter extends CustomPainter{

    List<Moon> list=[];
    MoonPainter(this.list);

  @override
  void paint(Canvas canvas, Size size) {

    for(int i=0;i<list.length;i++){

      list[i].paint(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return true;
  }


}