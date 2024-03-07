import 'package:flutter/material.dart';
import 'package:yinxiu/smart_widget.dart';

class TestWidgetPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestWidgetPageState();
  }
  
}
class TestWidgetPageState extends State<TestWidgetPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          SizedBox(height: 100,),

          Container(width: 300 ,height: 300,color: Colors.blue,),
          SmartWidget([]),
        ],
      ),
    );
  }
  
}