import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/routers.dart';
import 'package:flutter_shop/routers/application.dart';

void main() {
  //全局状态控制,采用provide方式
  ChildCategory category = new ChildCategory();
  CategoryGoodsListProvide categoryGoodsListProvide =
      new CategoryGoodsListProvide();
  Providers providers = new Providers();
  providers..provide(Provider<ChildCategory>.value(category));
  providers
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));

  runApp(ProviderNode(child: new MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Router router = new Router();
    Routes.defineRoutes(router);
    Application.router = router;

    return new Container(
      child: new MaterialApp(
        title: "百姓生活+",
        debugShowCheckedModeBanner: false,
        //去除右上角debug角标
        theme: new ThemeData(primaryColor: Colors.pink),
//路由默认配置
//     initialRoute: ,
//      routes: ,
        home: IndexPage(),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
