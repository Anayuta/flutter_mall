import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_shop/pages/detail_page/details_top_area.dart';
import 'package:flutter_shop/pages/detail_page/details_explain.dart';
import 'package:flutter_shop/pages/detail_page/details_tabbar.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId) {
    print("页面商品id:${goodsId}");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); //退出该页面
              }),
          title: new Text("商品详情页"),
        ),
        body: new FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Container(
                  child: new ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabbar(),
                    ],
                  ),
                );
              } else {
                return new Center(
                  child: new Text("加载中..."),
                );
              }
            },
            future: _getGoodInfoById(context)));
  }

  Future _getGoodInfoById(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(this.goodsId);
    return ""; //注意返回null将不会调用后续的页面布局
  }
}
