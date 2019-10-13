import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategroyList = [];
  String categoryId = "4"; //左侧大类id
  int childIndex = 0; //子类高亮索引
  String subId = ""; //
  int page = 1; //列表页面

  //左侧类别切换逻辑
  void getChildCategory(List<BxMallSubDto> list, String categoryId) {
    this.childIndex = 0;
    this.categoryId = categoryId;
    this.page = 1;
    this.childCategroyList.clear();
    BxMallSubDto bxMallSubDto = new BxMallSubDto(
        mallSubId: "", mallCategoryId: "", mallSubName: "全部", comments: "");
    this.childCategroyList.add(bxMallSubDto);
    this.childCategroyList.addAll(list);
    notifyListeners();
  }

  //子类改变
  void changeChildIndex(int index, String subId) {
    this.childIndex = index;
    this.subId = subId;
    this.page = 1;
    notifyListeners();
  }

  void addPage() {
    this.page++;
  }

  void changeNoMore(String text) {
    //todo
  }
}
