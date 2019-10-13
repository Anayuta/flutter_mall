import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/pages/details_page.dart';

Handler detailsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params["goodsId"].first;
  return new DetailsPage(goodsId);
});
//router.navigateTo(context, "/users/1234", transition: TransitionType.fadeIn);
