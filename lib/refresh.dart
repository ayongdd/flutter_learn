import 'package:flutter/material.dart';

class Refresh extends StatefulWidget {
  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  List<String> cityNames = ['北京','上海','广州','深圳','杭州','苏州','成都','武汉'];
  final String title = '下拉刷新与上拉加载更多';
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) { //判断滑动到底部
        _loadData(); //加载内容
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); //解除监听
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView(
            controller: _scrollController,
            children: _buildList(),
          ),
        ),
      ),
    );
  }

  Future<Null> _onRefresh() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      cityNames= cityNames.reversed.toList();
    });
    return null;
  }

  List<Widget> _buildList() {
    return cityNames.map((city)=>_item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white,fontSize: 20),
      ),
    );
  }

  Future<Null> _loadData() async{
    await Future.delayed(Duration(milliseconds: 200)) ;
    setState(() {
      List<String> list =List<String>.from(cityNames); //from()复制数组
      list.addAll(cityNames);
      cityNames = list;
    });
    return null;
  }
}
