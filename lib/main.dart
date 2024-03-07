import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:yinxiu/moon_painter.dart';
import 'package:yinxiu/progress_border_button.dart';
import 'package:yinxiu/src/test_widget_page.dart';
import 'package:yinxiu/star_widget.dart';
import 'package:yinxiu/star_widget2.dart';
import 'package:yinxiu/stop_widget2.dart';
import 'package:yinxiu/utils.dart';

import 'circle_widget.dart';
import 'moon.dart';
import 'moon_widget.dart';
import 'stop_widget.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Utils.init();
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static  GlobalKey globalKey= GlobalKey();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: globalKey,
      title: 'Flutter Demo',
        builder: BotToastInit(), //1. call BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //里面有宽高的初始化的值
      home:  Container(
          height: 400,
          width: 400,
          // child: StarWidget2(100)),
          // child: MyHomePage(title: "aa",)),
          child: TestWidgetPage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
    _progressButtonKey = GlobalKey();

  }
  late GlobalKey _progressButtonKey;
  String ss="";
  initData()async{
    //必须等资源加载完
    // await Utils.init();
    isloadedIMG=true;
    setState(() {

    });
  }
  bool isloadedIMG=false;
  String str="结束";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:ListView(
        children: [
          isloadedIMG?Column(
            children: [
              // Container(
              //     height: 300,
              //     child: MoonWidget()),

              Container(
                //高度要跟里面匹配
                height: 200,
                child: CircleProgressWidget(Progress(value:0.8,startSweepAng:225,startAng:80,color: Color(0x88ffffff),radius: 100,strokeWidth: 30,
                    style: TextStyle( color: Colors.red,),
                    //返回的百分比
                    backgroundColor:Colors.transparent),(percent){

                    // print("percent===$percent");
                }),
              ),

              Container(
                  height: 100,
                  width: 100,
                  child: StopWidget()),
              Container(
                  height: 100,
                  child: StopWidget2()),
              Text("长按"),
              Container(
                color: Colors.blue,
                child: ProgressBorderButton(
                  key: _progressButtonKey,
                  hasRadius: true,
                  onTimeEnd: () {
                    str="开始";
                    print("okkkkkk");
                    setState(() {

                    });

                }, borderColor: Colors.white,
                  strokeWidth: 1,
                  duration: 5,
                  childBuild: (BuildContext context, double progress) {
                              return GestureDetector(
                                onLongPress: (){
                                  _start();
                                  str="结束";
                                  setState(() {

                                  });
                                },
                               onLongPressUp: (){
                                 _stop();
                               },
                                child: Container(

                                  width: 104,
                                  height: 48,
                                  child: Center(child: Text(str,style: TextStyle(color:Colors.white),),),

                                ),
                              );
                },
                  size:const Size(120,50),),
              ),


              Container(
                  height: 300,
                  child: StarWidget()),
            ],
          ):const Center(child: Text("loading",style: TextStyle(color: Colors.white),),),
        ],
      ),
      // body: Image.asset("assets/moon.jpg"),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void _start() {
    ProgressBorderButtonState progressBorderButtonState = _progressButtonKey.currentState as ProgressBorderButtonState;
    progressBorderButtonState.start();

  }
  void _stop() {
    ProgressBorderButtonState progressBorderButtonState = _progressButtonKey.currentState as ProgressBorderButtonState;
    progressBorderButtonState.stop();

  }
}
