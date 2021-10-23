import 'package:flutter/material.dart';

class Animate extends StatefulWidget {
  @override
  _AnimateState createState() => _AnimateState();
}
class _AnimateState extends State<Animate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AinimateBuilder'),),
      body:ScaleAnimationRoute(),
    );
  }
}

class AnimatedLogo extends AnimatedWidget{
  AnimatedLogo({Key? key,required Animation<double> animation}) : super(key:key,listenable: animation);
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin:  EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

class GrowTransiton extends StatelessWidget {
  GrowTransiton({this.child,required this.animation});
  final Widget? child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: animation,
      builder: (context,child)=>Center(
        child: Container(
          width: animation.value,
          height: animation.value,
          child: child,
        ),
      ),
      child: child,);
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}
//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    //使用弹性曲线
    animation=CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    animation = Tween<double>(begin: 0.0, end: 300.0).animate(animation);
    //启动动画
    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return GrowTransiton(animation: animation,child: FlutterLogo(),);
    // return AnimatedLogo(animation: animation,); //方法二 效果一样
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
