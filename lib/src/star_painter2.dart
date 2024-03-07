import 'package:flutter/material.dart';
import 'package:yinxiu/src/star2.dart';
import 'package:yinxiu/star.dart';

class StartPainter2 extends CustomPainter{

  List<Star2> list=[];
  StartPainter2(this.list);
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