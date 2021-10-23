
import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart'; //flutter_swiper 会报空安全错
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
const APP_SCROLL_OFFSET = 100; //设置滚动距离的常量

class SwiperPage  extends StatefulWidget {
  @override
  _SwiperPage createState() => _SwiperPage();
}

class _SwiperPage extends State<SwiperPage> {
  List<String> _imgUrl = [
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F16%2F10%2F29%2F2ac8e99273bc079e40a8dc079ca11b1f.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635474542&t=ae9fbdd52e62aeb5ed2c135a97f72c2f',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F16%2F10%2F29%2F2ac8e99273bc079e40a8dc079ca11b1f.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635474542&t=ae9fbdd52e62aeb5ed2c135a97f72c2f',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F16%2F10%2F29%2F2ac8e99273bc079e40a8dc079ca11b1f.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1635474542&t=ae9fbdd52e62aeb5ed2c135a97f72c2f'
  ];

  double appBarAlpha = 0 ;

  void _onScroll(double offset) {
    double alpha = offset/APP_SCROLL_OFFSET;
    if(alpha<0) {
      alpha = 0;
    }else if(alpha>1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title:Text('swiper')),
      body: Stack( //从下往上排列，后面的元素会在上方显示
          children: [
            MediaQuery.removePadding( //移出安全距离,使内容可以在顶部显示
            removeTop: true,
            context: context,
            child:
            NotificationListener(
              onNotification:(ScrollNotification scrollNotification) {
                if (scrollNotification is ScrollStartNotification && scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return  true;
              },
              child:ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _imgUrl.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context,int index) {
                        return Image.network(
                            _imgUrl[index],
                            fit:BoxFit.cover
                        );
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(title:Text('哈哈')),
                  ),
                ],
              ),
            )),
            Opacity(
              opacity: appBarAlpha,
              child:Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top:20),
                    child: Text('首页'),
                  ),
                ),
              ),)
          ],
        )
    );
  }
}
