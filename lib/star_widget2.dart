import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:yinxiu/src/star2.dart';
import 'package:yinxiu/src/star_painter2.dart';
import 'package:yinxiu/star.dart';
import 'package:yinxiu/star_painter.dart';
import 'package:yinxiu/utils.dart';

class StarWidget2 extends StatefulWidget{
  //星星数
  int starNum;
  StarWidget2(this.starNum);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StarWidgetState2();
  }
  
}
class StarWidgetState2 extends State<StarWidget2>{
  bool loaded=false;
  @override
  void initState() {

    initData();
  }

  List<Star2> list=[];

  bool checkState=false;
  initData()async{
   await Utils.getImageStar1(105, 105);
   await Utils.getImageStar2(116, 116);
   loaded=true;

  for(int i=0;i<widget.starNum;i++){
    //这个200是边框大小
    Star2 star= Star2(200);
    await star.initWithPosition();
    list.add(star);
  }
   Timer.periodic(Duration(milliseconds: 50), (timer) {
     // if(checkState){
     //   int numm=0;
     //   for(Star2 s in list){
     //     if(s.state==1){
     //       numm++;
     //     }
     //   }
       //

     // }
     setState(() {

     });

   });



   setState(() {

   });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: loaded?Container(
        width: 500,
        color: Colors.black,
        height: 500,
        child: CustomPaint(
          painter: StartPainter2(list),
        ),
      ):Text("loading"),
    );
  }
  
}