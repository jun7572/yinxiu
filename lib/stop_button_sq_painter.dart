import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
enum PlayState{
  stoping,
  playing,
}
enum ClickState{

  clicking,
  unclick
}
class StopButtonPatinter extends CustomPainter{
  final Color _playingIngColor=Color(0x88ffffff);
  final Color _playingCLickColor=Color(0x44ffffff);
  //回调方法
  VoidCallback sureCloseCallback;
  //整个控件宽,跟包这个的Container一样
  int width=100;

  double radius=0;
  late ClickState clickState;
  //播放状态
  late PlayState playState;
  Paint p=Paint();
  Paint pRRect=Paint();
  Paint dynamicPainter=Paint();
  Paint stopingPaint=Paint();
  Paint stopingPaint1=Paint();

  StopButtonPatinter(this.clickState,this.playState,this.sureCloseCallback){
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


    dynamicPainter.color=Colors.red;
    dynamicPainter.strokeWidth=2;
    dynamicPainter.style=PaintingStyle.stroke;
    dynamicPainter.strokeCap = StrokeCap.round;

    stopingPaint.color=Colors.white;
    stopingPaint.strokeWidth=2;
    stopingPaint.style=PaintingStyle.stroke;
    stopingPaint.strokeCap = StrokeCap.round;

    stopingPaint1.color=Colors.white;
    stopingPaint1.strokeWidth=2;
    stopingPaint1.style=PaintingStyle.fill;
    stopingPaint1.strokeCap = StrokeCap.round;


    // backgroundPaint..blendMode = BlendMode.clear;
    backgroundPaint.color=Colors.transparent;

  }
  Paint backgroundPaint=Paint();
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect); //裁剪区域



    canvas.drawRect(Rect.fromLTRB(0, 0, 100, 100), backgroundPaint);

    if(playState==PlayState.playing){
      //画在中心
      canvas.drawCircle(Offset(width/2,width/2), radius, p);
      //画中心的方块
      drawsq(canvas);
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

      canvas.drawCircle(Offset(width/2,width/2), radius, stopingPaint);
      canvas.drawCircle(Offset(width/2,width/2), radius/2, stopingPaint1);
    }



  }
  int i=0;
  startAnima(Canvas canvas,Rect rect){
    canvas.save();
    canvas.translate(width/2, width/2);
//(width-2)缓解误差
    canvas.drawArc(Rect.fromCircle(center: Offset(0,0), radius: (width-2)/2),
        -90, (i) / 180 * pi, false, dynamicPainter);
    i+=5;
    if(i>=200){
      i=0;
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        sureCloseCallback();
      });
    }
    canvas.restore();
  }
  //画圆角矩形
  drawsq(Canvas canvas){
    double rRwidth=40;
    canvas.save();
    canvas.translate(width/2, width/2);
    // 调节中间矩形的大小

    // canvas.drawRRect(RRect.fromLTRBR(0, 0, 30, 30, Radius.circular(4)), pRRect);
    //内里的圆角
    canvas.drawRRect(RRect.fromRectXY(Rect.fromCircle(center: Offset(0,0), radius: 25), 8, 8), pRRect);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return true;
  }

}