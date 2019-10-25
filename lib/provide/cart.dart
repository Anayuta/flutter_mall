import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shop/model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  List<CartInfoModel> cartList = [];
  double totalPrice = 0; //总价格
  int number = 0; //商量总数量
  bool allSelect = true; //默认是全选

  void save(String goodId, String goodsName, int count, double price,
      String images) async {
    this.totalPrice = 0;
    this.number = 0;
    SharedPreferences sp = await SharedPreferences.getInstance();
    String cartString = sp.getString("cartInfo");
    List<Map> temp = cartString == null
        ? []
        : (json.decode(cartString.toString()) as List).cast();
    bool isHave = false;
    int ival = 0;
    temp.forEach((value) {
      if (value["goodsId"] == goodId) {
        int sum = value["count"] + 1;
        temp[ival]["count"] = sum;
        cartList[ival].count++;
        isHave = true;
      }
      if (value["check"]) {
        //选中才相加价格
        this.totalPrice += value["price"] * value["count"];
        this.number += value["count"];
      } else {
        allSelect = false;
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
      map["check"] = true;
      temp.add(map);
      cartList.add(CartInfoModel.fromJson(map));
      this.totalPrice += price * count;
      this.number += count;
    }
    String jsonStr = json.encode(temp).toString();
    sp.setString("cartInfo", jsonStr);
//    print("添加数据 ${jsonStr}");
    notifyListeners();
  }

  void remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("cartInfo");
    this.cartList.clear();
    print("清空数据");
    notifyListeners();
  }

  void getCartInfo() async {
    this.totalPrice = 0;
    this.number = 0;
    SharedPreferences sp = await SharedPreferences.getInstance();
    String jsonString = sp.getString("cartInfo");
    if (jsonString == null) {
      cartList = [];
    } else {
      this.cartList.clear();
      List<Map> tempList = (json.decode(jsonString.toString()) as List).cast();
      allSelect = true;
      tempList.forEach((value) {
        CartInfoModel cartInfoModel = CartInfoModel.fromJson(value);
        if (cartInfoModel.check) {
          //选中才相加价格
          this.totalPrice += cartInfoModel.price * cartInfoModel.count;
          this.number += cartInfoModel.count;
        } else {
          allSelect = false;
        }
        cartList.add(cartInfoModel);
      });
    }
    notifyListeners();
  }

  /*
   删除单个购物车商品
   */
  void deleteCartInfo(String goodsId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String jsonString = sp.getString("cartInfo");
    List<Map> tempList = (json.decode(jsonString.toString()) as List).cast();
    int delIndex = 0;
    int tempIndex = 0;
    tempList.forEach((value) {
      if (value["goodsId"] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    String jsonStr = json.encode(tempList).toString();
    sp.setString("cartInfo", jsonStr);
    this.getCartInfo();
  }

  /*
  更改选中状态
   */
  void changeCheckState(CartInfoModel cartInfoModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String jsonString = sp.getString("cartInfo");
    List<Map> tempList = (json.decode(jsonString.toString()) as List).cast();
    int changeIndex = 0;
    int tempIndex = 0;
    tempList.forEach((value) {
      //dart 循环不允许更新列表的数据
      if (value["goodsId"] == cartInfoModel.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
//    cartInfoModel.check = !cartInfoModel.check;
    tempList[changeIndex] = cartInfoModel.toJson();
    String jsonStr = json.encode(tempList).toString();
    sp.setString("cartInfo", jsonStr);
    this.getCartInfo();
  }

  /*
  全选按钮操作
   */
  void changeAllCheckBtnState(bool check) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String jsonString = sp.getString("cartInfo");
    List<Map> tempList = (json.decode(jsonString.toString()) as List).cast();
    List<Map> tempList1 = new List();
    for (int i = 0; i < tempList.length; i++) {
      Map value = tempList[i];
      value["check"] = check;
      tempList1.add(value);
    }
    String jsonStr = json.encode(tempList1).toString();
    sp.setString("cartInfo", jsonStr);
    this.getCartInfo();
  }

  /*
  商品数量加减
   */
  void addOrSubCart(CartInfoModel cartInfoModel, int type) async {
    if (type < 0 && cartInfoModel.count <= 1) {
      return;
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    String jsonString = sp.getString("cartInfo");
    List<Map> tempList = (json.decode(jsonString.toString()) as List).cast();
    int changeIndex = 0;
    int tempIndex = 0;
    tempList.forEach((value) {
      //dart 循环不允许更新列表的数据
      if (value["goodsId"] == cartInfoModel.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (type > 0) {
      cartInfoModel.count++;
    } else {
      cartInfoModel.count--;
    }
    tempList[changeIndex] = cartInfoModel.toJson();
    String jsonStr = json.encode(tempList).toString();
    sp.setString("cartInfo", jsonStr);
    this.getCartInfo();
  }
}
