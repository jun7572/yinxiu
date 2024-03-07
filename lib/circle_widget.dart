import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'utils.dart';

import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
typedef CallBack1 =Function(double b);
typedef CallBack2 =Function(Offset offset);
enum DragState{
  draging,
  undrag
}
//感觉flutter在这种精细的拖拽识别不是很放得开
enum DragMode{
  onHorizontalDragUpdate,
  onVerticalDragUpdate,
  none,
}
class CircleProgressWidget extends StatefulWidget {
  final Progress progress;
  final CallBack1 fn;
  const CircleProgressWidget( this.progress,this.fn,{Key? key,}) : super(key: key);

  @override
  _CircleProgressWidgetState createState() => _CircleProgressWidgetState();
}



class Progress {
   double value;
   double startAng;
   double startSweepAng;
   Color color;
   Color backgroundColor;
   double radius;
   double strokeWidth;
   int dotCount;
    TextStyle style;
   String completeText;


  Progress(

   {this.value=0,
     this.startSweepAng=0,
     this.startAng=0,
        this.color=Colors.black,
        this.backgroundColor=Colors.black,
        this.radius=1,
        this.strokeWidth=1,
        this.completeText = "OK",
        this.style=const TextStyle(),
        this.dotCount = 40});
}

class _CircleProgressWidgetState extends State<CircleProgressWidget> {
  final int padding=10;

