import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:flutter_shop/pages/cart_page/cart_item.dart';
import 'package:flutter_shop/pages/cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("购物车"),
      ),
      body: new FutureBuilder(
          future: _getCartInfo(context),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return new Stack(
                children: <Widget>[
                  Provide<CartProvide>(builder:
                      (BuildContext context, Widget child, CartProvide value) {
                    List<CartInfoModel> cardList = value.cartList;
                    return new ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return new CartItem(cardList[index]);
                      },
                      itemCount: cardList.length,
                    );
                  }),
                  new Positioned(
                    left: 0,
                    bottom: 0,
                    child: CartBottom(),
                  ),
                ],
              );
            } else {
              return new Text("正在加载...");
            }
          }),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return "";
  }
}
