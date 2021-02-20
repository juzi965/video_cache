import 'package:flutter/material.dart';

Widget buildFuture(
    BuildContext context, AsyncSnapshot<dynamic> snapshot, Function body) {
  if (snapshot.connectionState != ConnectionState.done) {
    return CircularProgressIndicator();
  }
  if (snapshot.hasError) {
    return Text('出错了');
  }
  return body(snapshot.data);
}

Widget buildFutureVideo(
    BuildContext context, AsyncSnapshot<dynamic> snapshot, Function body) {
  if (snapshot.connectionState != ConnectionState.done) {
    return CircularProgressIndicator();
  }
  if (snapshot.hasError) {
    return Text('出错了');
  }
  return body(context);
}
