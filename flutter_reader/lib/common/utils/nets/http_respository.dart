import 'dart:convert';

import 'package:dio/dio.dart';

class DioFactory {
  static DioFactory get instance => _getInstance();

  static DioFactory _instance;

  Dio _dio;

  BaseOptions _baseOptions;

  DioFactory._internal(
      {String basUrl = Config.baseUrl,
      Map<String, dynamic> header = Config.headers}) {
    _baseOptions = new BaseOptions(
      baseUrl: basUrl,
      connectTimeout: Config.connectTimeout,
      responseType: ResponseType.json,
      receiveTimeout: Config.receiveTimeout,
      //headers: header
    );
    _dio = new Dio(_baseOptions);
  }

  static _getInstance() {
    if (null == _instance) {
      _instance = new DioFactory._internal();
    }

    return _instance;
  }

  get(url, {options, cancelToken, data}) async {
    print("get==>:$url,body:$data");
    Response response;
    try {
      response = await _dio.get(url, cancelToken: cancelToken);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      } else {
        print('get请求发生错误：$e');
      }
    }
    print(response.data.toString());
    if (response.data.runtimeType == String) {
      return json.decode(response.data);
    }
    return response.data;
  }

  /// post网络请求封装
  post(url, {options, cancelToken, data}) async {
    print('post请求::: url：$url ,body: $data');
    Response response;
    try {
      response = await _dio.post(url,
          data: data != null ? data : {}, cancelToken: cancelToken);
      print(response);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      } else {
        print('get请求发生错误：$e');
      }
    }
    return response.data;
  }
}

class Config {
  static const String baseUrl = "https://quapp.1122dh.com/";

  ///链接超时时间
  static const int connectTimeout = 8000;

  ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
  ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
  ///  注意: 这并不是接收数据的总时限.
  static const int receiveTimeout = 3000;

  ///普通格式的header
  static const Map<String, dynamic> headers = {
    "Accept": "application/json",
  };

  ///json格式的header
  static const Map<String, dynamic> headersJson = {
    "Accept": "application/json",
    "Content-Type": "application/json; charset=UTF-8",
  };
}
