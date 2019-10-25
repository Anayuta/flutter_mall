import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cartInfo.dart';

class CartCount extends StatelessWidget {
  final CartInfoModel mCartInfoModel;

  CartCount(this.mCartInfoModel);

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
          _subBtn(context),
          _numberView(),
          _addBtn(context),
        ],
      ),
    );
  }

  /*
   减号
   */
  Widget _subBtn(BuildContext context) {
    return new InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrSubCart(mCartInfoModel, -1);
      },
      child: new Container(
        width: ScreenUtil().setWidth(45.0),
        height: ScreenUtil().setWidth(45.0),
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            color: mCartInfoModel.count > 1 ? Colors.white : Colors.black12,
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.black12))),
        child: new Text(mCartInfoModel.count > 1 ? "-" : ""),
      ),
    );
  }

  /*
   加号
   */
  Widget _addBtn(BuildContext context) {
    return new InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrSubCart(mCartInfoModel, 1);
      },
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
      child: new Text("${mCartInfoModel.count}"),
    );
  }
}
