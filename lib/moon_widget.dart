import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yinxiu/MyZkApp.dart';
import 'package:yinxiu/utils.dart';

import 'moon.dart';
import 'moon_painter.dart';
//锚点?
class MoonWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MoonWidgetState();
  }
  
}
class MoonWidgetState extends State<MoonWidget>{


  List<Moon> list=[];
  final int moonNum=15;
  initData()async{




    Timer.periodic(Duration(milliseconds: 25), (timer) {
      setState(() {

      });

    });
    Timer.periodic(Duration(milliseconds: 200), (timer) async{
      if(list.length<moonNum){
        Moon moon= Moon();
          await moon.init();
          list.add(moon);
      }else{
        timer.cancel();
      }
    });


    setState(() {

    });



  }
  late MoonPainter mp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();



  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body:SizedBox(
        height: 200,

        child: CustomPaint(

          painter: MoonPainter(list),
        ),
      ),

    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();



  }
  
}