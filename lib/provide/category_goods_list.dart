import 'package:flutter/material.dart';
import 'package:flutter_shop/model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryGoodsData> goodsList = [];

  //点击大类更换商品列表
  void getGoodsList(List<CategoryGoodsData> list) {
    this.goodsList = list;
    notifyListeners();
  }

  //子类分页加载更多数据
  void getMoreList(List<CategoryGoodsData> list) {
    this.goodsList.addAll(list);
    notifyListeners();
  }
}
