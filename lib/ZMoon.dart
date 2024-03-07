// import 'dart:math';
// import 'dart:ui' as UI;
// import 'dart:ui';
//
// import 'package:zerker/zerker.dart';
//
// class ZMoon {
//  late ZKImage moon;
//   double toPositionY=0;
//
//   int Rcolor=0;
//   int Gcolor=0;
//   int Bcolor=0;
//
//  ZMoon(double initX,double toPositionY,double windowX){
//     Rcolor=Random().nextInt(255);
//     Gcolor=Random().nextInt(255);
//     Bcolor=Random().nextInt(255);
//
//     this.toPositionY=toPositionY;
//     var paint = new Paint();
//     var nextDouble = Random().nextInt(50).toDouble()/100;
//     paint.colorFilter=UI.ColorFilter.mode(UI.Color.fromARGB(255, Rcolor, Gcolor, Bcolor), UI.BlendMode.srcATop);
//     moon = ZKImage("moon");
//     moon.setPosition(initX, -Random().nextDouble()*1000);
//     moon.setScale(0.2);
//     moon.rotation=0.5;
//     moon.paint=paint;
//     ZKTween(moon).to({"x": Random().nextInt(windowX.toInt()), "y":toPositionY,"rotation":Random().nextInt(200)+160},  Random().nextInt(2000)+3000).easing(Ease.linear.easeOut).start().onComplete((d){
//       moon.dispose();
//     });
//
//   }
//
//
// }