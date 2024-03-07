import 'package:flutter/material.dart';
import 'package:yinxiu/stop_button_sq_painter.dart';
import 'package:yinxiu/stop_button_sq_painter2.dart';

class StopWidget2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StopWidgetState2();
  }
  
}
class StopWidgetState2 extends State<StopWidget2>{
  final String start="开始";
  final String stop="结束";
  //默认开始
  String str="开始";
  ClickState clickState=ClickState.unclick;
  //按钮状态
  PlayState playState=PlayState.stoping;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
          //注意这个宽高跟里面绘制的配合,如果是适配屏幕的就传适配屏幕的尺寸
          child: Stack(
            children: [
              Center(
                child: Container(
                  color: Colors.blue,
                  width: 120,
                  height: 50,
                  child: GestureDetector(
                    onTap: (){
                        if(playState==PlayState.stoping){
                          print("------");
                          playState=PlayState.playing;
                          str=stop;
                          setState(() {

                          });
                        }
                    },
                    onLongPressUp: (){
                      //取消
                      clickState=ClickState.unclick;
                      setState(() {

                      });
                    },
                    onLongPress: (){
                      clickState=ClickState.clicking;
                      setState(() {

                      });
                    },

                    child: CustomPaint(
                      painter: StopButtonPatinter2(clickState,playState,(){
                        playState=PlayState.stoping;
                        str=start;
                        setState(() {

                        });
                      }),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(str,style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
    );
  }
  
}