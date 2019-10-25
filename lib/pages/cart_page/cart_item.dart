import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:flutter_shop/pages/cart_page/cart_count.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/cart.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel mCartInfoModel;

  CartItem(this.mCartInfoModel);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: new EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(color: Colors.black12, width: 1.0))),
      child: new Row(
        children: <Widget>[
          _cartCheckBtn(context),
          _cartImage(),
          _cartName(),
          _cartPrice(context)
        ],
      ),
    );
  }

  /*
   多选按钮
   */
  Widget _cartCheckBtn(BuildContext context) {
    return new Container(
      child: new Checkbox(
        value: mCartInfoModel.check,
        onChanged: (bool flag) {
          mCartInfoModel.check = flag;
          Provide.value<CartProvide>(context).changeCheckState(mCartInfoModel);
        },
        activeColor: Colors.pink,
      ),
    );
  }

/*
  商品图片
   */
  Widget _cartImage() {
    return new Container(
      padding: new EdgeInsets.all(3.0),
      width: ScreenUtil().setWidth(150.0),
      height: ScreenUtil().setHeight(150.0),
      decoration: new BoxDecoration(
          border: new Border.all(width: 1, color: Colors.black12)),
      child: new Image.network(mCartInfoModel.images),
    );
  }

  /*
  商品名称
   */
  Widget _cartName() {
    return new Container(
      width: new ScreenUtil().setWidth(300.0),
      padding: new EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      child: new Column(
        children: <Widget>[
          new Text(mCartInfoModel.goodsName),
          new CartCount(mCartInfoModel),
        ],
      ),
    );
  }

  /*
  商品价格
   */
  Widget _cartPrice(BuildContext context) {
    return new Container(
      width: new ScreenUtil().setWidth(150.0),
      alignment: Alignment.centerRight,
      child: new Column(
        children: <Widget>[
          new Text("￥${mCartInfoModel.price}"),
          new Container(
//            alignment: Alignment.centerRight,
            child: new InkWell(
              onTap: () {
                Provide.value<CartProvide>(context)
                    .deleteCartInfo(mCartInfoModel.goodsId);
              },
              child: new Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 20.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
