import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: ScreenUtil().setWidth(165.0),
      margin: EdgeInsets.only(top: 5.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(1.0),
        border: new Border.all(color: Colors.black12, width: 1.0),
      ),
      child: new Row(
        children: <Widget>[
          _subBtn(),
          _numberView(),
          _addBtn(),
        ],
      ),
    );
  }

  /*
   减号
   */
  Widget _subBtn() {
    return new InkWell(
      onTap: () {},
      child: new Container(
        width: ScreenUtil().setWidth(45.0),
        height: ScreenUtil().setWidth(45.0),
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.black12))),
        child: new Text("-"),
      ),
    );
  }

  /*
   加号
   */
  Widget _addBtn() {
    return new InkWell(
      onTap: () {},
      child: new Container(
        width: ScreenUtil().setWidth(45.0),
        height: ScreenUtil().setWidth(45.0),
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
                left: new BorderSide(width: 1.0, color: Colors.black12))),
        child: new Text("+"),
      ),
    );
  }

  /*
   数量
   */
  Widget _numberView() {
    return new Container(
      width: ScreenUtil().setWidth(70.0),
      height: ScreenUtil().setWidth(45.0),
      alignment: Alignment.center,
      color: Colors.white,
      child: new Text("1"),
    );
  }
}
