import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";

  void save(String goodId, String goodsName, int count, double price,
      String images) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString("cartInfo");
    List<Map> temp = cartString == null
        ? []
        : (json.decode(cartString.toString()) as List).cast();
    bool isHave = false;
    int ival = 0;
    temp.forEach((value) {
      if (value["goodsId"] == goodId) {
        temp[ival]["count"] = ++value["count"];
        isHave = true;
      }
      ival++;

    });
    if (!isHave) {
      Map<String, Object> map = new Map();
      map["goodsId"] = goodId;
      map["goodsName"] = goodsName;
      map["count"] = count;
      map["price"] = price;
      map["images"] = images;
      temp.add(map);
    }
    String jsonStr = json.encode(temp).toString();
    sp.setString("cartInfo", jsonStr);
    print("添加数据 ${jsonStr}");
  }

  void remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("cartInfo");
    print("清空数据");
    notifyListeners();
  }
}
