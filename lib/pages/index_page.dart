import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomItems = new List();
  final List<Widget> tabBodies = new List();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    //底部item
    bottomItems.add(new BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), title: new Text("首页")));
    bottomItems.add(new BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: new Text("分类")));
    bottomItems.add(new BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: new Text("购物车")));
    bottomItems.add(new BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: new Text("会员中心")));
    //页面
    tabBodies.add(new HomePage());
    tabBodies.add(new CategoryPage());
    tabBodies.add(new CartPage());
    tabBodies.add(new MemberPage());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return new Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: new BottomNavigationBar(
        //fixed类型，shifting类型，tips:3个以上能看出效果
        type: BottomNavigationBarType.fixed,
        items: bottomItems,
        currentIndex: this.currentIndex,
        onTap: (index) {
          this.setState(() {
            this.currentIndex = index;
          });
        },
      ),
      body: new IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}
