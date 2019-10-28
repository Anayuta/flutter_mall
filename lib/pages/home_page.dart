import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_shop/config/http_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/routers/application.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

/*
 * AutomaticKeepAliveClientMixin 页面保持状态 ,配合index_page的IndexedStack使用
 */
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = new List();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("initState");
    _getHotGoods();
  }

  @override
  Widget build(BuildContext context) {
    Map formData = {"lon": "115.02932", "lat": "35.76189"};
    return new Scaffold(
      appBar: new AppBar(
        title: Text("百姓生活+"),
//        centerTitle: true,
      ),
      //FutureBuilder 异步builder
      body: new FutureBuilder(
          future: request('homePageContext', formData: formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
              String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1GoodsList =
                  (data['data']['floor1'] as List).cast();
              List<Map> floor2GoodsList =
                  (data['data']['floor2'] as List).cast();
              List<Map> floor3GoodsList =
                  (data['data']['floor3'] as List).cast();
              return new EasyRefresh(
                child: new ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDateList: swiper),
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    AdBanner(adPicture: adPicture),
                    LeaderPhone(
                      leaderImage: leaderImage,
                      leaderPhone: leaderPhone,
                    ),
                    Recommend(
                      recommendList: recommendList,
                    ),
                    FloorTitle(
                      pictureAddress: floor1Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor1GoodsList,
                    ),
                    FloorTitle(
                      pictureAddress: floor2Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor2GoodsList,
                    ),
                    FloorTitle(
                      pictureAddress: floor3Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor3GoodsList,
                    ),
                    HotGoods(),
                    _hotGoods(),
                  ],
                ),
                onLoad: () async {
                  print("加载更多...");
                  await _getHotGoods();
                },
              );
            } else {
              return new Center(
                child: new Text(
                  "加载中",
                  style: new TextStyle(fontSize: ScreenUtil().setSp(28)),
                ),
              );
            }
          }),
    );
  }

  void _getHotGoods() {
    Map formPage = {"page": page};
    request('homePageBelowConten', formData: formPage).then((val) {
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  //变量类型实现组件
  Widget hotTitle = new Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    padding: new EdgeInsets.all(5.0),
    child: new Text("火爆专区"),
  );

  //方法类型实现组件
  Widget _wrapList() {
    if (hotGoodsList.length > 0) {
      List<Widget> listWidget = hotGoodsList.map((value) {
        return InkWell(
          onTap: () {
            Application.jumperDetail(context, value["goodsId"]);
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: new EdgeInsets.all(5.0),
            margin: new EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  value["image"],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  value["name"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text("￥${value["mallPrice"]}"),
                    Text(
                      "￥${value["price"]}",
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough //删除线
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        children: listWidget,
        spacing: 2, //2列
      );
    } else {
      return Text("");
    }
  }

  Widget _hotGoods() {
    return Container(
      child: new Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }
}

/*
 * 首页轮播组件
 */
class SwiperDiy extends StatelessWidget {
  final List<Map> swiperDateList;

  SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("设备像素密度:${ScreenUtil.pixelRatio}");
    print("设备的高:${ScreenUtil.screenHeight}");
    print("设备的宽:${ScreenUtil.screenWidth}");
    return new Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperDateList.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            onTap: () {
              Application.jumperDetail(
                  context, swiperDateList[index]["goodsId"]);
            },
            child: Image.network(
              swiperDateList[index]["image"],
              fit: BoxFit.cover,
            ),
          );
        },
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

/*
  导航菜单
 */
class TopNavigator extends StatelessWidget {
  List<Map> navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
  }

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print("点击了:${item}");
      },
      child: Column(
        children: <Widget>[
          new Image.network(
            item["image"],
            width: ScreenUtil().setWidth(95),
          ),
          new Text(
            item["mallCategoryName"],
            style: new TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: ScreenUtil().setHeight(340),
      padding: new EdgeInsets.all(3.0),
      child: new GridView.count(
        physics: NeverScrollableScrollPhysics(), //禁止滚动
        crossAxisCount: 5, //每行5个
        padding: EdgeInsets.all(5.0), //每个padding5.0像素，防止挨着
        children: this.navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

/*
 * 广告区域
 */
class AdBanner extends StatelessWidget {
  String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Image.network(adPicture);
  }
}

/*
   拨打电话
 */
class LeaderPhone extends StatelessWidget {
  String leaderImage; //店长图片
  String leaderPhone; //店长电话

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new InkWell(
        onTap: () {
          _launchURL();
        },
        child: new Image.network(leaderImage),
      ),
    );
  }

  //拨打电话需要时间，所以async
  void _launchURL() async {
    String url = "tel:" + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "launch error";
    }
  }
}

/*
  商品推荐
 */
class Recommend extends StatelessWidget {
  List<Map> recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  //标题
  Widget _titleWidget() {
    return new Container(
      alignment: Alignment.centerLeft,
      padding: new EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(color: Colors.black12, width: 0.5))), //下划线
      child: new Text(
        "商品推荐",
        style: TextStyle(color: Colors.pink, fontSize: 14),
      ),
    );
  }

  //商品
  Widget _item(BuildContext context, int index) {
    return new InkWell(
      onTap: () {
        Application.jumperDetail(context, recommendList[index]["goodsId"]);
      },
      child: new Container(
        height: ScreenUtil().setHeight(345),
        width: ScreenUtil().setWidth(250),
        padding: new EdgeInsets.all(8.0),
        //decoration 右边线和底色
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border(
                right: new BorderSide(width: 0.5, color: Colors.black12))),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            new Text("￥${recommendList[index]['mallPrice']}"),
            new Text(
              "￥${recommendList[index]['price']}",
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////////组件不超过三层嵌套

  //横向列表
  Widget _recommendList() {
    return new Container(
      height: ScreenUtil().setHeight(345),
      child: new ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _item(context, index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }
}

//楼层
class FloorTitle extends StatelessWidget {
  String pictureAddress;

  FloorTitle({Key key, this.pictureAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pictureAddress),
    );
  }
}

//楼层商品
class FloorContent extends StatelessWidget {
  List<Map> floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context),
        ],
      ),
    );
  }

  Widget _firstRow(BuildContext context) {
    return new Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[0]),
        new Column(
          children: <Widget>[
            _goodsItem(context,floorGoodsList[1]),
            _goodsItem(context,floorGoodsList[2]),
          ],
        ),
      ],
    );
  }

  Widget _otherGoods(BuildContext context) {
    return new Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[3]),
        _goodsItem(context,floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context,Map goods) {
    return new Container(
      width: ScreenUtil().setWidth(375),
      child: new InkWell(
        onTap: () {
          Application.jumperDetail(context, goods["goodsId"]);
        },
        child: Image.network(goods["image"]),
      ),
    );
  }
}

class HotGoods extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HotGoodsState();
  }
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text("1"),
    );
  }
}
