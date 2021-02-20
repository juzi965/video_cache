import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'model/video_model.dart';
import 'model/video_model_dao.dart';
import 'utils/futuer.dart';
import 'favorite_page.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  VideoModelDao _dao;

  @override
  void initState() {
    _dao = VideoModelDao();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          builder: (context, snapshot) =>
              buildFuture(context, snapshot, _buildGridView),
          future: _dao.getVideoAll()),
    );
  }

  Widget _buildGridView(List<VideoModel> models) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 8,
          childAspectRatio: 11.1 / 9.3),
      itemCount: models.length,
      itemBuilder: (context, index) => _buildGridCards(context, index, models),
    );
  }

  Widget _buildGridCards(
      BuildContext context, int index, List<VideoModel> models) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 21.0 / 12.0,
                  child: CachedNetworkImage(
                    imageUrl: models[index].thumb,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            width: 35,
                            imageUrl: models[index].avatar,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: 110,
                              child: Text(
                                models[index].nickName,
                                style: Theme.of(context).textTheme.bodyText1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              width: 110,
                              child: Text(
                                models[index].time,
                                style: Theme.of(context).textTheme.bodyText2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: RouteSettings(name: 'favorite'),
                      builder: (_) {
                        return FavoritePage(models: models, index: index);
                      },
                    ),
                  ).then((_) {
                    setState(() {});
                  });
                },
              ),
            )
          ],
        ));
  }
}
