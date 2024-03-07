import 'package:flutter/material.dart';
import 'package:yinxiu/stop_button_sq_painter.dart';

class StopWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StopWidgetState();
  }
  
}
class StopWidgetState extends State<StopWidget>{
  ClickState clickState=ClickState.unclick;
  //按钮状态
  PlayState playState=PlayState.stoping;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: GestureDetector(
              onTap: (){
                  if(playState==PlayState.stoping){
                    playState=PlayState.playing;
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

              child: Stack(
                children: [

                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("assets/aaa.jpeg"),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CustomPaint(

                      painter: StopButtonPatinter(clickState,playState,(){
                        playState=PlayState.stoping;
                        setState(() {

                        });
                      }),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
    );
  }
  
}