  bool loaded=false;
  DragMode dragmode=DragMode.none;
  @override
  void initState() {
    super.initState();
    initData();
  }
  //加载的图片
  late ui.Image imageCircle,moon,clock;
  //图片的宽
  final int imageWidget=30;
  late ImageInfo imageInfo;
  initData()async{
    // await Utils.init();
    int size=widget.progress.strokeWidth.toInt();

      imageCircle = await Utils.getImageCircle(imageWidget, imageWidget);
       imageInfo =await Utils.getImageInfo(MyApp.globalKey.currentContext!);
     moon = await Utils.getImageMoon(imageWidget, imageWidget);
     //根据进度条的半径减去笔触的宽度得出里面时钟的大小
     double wid=widget.progress.radius*2-widget.progress.strokeWidth*2;
     clock = await Utils.getImageClock(wid.toInt(), wid.toInt());
     loaded=true;
     setState(() {

     });

  }
  //手势操作变化的角度
  double changeAng=0;
  //触点
  Offset touchoffSct=Offset(0, 0);
  Offset circleoffSct=Offset(0, 0);
  DragState dragState=DragState.undrag;
  bool changeCanvas=false;
  @override
  Widget build(BuildContext context) {

    String txt = "${(100 * widget.progress.value).toStringAsFixed(1)} %";
    var text = Text(
      widget.progress.value == 1.0 ? widget.progress.completeText : txt,
      style: widget.progress.style
          // TextStyle(fontSize: widget.progress.radius / 6),
    );
    return loaded? Stack(
      alignment: Alignment.center,
      children: <Widget>[
        //算是屏幕事件监听
        NotificationListener<ScrollNotification>(
          onNotification: (noti){
            //不消费

            return false;
          },
          child: GestureDetector(
                //必须横竖一起写不然有些区域不灵敏
              onHorizontalDragUpdate: (DragUpdateDetails details){
                dragmode=DragMode.onHorizontalDragUpdate;
                setChangeAng(details);
              },
              onVerticalDragUpdate: (DragUpdateDetails details){

                dragmode=DragMode.onVerticalDragUpdate;
               setChangeAng(details);
              },
              onVerticalDragEnd: (DragEndDetails details){
                if(dragmode==DragMode.onVerticalDragUpdate){
                  changeCanvas=false;
                }
                touchoffSct=Offset.zero;

              },
              onHorizontalDragEnd: (DragEndDetails detail){
                if(dragmode==DragMode.onHorizontalDragUpdate){
                  changeCanvas=false;
                }
              },
              onHorizontalDragCancel: (){
                if(dragmode==DragMode.onHorizontalDragUpdate){
                  changeCanvas=false;
                }
                touchoffSct=Offset.zero;
              },
              onVerticalDragCancel: (){
                if(dragmode==DragMode.onVerticalDragUpdate){
                  changeCanvas=false;
                }

              },

              onTapDown: (TapDownDetails details){
                var dd = drawOrNot(details.localPosition,circleoffSct);
                if(dd){
                  dragmode=DragMode.none;
                  changeCanvas=true;
                }
              },
              // onTapUp: (TapUpDetails details){
              //   print("onTapUp");
              // },


              child: Container(
                color: Colors.blue,
                width: widget.progress.radius * 2,
                height: widget.progress.radius * 2,
                child: CustomPaint(
                  painter: ProgressPainter(widget.progress,imageCircle,moon,changeAng,clock,widget.fn,touchoffSct,dragState,(offset){
                    // print("小点坐标="+offset.toString());
                    circleoffSct=offset;
                  },imageInfo),

                ),
              )),
        ),
        text,
        Container(
          width: clock.width.toDouble(),
          height: clock.width.toDouble(),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Image.asset("assets/clock.jpg"),

        ),
      ],
    ):const Center(child: Text("loading"),);
  }
  bool drawOrNot(Offset touchPoint,Offset smallCircle){
    //点到圆心的距离要小于圆的半径
    // double d= ((smallCircle.dx-touchPoint.dx)*(smallCircle.dx-touchPoint.dx))+((smallCircle.dy-touchPoint.dy)*(smallCircle.dy-touchPoint.dy));

    num dis=math.sqrt(math.pow(smallCircle.dx-touchPoint.dx, 2)+math.pow(smallCircle.dx-touchPoint.dx, 2));
    print("----------------");
    print("点击的坐标="+touchPoint.toString());
    print("圆心的坐标="+smallCircle.toString());

    print("点到圆心距离="+dis.toString());
    print("圆心半径="+(imageCircle.width/2).toString());
    print("----------------");
    if(dis<(imageCircle.width/2)){
      print("okkkkkkkkkkk");
      return true;
    }
    // math.pow(x, exponent)
    return false;
  }
  //用于  设置变换的角度
  setChangeAng(DragUpdateDetails details){

    double dx = details.localPosition.dx;
    double dy = details.localPosition.dy;
    //计算落点手势滑动之后与圆心的角度
    var originalD = atan2(dx-widget.progress.radius,dy-widget.progress.radius)*(180/pi);
    // print("角度=${d}");

    //旋转手滑动的坐标轴
    double d=originalD-90;
    touchoffSct=Offset(dx,dy);
    //求的是划过的弧度 不用加上初始sweep,画图的时候加上了
    double ddd=widget.progress.startSweepAng-widget.progress.startAng;
    // print("d======${d}");
    // print("角度=${d}");
    print("originalD=${originalD}");
    // print("初始角度差=${ddd}");
    //第一象限

      //开始角度在第一象限
      if(90>widget.progress.startAng&&widget.progress.startAng>=0){


        if(originalD<=0){
            changeAng=(90-widget.progress.startAng)+originalD.abs()-widget.progress.startSweepAng;
        }else{
          if(originalD.abs()<(widget.progress.startAng-90)){
            changeAng=90-originalD-widget.progress.startAng-widget.progress.startSweepAng;
          }else{
            changeAng=(90-widget.progress.startAng)+180+(180-originalD)-widget.progress.startSweepAng;
          }

        }

      }

    //开始角度在第2象限
      if(180>widget.progress.startAng&&widget.progress.startAng>=90){
        //减去widget.progress.startSweepAng是为了减去绘制的初始值
        if(originalD<=0){

          //widget.progress.startAng
          if(originalD.abs()<=(widget.progress.startAng-90)){
            changeAng=(270-widget.progress.startAng)+180+originalD.abs()-widget.progress.startSweepAng;
          }else{
            changeAng=d.abs()-widget.progress.startSweepAng-90-(90-(180-widget.progress.startAng));
          }

        }else{
           changeAng= (270-widget.progress.startAng)+(180-originalD)-widget.progress.startSweepAng;
        }

      }
    //开始角度在第2象限
    if(270>widget.progress.startAng&&widget.progress.startAng>=180){
        if(originalD<=0){

          if(originalD.abs()<=(widget.progress.startAng-90)){
            changeAng=(270-widget.progress.startAng)+180+originalD.abs()-widget.progress.startSweepAng;
          }else{
            changeAng=d.abs()-180-(widget.progress.startAng-180)-widget.progress.startSweepAng;
          }
        }else{
          changeAng=(270-widget.progress.startAng)+(180-originalD)-widget.progress.startSweepAng;
        }
    }
    //第四象限
    if(360>widget.progress.startAng&&widget.progress.startAng>=270){
        if(originalD<=0){
          changeAng=(180-(widget.progress.startAng-270))+originalD.abs()-widget.progress.startSweepAng;
        }else{
          if(originalD>(180-(widget.progress.startAng-270))){
            changeAng=(180-(widget.progress.startAng-270))+180+(180-originalD)-widget.progress.startSweepAng;
          }else{
            changeAng=180-originalD-(widget.progress.startAng-270)-widget.progress.startSweepAng;
          }

        }
    }








    // print("changeAng=${changeAng}");


      if(changeCanvas){
        setState(() {

        });
      }

    // print("dd="+d.toString());
  }

}

