import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';

class VideoController extends CachedVideoPlayerController {
  VideoController(String dataSource) : super.network(dataSource);
}

class Video extends CachedVideoPlayer {
  Video(CachedVideoPlayerController controller) : super(controller);
}

class VideoProgress extends VideoProgressIndicator {
  VideoProgress(CachedVideoPlayerController controller, ProgressColors colors)
      : super(controller, allowScrubbing: true, colors: colors);
}

class ProgressColors extends VideoProgressColors {
  ProgressColors(Color playedColor, Color bufferedColor, Color backgroundColor)
      : super(
            playedColor: playedColor,
            bufferedColor: bufferedColor,
            backgroundColor: backgroundColor);
}
