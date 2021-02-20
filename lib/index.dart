import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;

import 'player.dart';
import 'utils/futuer.dart';
import 'model/video_model.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> with AutomaticKeepAliveClientMixin {
  int _index;
  int _page;
  StreamController<VideoModel> _streamController;
  Future<List<VideoModel>> _future;
  Stream<VideoModel> _stream;
  List<VideoModel> _models;
  @override
  void initState() {
    _index = 0;
    _page = 0;
    _models = [];
    _streamController = StreamController<VideoModel>();
    _future = _getData();
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
    super.build(context);
    return Center(
        child: FutureBuilder(
            builder: (context, snapshot) =>
                buildFuture(context, snapshot, _buildPlayer),
            future: _future));
  }

  Widget _buildPlayer(List<VideoModel> models) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: StreamBuilder(
        initialData: models[_index],
        stream: _stream,
        builder: (context, snapshot) => Player(snapshot.data),
      ),
      onVerticalDragEnd: (details) => _toggle(details, models),
    );
  }

  Future<List<VideoModel>> _getData() async {
    // String data = await DefaultAssetBundle.of(context)
    //     .loadString("assets/data/data.json");
    // List list = jsonDecode(data)['data'];
    var response = await Http.get("http://api.899.mn/api/api?page=$_page");
    List list = jsonDecode(response.body.toString())['data'];
    List<VideoModel> temp = list.map((v) => VideoModel.fromJson(v)).toList();
    temp.removeWhere((v) => v.type != 'video');
    _models.addAll(temp);
    return _models;
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
      } else {
        _page++;
        _getData();
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
