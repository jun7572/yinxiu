import 'package:flutter/material.dart';
import 'package:yinxiu/screen_manager.dart';
import 'package:yinxiu/src/mypainter.dart';

class SmartWidget<T> extends StatefulWidget{
  List<T> list;
  SmartWidget(this.list);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SmartWidgetState();
  }
  
}
class SmartWidgetState extends State<SmartWidget> with TickerProviderStateMixin{
  GlobalKey key=GlobalKey();
  var animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 600));
     print("11111111");
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // RenderBox box =key.currentContext!.findRenderObject() as RenderBox;
        // Offset position = box.localToGlobal(Offset.zero); //this is global position
        // double y = position.dy;
        // print("=position=${position.toString()}");
        // print("=size=${box.size.toString()}");

        final NavigatorState navigator = Navigator.of(context);
        final RenderBox itemBox = context.findRenderObject()! as RenderBox;
        final Rect itemRect = itemBox.localToGlobal(Offset.zero, ancestor: navigator.context.findRenderObject()) & itemBox.size;
        _showItems(itemRect.bottomRight.dy);
      },
      child: Container(
        key: key,
        child: Text("text",style: TextStyle(fontSize: 30,color: Colors.black),),
      ),
      // child: CustomPaint(
      //   painter: MPatiner(),
      // ),
    );
  }
  _showItems(double y ){
    // Navigator.push(context, MyDropDownRoute(position));
    Navigator.push(context, PageRouteBuilder(
        transitionsBuilder: (_,anima,__,child){
        return SizeTransition(sizeFactor: animationController,child: child,);
        },
        opaque: false,
        pageBuilder: (_,__,___){
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(
                  top:y,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                height: 300,
                color: Colors.lightBlue,
              ))
            ],
          ),
        );
    }));
  }

}
class MyDropDownRoute extends PopupRoute{
  Offset startOffset;
  MyDropDownRoute(this.startOffset);
  @override
  // TODO: implement opaque
  bool get opaque => false;
  @override
  // TODO: implement barrierColor
  Color? get barrierColor => Color(0x11000000);

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible =>true;

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => "aaaaaa";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return CustomSingleChildLayout(delegate: MyDelegate(startOffset),child: Container(
      width: 100,height: 100,
      color: Colors.red,
    ),);
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(milliseconds: 500);

}
class MyDelegate extends SingleChildLayoutDelegate{
  Offset start;
  MyDelegate(this.start);
  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
   return true;
  }
  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return start;
  }
  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
    return Size(200, 200);
  }
  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(minHeight: 100,minWidth:100 );
  }

}