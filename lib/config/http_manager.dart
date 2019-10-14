import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_shop/config/service.dart';

Future request(String url, {var formData}) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw new Exception("接口请求异常");
    }
  } catch (e) {
    return print("error:${e}");
  }
}
