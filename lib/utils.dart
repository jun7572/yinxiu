

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:flutter/services.dart';
//这个地方你自己处理修改初始化
class Utils {
  final context;
  Utils({this.context}) :super();

  static double getWidth() {
    return  ui.window.physicalSize.width;
  }
  static double getlRatio () {
    return ui.window.devicePixelRatio;
  }
  static double getHeight() {
    return  ui.window.physicalSize.height;
  }
  static  late ByteData moon;
  static late ByteData circle;
  static late ByteData clock,start1,start2;
  //初始化资源加载,这个耗时
  static Future init()async{

    moon = await rootBundle.load("assets/moon.jpg");
    circle=await rootBundle.load("assets/circle.jpg");
    clock=await rootBundle.load("assets/clock.jpg");
    start1=await rootBundle.load("assets/start1.jpg");
    start2=await rootBundle.load("assets/start2.jpg");
  return  Future(()=>null);
}
  static Future<ui.Image> getImageMoon(int width,int height) async {

    Codec codec = await ui.instantiateImageCodec(moon.buffer.asUint8List(),targetWidth: width,targetHeight: height);
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
  //不使用第一帧


  //通过[Uint8List]获取图片
  Future<ui.Image> loadImageByUint8List(Uint8List list) async{
    ui.Codec codec= await ui.instantiateImageCodec(list);
    ui.FrameInfo frame= await codec.getNextFrame();
    return frame.image;
  }
  // //通过 文件读取Image
    Future<ui.Image> loadImageByFile(String path) async{
    var list =await File(path).readAsBytes();
    return loadImageByUint8List(list);
  }


  static Future<ui.Image> getImageCircle(int width,int height) async {

    Codec codec = await ui.instantiateImageCodec(circle.buffer.asUint8List(),targetWidth: width,targetHeight: height);
    var frameCount = codec.frameCount;
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
  static Future<ui.Image> getImageClock(int width,int height) async {

    Codec codec = await ui.instantiateImageCodec(clock.buffer.asUint8List(),targetWidth: width,targetHeight: height);
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
  //这个星星用Widget实现也好实现
  static Future<ui.Image> getImageStar1(int width,int height) async {

    Codec codec = await ui.instantiateImageCodec(start1.buffer.asUint8List(),targetWidth: width,targetHeight: height);
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
  static Future<ui.Image> getImageStar2(int width,int height) async {

    Codec codec = await ui.instantiateImageCodec(start2.buffer.asUint8List(),targetWidth: width,targetHeight: height);
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
                                            //返回整个信息,不是一帧
             static    Future<ImageInfo> getImageInfo(BuildContext context) async {
                  AssetImage assetImage = AssetImage("assets/moon.jpg");
                  ImageStream stream = assetImage.resolve(createLocalImageConfiguration(context));
                  Completer<ImageInfo> completer = Completer();
                  stream.addListener(ImageStreamListener((imageInfo,__){
                    return completer.complete(imageInfo);
                  }));
                   return completer.future;

             }
                     static    Future<ImageInfo> getImageStar1Info(BuildContext context) async {
                               AssetImage assetImage = AssetImage("assets/start1.jpg");
                               ImageStream stream = assetImage.resolve(createLocalImageConfiguration(context));
                               Completer<ImageInfo> completer = Completer();
                               stream.addListener(ImageStreamListener((imageInfo,__){
                                 return completer.complete(imageInfo);
                               }));
                                return completer.future;

                          }



                                 static    Future<ImageInfo> getImageStar2Info(BuildContext context) async {
                                           AssetImage assetImage = AssetImage("assets/start2.jpg");
                                           ImageStream stream = assetImage.resolve(createLocalImageConfiguration(context));
                                           Completer<ImageInfo> completer = Completer();
                                           stream.addListener(ImageStreamListener((imageInfo,__){
                                             return completer.complete(imageInfo);
                                           }));
                                            return completer.future;

                                      }


}
class CanvasOffset extends Offset {
  const CanvasOffset(double width, double height) : super(width, height) ;
}
