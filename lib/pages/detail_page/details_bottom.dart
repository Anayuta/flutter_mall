import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/model/details.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoodInfo goodsInfo =
        Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    String goodId = goodsInfo.goodsId;
    String goodsName = goodsInfo.goodsName;
    int count = 1;
    double price = goodsInfo.presentPrice;
    String images = goodsInfo.image1;

    return new Container(
      height: ScreenUtil().setHeight(80.0),
      width: ScreenUtil().setWidth(750.0),
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          new InkWell(
            onTap: () {},
            child: new Container(
              width: ScreenUtil().setWidth(110.0),
              alignment: Alignment.center, //上下左右都居中对齐
              child: new Icon(
                Icons.shopping_cart,
                color: Colors.pink,
                size: 35,
              ),
            ),
          ),
          new InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context)
                  .save(goodId, goodsName, count, price, images);
            },
            child: new Container(
              alignment: Alignment.center,
              color: Colors.green,
              width: ScreenUtil().setWidth(320.0),
              height: ScreenUtil().setHeight(80.0),
              child: new Text(
                "加入购物车",
                style: new TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),
          new InkWell(
            onTap: () {},
            child: new Container(
              alignment: Alignment.center,
              color: Colors.red,
              width: ScreenUtil().setWidth(320.0),
              height: ScreenUtil().setHeight(80.0),
              child: new Text(
                "立即购买",
                style: new TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
