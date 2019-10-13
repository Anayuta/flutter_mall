import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class Application {
  static Router router;

  //跳转到详情页面
  static void jumperDetail(BuildContext context, String goodsId) {
    Application.router.navigateTo(context, "/detail?goodsId=" + goodsId,
        transition: TransitionType.fadeIn);
  }
}
