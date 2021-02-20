import 'dart:async';

import 'package:flutter/material.dart';

import 'player.dart';
import 'model/video_model.dart';

class FavoritePage extends StatefulWidget {
  final List<VideoModel> models;
  final int index;

  const FavoritePage({Key key, this.models, this.index}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _index;
  StreamController<VideoModel> _streamController;
  Stream<VideoModel> _stream;

  @override
  void initState() {
    _index = widget.index;
    _streamController = StreamController<VideoModel>();
    _stream = _streamController.stream;
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text('收藏夹'),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: StreamBuilder(
          initialData: widget.models[_index],
          stream: _stream,
          builder: (context, snapshot) => Player(snapshot.data),
        ),
        onVerticalDragEnd: (details) => _toggle(details, widget.models),
      ),
    );
  }

  void _toggle(DragEndDetails details, List<VideoModel> models) {
    if (details.velocity.pixelsPerSecond.direction > 0) {
      if (_index >= 1) {
        _index--;
        _streamController.add(models[_index]);
      }
    } else {
      if (_index < models.length - 1) {
        _index++;
        _streamController.add(models[_index]);
      }
    }
  }
}
