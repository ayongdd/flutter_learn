import 'package:flutter/material.dart';
// import 'package:flutter_learn/heroAnimate.dart';

import 'animate.dart';
import 'image_page.dart';
import 'heroAnimate.dart';
import 'refresh.dart';
import 'swiper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String,WidgetBuilder>{
        "animate":(BuildContext context) =>Animate(),
        "heroAnimate":(BuildContext context) =>HeroAnimate(),
        "imagePage":(BuildContext context)=>ImagePage(),
        "swiper":(BuildContext context)=>SwiperPage(),
        "refresh":(BuildContext context)=>Refresh()
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _bottonItem('animate','animation动画'),
            _bottonItem('heroAnimate','hero动画'),
            _bottonItem('imagePage', 'Image控件'),
            _bottonItem('swiper', 'swiper控件'),
            _bottonItem('refresh', 'refresh控件')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _bottonItem(String name,String title) {
    return ElevatedButton(onPressed: () {
      Navigator.pushNamed(context, name);
    }, child:Text(title));
  }
}
