// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:yinxiu/screen_manager.dart';
// import 'package:zerker/zerker.dart';
// import 'dart:ui' as UI;
//
// import 'ZMoon.dart';
// class MyZkApp extends ZKApp{
//   late ZKScene _scene;
//   bool _loaded=false;
//   int startRotate=0;
//
//
//   @override
//   init() {
//     stage.color = Color(0x66666666);
//     _preload();
//
//
//   }
//   void _preload() {
//     Map<String, dynamic> urls = {
//
//       "moon": "assets/moon.jpg",
//
//
//     };
//
//     ZKAssets.preload(
//         baseUrl: "assets/",
//         urls: urls,
//         onProgress: (scale) {
//           print("Assets loading ${scale * 100}%");
//         },
//         onLoad: () {
//           _initScene();
//           _loaded=true;
//           print("Assets load Complete");
//         });
//   }
//
//
//   late ZKScene zKScene;
//   _initScene(){
//     zKScene= new ZKScene();
// //    stage.addChild();
//     for(int i=0;i<50;i++){
//       gen();
//     }
//     stage.addChild(zKScene);
//     var paint = new Paint();
//     paint.colorFilter=UI.ColorFilter.mode(UI.Color.fromARGB(255,255, 255, 0), UI.BlendMode.modulate);
//
//     ZKImage star_light=ZKImage("moon");
//     star_light.paint=paint;
//     star_light.setScale(0.8);
//     star_light.setPosition(getWp(size.width/2), getHp(size.height-100));
//
// //    ZKTween(star_light).to({"x":size.width,"y":0})
//     stage.addChild(star_light);
//
//
//
//
//   }
//
//   @override
//   update(int time) {
//     if (!_loaded) return;
//
//
//     super.update(time);
//   }
//   gen(){
//     // var nextInt = Random().nextInt(4);
//
//
//       zKScene.addChild(ZMoon(Random().nextDouble()*size.width,size.height,size.width).moon);
//
//
//
//   }
//   @override
//   void dispose() {
//     super.dispose();
//
//     ZKBus.off("SHOW");
//   }
// }