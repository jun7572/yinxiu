import 'package:flutter/material.dart';
import 'package:yinxiu/star.dart';

class StartPainter extends CustomPainter{

  List<Star> list=[];
  StartPainter(this.list);
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