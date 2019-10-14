import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Provide<DetailsInfoProvide>(builder:
        (BuildContext context, Widget child, DetailsInfoProvide provide) {
      return new Container(
        margin: new EdgeInsets.only(top: 15.0),
        child: new Row(
          children: <Widget>[
            _tabBarLeftAndRight(context, provide.isLeft, "详情", true),
            _tabBarLeftAndRight(context, provide.isRight, "评论", false),
          ],
        ),
      );
    });
  }

  Widget _tabBarLeftAndRight(
      BuildContext context, bool isFocus, String btnText, bool isLeft) {
    return new InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context)
            .changeLeftAndRight(isLeft ? "left" : "right");
      },
      child: new Container(
        padding: new EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
                bottom: BorderSide(
                    width: 1.0,
                    color: isFocus ? Colors.pink : Colors.transparent))),
        child: new Text(
          btnText,
          style: new TextStyle(
              fontSize: 16, color: isFocus ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}
