import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/router_handler.dart';

class Routes {
  static String root = "/";
  static String detailPage = "/detail";

  /*
     路由配置
   */
  static void defineRoutes(Router router) {
    router.notFoundHandler = new Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> parameters) {
      print("路由错误...");
      return new Text("404");
    }); //找不到路由的情况
    //详情页面路由
    router.define(detailPage, handler: detailsHandler);
  }
}

//router.navigateTo(context, "/users/1234", transition: TransitionType.fadeIn);
