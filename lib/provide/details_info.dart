import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/config/http_manager.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo;

  /*
   根据id获取商品详细信息
     增加async和await，保证异步执行正常
   */
  void getGoodsInfo(String id) async {
    Map dataMap = {"goodId": id};
    await request("getGoodDetailById", formData: dataMap).then((value) {
      Map<String, dynamic> decode = json.decode(value.toString());
      goodsInfo = DetailsModel.fromJson(decode);
      notifyListeners();
    });
  }

  //tabbar选中了左边还是右边
  bool isLeft = true;
  bool isRight = false;

  /*
   * tabbar切换
   */
  void changeLeftAndRight(String left) {
    if (left == "left") {
      this.isLeft = true;
      this.isRight = false;
    } else {
      this.isLeft = false;
      this.isRight = true;
    }
    notifyListeners();
  }
}
