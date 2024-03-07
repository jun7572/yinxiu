import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:yinxiu/star.dart';
import 'package:yinxiu/star_painter.dart';
import 'package:yinxiu/utils.dart';

class StarWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StarWidgetState();
  }
  
}
class StarWidgetState extends State<StarWidget>{
  bool loaded=false;
  @override
  void initState() {

    initData();
  }

  List<Star> list=[];
  final int starNum=15;
  bool checkState=false;
  initData()async{
   await Utils.getImageStar1(105, 105);
   await Utils.getImageStar2(116, 116);
   loaded=true;
   Timer.periodic(Duration(milliseconds: 25), (timer) {
      if(checkState){
        int numm=0;
        for(Star s in list){
            if(s.state==1){
              numm++;
            }
        }
        //
        if(numm==starNum){
          print("星星动画完成");

          BotToast.showText(text:"星星动画完成");
          timer.cancel();
        }
      }
     setState(() {

     });

   });
   Timer.periodic(Duration(milliseconds: 300), (timer) async{
     if(list.length<starNum){
       Star star= Star();
       await star.init();
       list.add(star);
     }else{
       //添加完成之后开始检查运动状态
       checkState=true;
       timer.cancel();
     }
   });


   setState(() {

   });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: loaded?Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        height: 300,
        child: CustomPaint(
          painter: StartPainter(list),
        ),
      ):Text("loading"),
    );
  }
  
}