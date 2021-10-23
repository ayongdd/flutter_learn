import 'package:flutter/material.dart';
import 'dart:io'; //加载手机本地图片
import 'package:path_provider/path_provider.dart'; //获取手机路径（不同的手机路径不同）
import 'package:transparent_image/transparent_image.dart'; //图片淡入加载效果
import 'package:cached_network_image/cached_network_image.dart'; //网络图片缓存本地

class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('动画'),),
      body: Center(
        child: Column(
          children: [
            Image.network('http://www.devio.org/img/avatar.png'), //加载网络图片
            Image.asset('images/video_tup.png',width: 100,height: 100,),//加载静态图片
            FadeInImage.memoryNetwork( //图片淡入效果
                placeholder:kTransparentImage,
                image: 'http://www.devio.org/img/avatar.png'),
            CachedNetworkImage( //缓存网络图片
              placeholder: (context,url)=>new CircularProgressIndicator(),
              imageUrl: "http://via.placeholder.com/350x150",
            )
            // Image.file('')
          ],
        ),
      )
    );
  }
}
