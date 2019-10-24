import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.all(5.0),
        color: Colors.white,
        child: new Provide<CartProvide>(
            builder: (BuildContext context, Widget child, CartProvide value) {
          return new Row(
            children: <Widget>[
              selectAllBtn(context),
              allPriceArea(context),
              goBtn(context),
            ],
          );
        }));
  }

  /*
   全选按钮
   */
  Widget selectAllBtn(BuildContext context) {
    bool allSelect = Provide.value<CartProvide>(context).allSelect;
    return new Container(
      child: new Row(
        children: <Widget>[
          new Checkbox(
            value: allSelect,
            onChanged: (bool flag) {
              Provide.value<CartProvide>(context).changeAllCheckBtnState(flag);
            },
            activeColor: Colors.pink,
          ),
          new Text(
            "全选",
            style: new TextStyle(color: Colors.black, fontSize: 14.0),
          )
        ],
      ),
    );
  }

  Widget allPriceArea(BuildContext context) {
    double totalPrice = Provide.value<CartProvide>(context).totalPrice;
    return new Container(
      width: ScreenUtil().setWidth(430),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280.0),
                child: new Text(
                  "合计:",
                  style: new TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150.0),
                child: new Text(
                  "￥${totalPrice}",
                  style: new TextStyle(fontSize: 16.0, color: Colors.red),
                ),
              ),
            ],
          ),
          new Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: new Text(
              "满10元免配送费,预购免配送费",
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Widget goBtn(BuildContext context) {
    int number = Provide.value<CartProvide>(context).number;
    return new Container(
      width: ScreenUtil().setWidth(160.0),
      padding: new EdgeInsets.only(left: 10),
      child: new InkWell(
        onTap: () {},
        child: new Container(
          padding: new EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            color: Colors.red,
            borderRadius: new BorderRadius.circular(3.0),
          ),
          child: new Text(
            "结算(${number})",
            style: new TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}
