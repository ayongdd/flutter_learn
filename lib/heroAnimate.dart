import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HeroAnimate extends StatefulWidget {
  @override
  _HeroAnimateState createState() => _HeroAnimateState();
}

class _HeroAnimateState extends State<HeroAnimate> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:RadialExpansionDemo());
  }
}

class Photo extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double? width;

  const Photo({Key? key,required this.photo,required this.onTap,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25), //设置透明度为0.25的主题
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(builder: (context,size) {
          return Image.network(photo,fit:BoxFit.contain);
        },),
      ),
    );
  }
}
class RadiaExpansion extends StatelessWidget {
  final double maxRadius;
  final clipRectSize;
  final Widget child;

  const RadiaExpansion({Key? key, required this.maxRadius, required  this.child}) :clipRectSize = 2.0*(maxRadius/math.sqrt2),super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}
class RadialExpansionDemo extends StatelessWidget {
  static const double KMinRadius = 32.0;
  static const double KMaxRadius = 128.0;
  static const opacityCurve = const Interval(0.0, 0.75,curve: Curves.fastOutSlowIn);
  static RectTween _createRectTween(begin,end) {
    return MaterialRectCenterArcTween(begin: begin,end: end);
  }
  static Widget _buildPage(BuildContext context,String imageName,String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: KMaxRadius*2,
                height: KMaxRadius*2,
                child:Hero(
                    createRectTween: _createRectTween,
                    tag: imageName,
                    child: RadiaExpansion(
                      maxRadius: KMaxRadius,
                      child:Photo(
                        photo: imageName,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                )
              ),
              Text(
                description,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(height: 16,)
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildHero(BuildContext context,String imageName,String description) {
    return Container(
      width: KMinRadius*2,
      height: KMinRadius*2,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageName,
        child: RadiaExpansion(
          maxRadius: KMaxRadius,
          child: Photo(
             photo: imageName,
             onTap: () {
               Navigator.of(context).push(
                 PageRouteBuilder<void>(pageBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
                   return AnimatedBuilder(animation: animation, builder: (context,child){
                     return Opacity(opacity: opacityCurve.transform(animation.value),
                         child:_buildPage(context, imageName, description),);
                   });
                 }),
               );
             },
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    const timeDilation = 5.0;
    // timeDilation = 5.0;
    return Scaffold(
      appBar: AppBar(title:const Text('Radial Transition Demo')),
      body:Container(
        padding: EdgeInsets.all(32),
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildHero(context, 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic15.nipic.com%2F20110708%2F3388327_164155701127_2.jpg&refer=http%3A%2F%2Fpic15.nipic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635399108&t=bf5fb7a6a8085381992efaecface732a', '图片1'),
            _buildHero(context, 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic15.nipic.com%2F20110708%2F3388327_164155701127_2.jpg&refer=http%3A%2F%2Fpic15.nipic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635399108&t=bf5fb7a6a8085381992efaecface732a', '图片2'),
            _buildHero(context, 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic15.nipic.com%2F20110708%2F3388327_164155701127_2.jpg&refer=http%3A%2F%2Fpic15.nipic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635399108&t=bf5fb7a6a8085381992efaecface732a', '图片3'),
          ],
        ),
      )
    );
  }
}
