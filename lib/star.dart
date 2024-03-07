import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yinxiu/main.dart';
import 'dart:ui' as UI;
import 'package:yinxiu/utils.dart';

class Star{
  //图片大小
  final int pic1Width=105;
  final int pic2Width=116;
  //这么个矩形,不超出这个矩形
  final int leftSide=0;
  final int rightSide=200;
  late Offset position;


  //速度
  late double speedX;
  late double speedY;
  late double changeSpeedX;
  late double changeSpeedY;
  late double scale;
  late int transition;
  //停止运动的高度
  late int stopHeight;

  late ImageInfo image;
  //简单设定一个状态,用枚举也行
  int state=0;

  Future  init()async{
    int dd=Random().nextInt(2);
    if(dd==1){
      image = await Utils.getImageStar1Info(MyApp.globalKey.currentContext!);
    }else{
      image =await Utils.getImageStar2Info(MyApp.globalKey.currentContext!);
    }
    reload();

      // image = await Utils.getImageMoon(72, 72);
    }


    reload()async{
    //设定初始点
    //   image = await Utils.getImageMoon(72*scale.toInt(), 72*scale.toInt());
      p=Paint();
      position=Offset(rightSide/2,0);
      speedY=Random().nextInt(1).toDouble()+3;
      speedX=Random().nextInt(4).toDouble()-2;
      changeSpeedX=Random().nextInt(4).toDouble()-2;
      changeSpeedY=Random().nextInt(2).toDouble()-1;
        // 停止的高度 总共300的高
      stopHeight= Random().nextInt(150)+100;
      // scale=Random().nextDouble();




      //改变大小
      // var matrix4 = Matrix4.translationValues(0,0,0);
      // matrix4.scale(scale,scale,0);

      transition=Random().nextInt(255);
      p.colorFilter=UI.ColorFilter.mode(UI.Color.fromARGB(transition, 0, 0, 0), UI.BlendMode.dstIn);
      p.isAntiAlias=true;

      // p.imageFilter=UI.ImageFilter.matrix(matrix4.storage,filterQuality: FilterQuality.high);

    }
  Paint p=Paint();
  //看轨迹
  Paint p1=Paint();
  void paint(Canvas canvas, Size size) async{

    // canvas.drawImage(image, position, p);
    paintImage(canvas: canvas, rect: Rect.fromPoints(Offset(position.dx, position.dy),Offset( position.dx+(image.image.width), position.dy+(image.image.height))), image: image.image);
    //看轨迹
    // canvas.drawCircle(position, 5, p1);
    //查看初始点
    // canvas.drawCircle(Offset(100,200), 10, p1);

    position=Offset(position.dx+speedX+changeSpeedX,position.dy+speedY-changeSpeedY);



    if(position.dx<leftSide||position.dy>rightSide){
      changeSpeedX=-changeSpeedX;
      speedX=-speedX;
    }

    if(position.dy>=stopHeight){
      // await reload();
      speedY=0;
      speedX=0;
      changeSpeedX=0;
      changeSpeedY=0;
      state=1;
    }




  }

}