class ProgressPainter extends CustomPainter {
  late Progress _progress;
  late Paint _paint;
 late Paint _arrowPaint;
  late Path _arrowPath;
  late double _radius;
  //滑动的小圆
  late ui.Image _image;
  late ui.Image moonImg;
  late ui.Image clock;
  late double _changeAng;
  //修正笔触照成的误差,这个误差是由于图片圆的大小跟整个控件中心的夹角照成的,这个角度大概15-20度.
 final int circleAng=15;
 //只有在小圆的范围才互动生效
  final Offset touchPoint;
  //小圆坐标
   Offset smallCircle=Offset.zero;
//----------------------------------------------j决定起点
  //开始的角度,你自己把这个参数放出去就行


  CallBack1 fn;
  CallBack2 offsetFn;
  DragState dragState;
  ImageInfo imageInfo;
  ProgressPainter(
      this._progress,
      this._image,
      this.moonImg,
      this._changeAng,
      this.clock,
      this.fn,
      this.touchPoint,
      this.dragState,
      this.offsetFn,
      this.imageInfo,
      ) {
    _arrowPath = Path();
    _arrowPaint = Paint();
    _paint = Paint();
    _radius = _progress.radius - _progress.strokeWidth / 2;

  }
  Paint p1=Paint();

  @override
  void paint(Canvas canvas, Size size) {
    // if(touchPoint==Offset.zero||drawOrNot()){
    //
    // }else{
    //   return;
    // }

    Rect rect = Offset.zero & size;
    canvas.clipRect(rect); //裁剪区域
    canvas.translate(_progress.strokeWidth / 2, _progress.strokeWidth / 2);


     _drawProgress(canvas);
     _drawImgCircle(canvas);

    _drawMoon(canvas);
    //有点模糊就不用这个了
    // _drawClock(canvas);
    _drawTwoCircleborder(canvas);

  }
  //要知道当前的环上的小圆的坐标


  _drawTwoCircleborder(Canvas canvas){
    p1.color=Color(0xaaffffff);
    canvas.save();
    canvas.translate(_radius, _radius);
    //小圆
    canvas.drawCircle(Offset(0,0),clock.width/2, p1);
    canvas.drawCircle(Offset(0,0),_progress.radius, p1);
    canvas.restore();
  }
  _drawClock(Canvas canvas){
    canvas.save();
    canvas.translate(_radius, _radius);
    canvas.drawImage(clock,Offset(-clock.width/2,-clock.width/2), p1);
    canvas.restore();
  }

