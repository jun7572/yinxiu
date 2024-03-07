import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'stop_button_sq_painter.dart';

class StopButtonPatinter2 extends CustomPainter{
  final Color _playingIngColor=Color(0x88ffffff);
  final Color _playingCLickColor=Color(0x44ffffff);
  //回调方法
  VoidCallback sureCloseCallback;
  //整个控件宽,跟包这个的Container一样
  int width=120;

  double radius=0;
  late ClickState clickState;
  //播放状态
  late PlayState playState;
  //几个画笔
  Paint p=Paint();
  Paint pRRect=Paint();
  Paint dynamicPainter=Paint();
  Paint stopingPaint=Paint();
  Paint stopingPaint1=Paint();


  //当前的矩形半径
  final double circularRadius=50;

  StopButtonPatinter2(this.clickState,this.playState,this.sureCloseCallback){
    //总共100的宽,笔触宽10
    p.strokeWidth=2;
    radius=width/2-p.strokeWidth/2;
    p.color=_playingIngColor;
    p.style=PaintingStyle.stroke;
    p.strokeCap = StrokeCap.round;
    //
    pRRect..color=_playingIngColor
    ..strokeWidth=2
    ..style=PaintingStyle.fill;

    //动态变化的笔
    dynamicPainter.color=Colors.red;
    dynamicPainter.strokeWidth=1;
    dynamicPainter.style=PaintingStyle.stroke;
    dynamicPainter.strokeCap = StrokeCap.round;
    //停止状态的笔
    stopingPaint.color=Colors.white;
    stopingPaint.strokeWidth=1;
    stopingPaint.style=PaintingStyle.stroke;
    stopingPaint.strokeCap = StrokeCap.round;
    //停止状态的笔2
    stopingPaint1.color=Colors.yellow;
    stopingPaint1.strokeWidth=5;
    stopingPaint1.style=PaintingStyle.stroke;
    stopingPaint1.strokeCap = StrokeCap.round;



  }
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect); //裁剪区域
    if(playState==PlayState.playing){
      //画在中心
      // canvas.drawCircle(Offset(width/2,width/2), radius, p);
      //画中心的方块
      _drawsq(canvas,p);
      //长按的变化
      if(clickState==ClickState.clicking){
        p.color=_playingCLickColor;
        pRRect.color=_playingCLickColor;
        startAnima(canvas,rect);

      }else{
        p.color=_playingIngColor;
        i=0;
      }

    }else{

      _drawsq(canvas,stopingPaint);
    }




  }
  int i=0;
  startAnima(Canvas canvas,Rect rect){
    canvas.save();
    // canvas.drawArc(Rect.fromLTRB(0, 0, 30, 50), 90/ 180 * pi, 180/ 180 * pi, false, stopingPaint);
   
    canvas.restore();
    Path path=Path()..moveTo(0, 0);
    path.addRRect(RRect.fromLTRBR(0, 0, width.toDouble(), 50, Radius.circular(circularRadius)));
    
    // path.addArc(oval, startAngle, sweepAngle)
    canvas.drawPath(path, stopingPaint1);

  }

  _drawsq(Canvas canvas,Paint paint){

    canvas.save();
    canvas.drawRRect(RRect.fromLTRBR(0, 0, width.toDouble(), 50, Radius.circular(circularRadius)), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return true;
  }

}