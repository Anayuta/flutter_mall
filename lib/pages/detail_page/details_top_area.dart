import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/details.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Provide(builder: (BuildContext context, Widget child,
        DetailsInfoProvide detailsInfoProvide) {
      GoodInfo goodInfo = detailsInfoProvide.goodsInfo.data.goodInfo;
      if (goodInfo != null) {
        return new SingleChildScrollView(
          child: new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                _goodsImage(goodInfo.image1),
                _goodsName(goodInfo.goodsName),
                _goodsNo(goodInfo.goodsSerialNumber),
                _goodPrice(goodInfo.presentPrice, goodInfo.oriPrice),
              ],
            ),
          ),
        );
      } else {
        return new Center(
          child: new Text("正在加载中..."),
        );
      }
    });
  }

  /*
   顶部商品大图
   */
  Widget _goodsImage(String url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  /*
  商品名称
   */
  Widget _goodsName(String name) {
    return new Container(
      width: ScreenUtil().setWidth(740),
      padding: new EdgeInsets.only(left: 15.0),
      child: new Text(
        name,
        style: new TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  /*
   商品编号
   */
  Widget _goodsNo(String no) {
    return new Container(
      width: ScreenUtil().setWidth(740),
      padding: new EdgeInsets.only(left: 15.0),
      margin: new EdgeInsets.only(top: 8.0),
      child: new Text(
        "编号:${no}",
        style: new TextStyle(fontSize: 14, color: Colors.black45),
      ),
    );
  }

  /*
  商品价格
   */
  Widget _goodPrice(double price, double orPrice) {
    return new Container(
      width: ScreenUtil().setWidth(740),
      padding: new EdgeInsets.only(left: 15.0),
      margin: new EdgeInsets.only(top: 8.0),
      child: new Row(
        children: <Widget>[
          new Text(
            "￥${price}",
            style: new TextStyle(fontSize: 16, color: Colors.deepOrange),
          ),
          new SizedBox(
            width: 20,
          ),
          new Text(
            "市场价",
            style: new TextStyle(fontSize: 14, color: Colors.black),
          ),
          new SizedBox(
            width: 20,
          ),
          new Text(
            "￥${orPrice}",
            style: new TextStyle(
                fontSize: 14,
                color: Colors.black45,
                decoration: TextDecoration.lineThrough //删除线
                ),
          )
        ],
      ),
    );
  }
}
