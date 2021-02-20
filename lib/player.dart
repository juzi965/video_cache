import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:provider/provider.dart';

import 'utils/video.dart';
import 'utils/toast.dart';
import 'utils/futuer.dart';
import 'model/video_model.dart';
import 'model/video_model_dao.dart';

class Player extends StatefulWidget {
  Player(this.model, {Key key}) : super(key: key);

  final VideoModel model;

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoController _controller;
  VideoModelDao _dao;

  @override
  void initState() {
    Wakelock.enable();
    _dao = VideoModelDao();
    super.initState();
  }

  @override
  void dispose() {
    //   Wakelock.disable();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
            builder: (context, snapshot) =>
                buildFutureVideo(context, snapshot, _buildVideo),
            future: _init()));
  }

  Widget _buildVideo(BuildContext context) {
    _tabIndexChangeEvent(context);
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _controller.toggle(),
        onLongPress: _saveFavorite,
        child: Stack(
          alignment: AlignmentDirectional.center,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Positioned(left: 0.0, right: 0.0, child: Video(_controller)),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 70.0,
              child: VideoProgress(
                _controller,
                ProgressColors(
                    Theme.of(context).textTheme.bodyText2.color,
                    Theme.of(context).textTheme.headline4.color,
                    Theme.of(context).textTheme.headline1.color),
              ),
            ),
          ],
        ));
  }

  Future<void> _init() async {
    // 防止手势滑动过快导致程序卡死
    if (_controller != null) _controller.dispose();
    _controller = VideoController(widget.model.url);
    await _controller.initialize();
  }

  // 首页tabIndex改变会触发视频的播放和暂停事件
  void _tabIndexChangeEvent(BuildContext context) {
    if (ModalRoute.of(context).settings.name != 'favorite') {
      context.select((TabController t) => t.index) == 0
          ? _controller.play()
          : _controller.pause();
    }
  }

  void _saveFavorite() {
    _dao.getVideo(widget.model.vid).then((model) {
      if (model != null) {
        _dao.delVideo(widget.model.vid);
        toast('取消收藏');
      } else {
        _dao.setVideo(widget.model).then((num) {
          num > 0 ? toast('收藏成功') : toast('收藏失败');
        });
      }
    });
  }
}
