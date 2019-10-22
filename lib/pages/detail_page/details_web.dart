import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_shop/provide/details_info.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String goodsDetail = Provide.value<DetailsInfoProvide>(context)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;
    return new Provide<DetailsInfoProvide>(builder:
        (BuildContext context, Widget child, DetailsInfoProvide value) {
      bool isLeft = value.isLeft;
      if (isLeft) {
        return new Container(
          child: new Html(data: goodsDetail),
        );
      } else {
        return new Container(
          height: ScreenUtil().setHeight(400),
          child: new Center(child: new Text("暂无数据!")),
        );
      }
    });
  }
}
