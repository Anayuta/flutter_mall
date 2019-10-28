import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("会员中心"),
      ),
      body: new ListView(
        children: <Widget>[
          _topHeader(),
          _myOrderTitle(),
          _orderType(),
          _actionList(),
        ],
      ),
    );
  }

  /*
  顶部区域
   */
  Widget _topHeader() {
    return new Container(
      width: new ScreenUtil().setWidth(750),
      padding: new EdgeInsets.all(20.0),
      color: Colors.pinkAccent,
      child: new Column(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.only(top: 30.0),
            child: new ClipOval(
              child: new Image.network(
                "https://img.ivsky.com/img/bizhi/slides/201909/25/abominable-008.jpg",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(top: 10.0),
            child: new Text(
              "Admin",
              style: new TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  /*
  我的订单
   */
  Widget _myOrderTitle() {
    return new Container(
      margin: new EdgeInsets.only(top: 10.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(color: Colors.black12, width: 1.0))),
      child: new ListTile(
        leading: new Icon(Icons.list),
        title: new Text("我的订单"),
        trailing: new Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _orderType() {
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      width: new ScreenUtil().setWidth(750),
      height: new ScreenUtil().setHeight(150),
      padding: new EdgeInsets.only(top: 20.0),
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          new Container(
            width: new ScreenUtil().setWidth(187.0),
            child: new Column(
              children: <Widget>[
                new Icon(
                  Icons.party_mode,
                  size: 30,
                ),
                new Text("待付款"),
              ],
            ),
          ),
          new Container(
            width: new ScreenUtil().setWidth(187.0),
            child: new Column(
              children: <Widget>[
                new Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                new Text("待发货"),
              ],
            ),
          ),
          new Container(
            width: new ScreenUtil().setWidth(187.0),
            child: new Column(
              children: <Widget>[
                new Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                new Text("待收货"),
              ],
            ),
          ),
          new Container(
            width: new ScreenUtil().setWidth(187.0),
            child: new Column(
              children: <Widget>[
                new Icon(
                  Icons.border_bottom,
                  size: 30,
                ),
                new Text("待评价"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _myListTitle(String title) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          bottom: new BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: new ListTile(
        leading: Icon(Icons.blur_circular),
        title: new Text(title),
        trailing: new Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _actionList() {
    return new Container(
      margin: new EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
          _myListTitle("领取优惠券"),
          _myListTitle("已领取优惠券"),
          _myListTitle("地址管理"),
          _myListTitle("客服电话"),
          _myListTitle("关于我们"),
        ],
      ),
    );
  }
}