  _drawImgCircle(Canvas canvas){
    p1.color=Colors.white;
    p1.strokeWidth=0.5;
    p1.style=PaintingStyle.stroke;
    p1.isAntiAlias=true;
    p1.filterQuality=FilterQuality.high;
    // p.imageFilter=ui.ImageFilter.matrix(filterQuality: FilterQuality.high);
    //需要绘制的角度//注意这里跟下面的_changeAng同时改变
    // double sweepAngle = _progress.value * 360+startAng-_changeAng-(startAng+circleAng);
    double sweepAngle = _progress.startSweepAng+_progress.startAng +_changeAng;
    //半径减去笔触的宽度
    double tempRadius=_progress.radius-15;
    //小圆的坐标
    double x=tempRadius*cos( sweepAngle / 180 * pi)+tempRadius-_image.width/2;
    double y=tempRadius*sin( sweepAngle / 180 * pi)+tempRadius-_image.width/2;
    // var dd = drawOrNot();

    // print("变化的圆坐标=="+Offset(x,y).toString());
    canvas.drawImage(_image,Offset(x,y), p1);
    canvas.drawCircle(Offset(x+_image.width/2,y+_image.width/2),4, p1);//查看坐标点
    //偏移中心点坐标,偏移笔触的一半,和图片的一半
        offsetFn(Offset(x+(_image.width/2)+(_progress.strokeWidth/2),y+(_image.width/2)+(_progress.strokeWidth/2)));
  }
  _drawMoon(Canvas canvas){
    double sweepAngle = _progress.startAng;
    //半径减去笔触的宽度
    double tempRadius=_progress.radius-15;
    //月亮的坐标
    double x=tempRadius*cos( sweepAngle / 180 * pi)+tempRadius-_image.width/2;
    double y=tempRadius*sin( sweepAngle / 180 * pi)+tempRadius-_image.width/2;
    //图片是72,30是笔触 72/30=2.4
    // canvas.drawImage(moonImg,Offset(x,y), p1);
    paintImage(canvas: canvas, rect: Rect.fromLTWH(x, y, imageInfo.image.width/2.4, imageInfo.image.height/2.4), image: imageInfo.image);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  _drawProgress(Canvas canvas) {
    // canvas.save();
    _paint//背景
      ..style = PaintingStyle.stroke
      ..color = _progress.backgroundColor
      ..strokeWidth = _progress.strokeWidth;
    canvas.drawCircle(Offset(_radius, _radius), _radius, _paint);

    _paint//进度
      ..color = _progress.color
      ..strokeWidth = _progress.strokeWidth
      ..strokeCap = StrokeCap.round;
    //初始值设定的一个角度差
    // double sweepAngle = _progress.value * 360; //完成角度
    double sweepAngle = _progress.startSweepAng; //开始的时候略过的角度

    // print(sweepAngle.toString());
    // print((sweepAngle-_changeAng-(startAng.abs()-90+circleAng)).toString());
    // print("改变的角度===${-_changeAng}");
    //改变的角度
    double a1=(sweepAngle+_changeAng);



      // print("aaa==${a1}");
    a1=(a1<360)?a1:(a1%360);
    //回调进度,这个方法你自己看看回调到哪
    // print("(a1) / 180 * pi==${(a1)}");
    fn(a1/360);
    canvas.drawArc(Rect.fromLTRB(0, 0, _radius * 2, _radius * 2),
        _progress.startAng / 180 * pi, (a1) / 180 * pi, false, _paint);
    // canvas.drawArc(Rect.fromLTRB(0, 0, _radius * 2, _radius * 2),
    //     startAng / 180 * pi, sweepAngle / 180 * pi, false, _paint);

    // canvas.restore();
  }


}
