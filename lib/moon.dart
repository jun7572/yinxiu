import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as UI;
import 'package:yinxiu/utils.dart';

import 'main.dart';

class Moon{
  //图片大小
  final int picWidth=72;
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


  // late UI.Image image;
  late ImageInfo imageInfo;

  Future  init()async{
    imageInfo = await Utils.getImageInfo(MyApp.globalKey.currentContext!);
    reload();

      // image = await Utils.getImageMoon(72, 72);
    }
    reload()async{
    //设定初始点
    //   image = await Utils.getImageMoon(72*scale.toInt(), 72*scale.toInt());
      p=Paint();
      position=Offset(rightSide/2,rightSide/1);
      speedY=Random().nextInt(1).toDouble()-2;
      speedX=Random().nextInt(4).toDouble()-2;
      changeSpeedX=Random().nextInt(4).toDouble()-2;
      changeSpeedY=Random().nextInt(2).toDouble()-1;
      scale=Random().nextInt(5)+1;
       int dd=Random().nextInt(30)+30;
       //获取图片

      //改变大小  //通过矩阵的话就不用下次再去加载图片
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
    // paintImage(canvas: canvas, rect: Rect.fromLTWH(position.dx, position.dy, (position.dx+imageInfo.image.width)/scale, (position.dy+imageInfo.image.height)/scale), image: imageInfo.image);
    paintImage(canvas: canvas, rect: Rect.fromPoints(Offset(position.dx, position.dy),Offset( position.dx+(imageInfo.image.width/scale), position.dy+(imageInfo.image.height/scale))), image: imageInfo.image);

    //看轨迹
    // canvas.drawCircle(position, 5, p1);
    //查看初始点
    // canvas.drawCircle(Offset(100,200), 10, p1);

    position=Offset(position.dx+speedX+changeSpeedX,position.dy+speedY+changeSpeedY);



    if(position.dx<leftSide||position.dx>rightSide){
      changeSpeedX=-changeSpeedX;
      speedX=-speedX;
    }

    if(position.dy<0){
      await reload();
    }


  }

}