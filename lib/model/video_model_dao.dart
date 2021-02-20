import 'package:sqflite/sqflite.dart';

import '../model/video_model.dart';
import '../utils/datebase_helper.dart';

class VideoModelDao {
  final String table = 'video_table';

  Future<int> setVideo(VideoModel model) async {
    Database db = await DatabaseHelper().db;
    return await db.insert(table, model.toJson());
  }

  Future<int> delVideo(String vid) async {
    Database db = await DatabaseHelper().db;
    return await db.delete(table, where: 'vid=?', whereArgs: [vid]);
  }

  Future<VideoModel> getVideo(String vid) async {
    Database db = await DatabaseHelper().db;
    List<Map<String, dynamic>> result =
        await db.query(table, where: 'vid=?', whereArgs: [vid]);
    if (result.length > 0) {
      return VideoModel.fromSql(result.first);
    }
    return null;
  }

  Future<List<VideoModel>> getVideoAll() async {
    Database db = await DatabaseHelper().db;
    List<Map<String, dynamic>> result =
        await db.query(table, orderBy: 'id desc');

    List<VideoModel> videos = [];
    result.forEach((element) {
      videos.add(VideoModel.fromSql(element));
    });

    return videos;
  }
}
