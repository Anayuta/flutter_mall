import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/model/categoryGoodsList.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("商品分类"),
      ),
      body: new Container(
        child: new Row(
          children: <Widget>[
            LeftCategoryNav(),
            new Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
 左侧导航
 */
class LeftCategoryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LeftCategoryNavState();
  }
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<Data> list = [];
  int listIndex = 0; //高亮item的索引

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: ScreenUtil().setWidth(180.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
        itemCount: list.length,
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = this.listIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          this.listIndex = index;
        });
        List<BxMallSubDto> childList = list[index].bxMallSubDto;
        //状态改变
        String categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: new Container(
        height: ScreenUtil().setHeight(100.0),
        padding: new EdgeInsets.only(left: 10, top: 20),
        decoration: new BoxDecoration(
            color: isClick ? Colors.white12 : Colors.white,
            border: new Border(
                bottom: BorderSide(width: 1, color: Colors.black12))),
        child: new Text(
          list[index].mallCategoryName,
          style: new TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  void _getCategory() async {
    await request("getCategory").then((val) {
      print(val.toString());
      var data = json.decode(val.toString());
      CategoryModel bigListModel = CategoryModel.fromJson(data);
      setState(() {
        list = bigListModel.data;
      });
      if (list.isNotEmpty) {
        List<BxMallSubDto> childList = list[0].bxMallSubDto;
        //状态改变
        String categoryId = list[0].mallCategoryId;
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryId);
        _getGoodsList(categoryId: categoryId);
      }
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      "categoryId": Provide.value<ChildCategory>(context).categoryId,
      "categorySubId": "",
      "page": 1
    };
    await request("getMallGoods", formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(categoryGoodsListModel.data);
    });
  }
}

/*
 右侧导航区域
 */
class RightCategoryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RightCategoryState();
  }
}

/*
 * 右侧列表数据
 */
class _RightCategoryState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    //provide 状态数据
    return new Provide<ChildCategory>(builder: (context, child, childCategory) {
      return new Container(
        height: ScreenUtil().setHeight(80.0),
        width: ScreenUtil().setWidth(570.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
                bottom: new BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _rightInkWell(childCategory.childCategroyList[index], index);
          },
          itemCount: childCategory.childCategroyList.length,
        ),
      );
    });
  }

  Widget _rightInkWell(BxMallSubDto item, int index) {
    //判断是否选中
    bool selected = index == Provide.value<ChildCategory>(context).childIndex;
    return new InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        //do net get data
        _getGoodsList(item.mallSubId);
      },
      child: new Container(
        padding: new EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: new Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: 12.0, color: selected ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  void _getGoodsList(String categorySubId) {
    Map data = {
      "categoryId": Provide.value<ChildCategory>(context).categoryId,
      "categorySubId": categorySubId,
      "page": 1
    };
    request("getMallGoods", formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(
          categoryGoodsListModel.data != null
              ? categoryGoodsListModel.data
              : []);
    });
  }
}

/*
  商品列表,可以上拉加载
 */
class CategoryGoodsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryGoodsListState();
  }
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  ScrollController mScrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    //provide 状态控制数据
    return new Provide<CategoryGoodsListProvide>(
        builder: (context, child, data) {
      try {
        if (Provide.value<ChildCategory>(context).page == 1) {
          //列表位置滚动到顶部
          mScrollController.jumpTo(0.0);
        }
      } catch (e) {
        print("第一次页面初始化${e}");
      }
      if (data.goodsList.isEmpty) {
        return new Expanded(
          child: new Center(
            child: new Text("暂无数据!"),
          ),
        );
      } else {
        return new Expanded(
          //flex 布局，解决高度不确定的问题
          child: new Container(
            width: ScreenUtil().setWidth(570.0), //不给宽度将不会显示列表
            child: new EasyRefresh(
              child: new ListView.builder(
                controller: mScrollController,
                itemBuilder: (context, index) {
                  return _listItem(index, data.goodsList);
                },
                itemCount: data.goodsList.length,
              ),
              onLoad: () async {
                _getMoreGoodsList();
              },
            ),
          ),
        );
      }
    });
  }

  void _getMoreGoodsList() {
    Provide.value<ChildCategory>(context).addPage();
    Map data = {
      "categoryId": Provide.value<ChildCategory>(context).categoryId,
      "categorySubId": Provide.value<ChildCategory>(context).subId,
      "page": Provide.value<ChildCategory>(context).page
    };
    request("getMallGoods", formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);
      if (categoryGoodsListModel.data != null) {
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreList(categoryGoodsListModel.data);
      } else {
        Fluttertoast.showToast(
            msg: "没有更多数据了...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.pink,
            textColor: Colors.white);
      }
    });
  }

  /*
    图片
   */
  Widget _goodsImage(int index, List<CategoryGoodsData> list) {
    return new Container(
      width: ScreenUtil().setWidth(200.0),
      child: new Image.network(list[index].image),
    );
  }

  /*
  标题
   */
  Widget _goodsName(int index, List<CategoryGoodsData> list) {
    return new Container(
      padding: new EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370.0),
      child: new Text(
        list[index].goodsName,
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /*
  价格
   */
  Widget _goodsPrice(int index, List<CategoryGoodsData> list) {
    return new Container(
      margin: new EdgeInsets.only(top: 20.0),
//      padding: new EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370.0),
      child: new Row(
        children: <Widget>[
          new Text(
            "价格：￥${list[index].presentPrice}",
            style: new TextStyle(color: Colors.pink, fontSize: 18.0),
          ),
          new Text(
            "￥${list[index].oriPrice}",
            style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black26,
                decoration: TextDecoration.lineThrough //删除线
                ),
          ),
        ],
      ),
    );
  }

  Widget _listItem(int index, List<CategoryGoodsData> goodsList) {
    return new InkWell(
        onTap: () {},
        child: new Container(
          padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: new BorderSide(width: 1.0, color: Colors.black12))),
          child: new Row(
            children: <Widget>[
              _goodsImage(index, goodsList),
              new Column(
                children: <Widget>[
                  _goodsName(index, goodsList),
                  _goodsPrice(index, goodsList),
                ],
              )
            ],
          ),
        ));
  }
}
