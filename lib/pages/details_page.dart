import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("详情"),
        ),
        body: new Container(
          child: new Text("111111"),
        ));
  }
}
