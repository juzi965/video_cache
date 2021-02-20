import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'index.dart';
import 'favorite.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController _controller;
  List<Widget> _tabs;
  List<Widget> _tabViews;

  @override
  void initState() {
    super.initState();
    _tabs = [Text('首页'), Text('收藏')];
    _tabViews = [Index(), Favorite()];
    _controller = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '麻杰克',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: _tabs,
              controller: _controller,
            ),
          ),
        ),
        body: ChangeNotifierProvider.value(
          value: _controller,
          child: TabBarView(
            children: _tabViews,
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
