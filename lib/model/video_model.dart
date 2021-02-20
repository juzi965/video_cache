class VideoModel {
  final String vid;
  final String avatar;
  final String time;
  final String type;
  final String nickName;
  final String thumb;
  final String url;

  VideoModel(
      {this.vid,
      this.avatar,
      this.time,
      this.type,
      this.nickName,
      this.thumb,
      this.url});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
        vid: json['vid'],
        avatar: json['avatar'],
        time: json['created_at'],
        type: json['type'],
        nickName: json['username'],
        thumb: json['thumb'],
        url: json['video']);
  }

  factory VideoModel.fromSql(Map<String, dynamic> json) {
    return VideoModel(
        vid: json['vid'],
        avatar: json['avatar'],
        time: json['time'],
        type: json['type'],
        nickName: json['nickName'],
        thumb: json['thumb'],
        url: json['url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vid'] = this.vid;
    data['avatar'] = this.avatar;
    data['time'] = this.time;
    data['type'] = this.type;
    data['nickName'] = this.nickName;
    data['thumb'] = this.thumb;
    data['url'] = this.url;
    return data;
  }
}
