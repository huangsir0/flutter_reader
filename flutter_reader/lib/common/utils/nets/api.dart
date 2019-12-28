import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_reader/beans/banner_item_bean.dart';
import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/beans/book_info_bean.dart';
import 'package:flutter_reader/beans/book_item_bean.dart';
import 'package:flutter_reader/beans/categary_item_bean.dart';
import 'package:flutter_reader/beans/store_sex_bean.dart';
import 'package:flutter_reader/common/utils/nets/http_respository.dart';

var myHttp = DioFactory.instance;

class BookStringApi {
  static const search = "search.aspx";
  static const storeSex = "v5/base";
  static const storeSexBanner = "v5/base";
  static const category = "BookCategory.html";
  static const list = "shudan";
  static const rank = "top";
  static const info = "info";
  static const listDetail = "shudan/detail";
  static const categoryRank = "Categories";
  static const myChapterApi = "book";

  static const commentApi = "http://changyan.sohu.com/api/2/topic/load";

  static const chaptersApi = "https://quapp.1122dh.com/book";
  static const chapterApi = "https://quapp.1122dh.com/book";
}

class Api {
  //获取分类
  Future<List<CategaryItemBean>> fetchCategoryData() async {
    List models = List();
    try {
      Map<String, dynamic> response = await myHttp.get(BookStringApi.category);
      models = response["data"];
    } catch (e) {
      print(e);
    }

    return models.map((data) {
      return CategaryItemBean.fromJson(data);
    }).toList();
  }

  Future<Map> getCommentData(
      String topic_title, int topic_source_id, int page_size) async {
    var result = await Dio().get(BookStringApi.commentApi, queryParameters: {
      'hot_size': 1,
      'depth': 0,
      'topic_url': "",
      'topic_title': topic_title,
      'order_by': "",
      'style': "",
      'sub_size': 0,
      'client_id': "cyt9aPs20",
      'topic_source_id': topic_source_id,
      'page_size': page_size,
    });
    if (result.data.runtimeType == String) {
      return json.decode(result.data);
    }
    return result.data;
  }

  Future<StoreSexBean> fetchStoreSexData(String sex) async {
    StoreSexBean data = null;
    try {
      Map<String, dynamic> response =
          await myHttp.get("${BookStringApi.storeSex}/${sex}.html");
      data = StoreSexBean.fromJson(response);
    } catch (e) {
      print(e);
    }
    return data;
  }

  //获取书本信息
  Future<BookInfoBean> fetchBookInfoData(int bookId) async {
    BookInfoBean bookInfoBean;
    try {
      Map<String, dynamic> response =
          await myHttp.get("${BookStringApi.info}/$bookId.html");
      bookInfoBean = BookInfoBean.fromJson(response);
    } catch (e) {
      print(e);
    }
    return bookInfoBean;
  }

  //获取分类
  Future<List<BannerItemBean>> fetchBannerItems(String sex) async {
    List models = List();
    try {
      Map<String, dynamic> response =
          await myHttp.get("${BookStringApi.storeSexBanner}/banner_$sex.html");
      models = response["data"];
    } catch (e) {
      print(e);
    }

    return models.map((data) {
      return BannerItemBean.fromJson(data);
    }).toList();
  }

  Future<List<BookItemBean>> fetchBookList(
      String sex, String kind, int page) async {
    List models = List();
    try {
      Map<String, dynamic> response =
          await myHttp.get("${BookStringApi.list}/$sex/all/$kind/$page.html");
      models = response["data"];
    } catch (e) {
      print(e);
    }

    return models.map((data) {
      return BookItemBean.fromMap(data);
    }).toList();
  }

  Future<List<BookBean>> fetchCategoryRankData(
      String categoryId, String kind, int curPage) async {
    List models = List();
    try {
      var response = await myHttp
          .get("${BookStringApi.categoryRank}/$categoryId/$kind/$curPage.html");
      models = response["data"]["BookList"];
    } catch (e) {
      print(e);
    }

    return models.map((data) {
      return BookBean.fromMap(data);
    }).toList();
  }

  Future<Map> fetchListDetailData(String listId) async {
    var result = await myHttp.get("${BookStringApi.listDetail}/$listId.html");
    return result;
  }

  Future<List<BookBean>> fetchRankData(
      String sex, String kind, String time, int page) async {
    List models = List();

    try {
      var response = await myHttp
          .get("${BookStringApi.rank}/$sex/top/$kind/$time/$page.html");
      models = response["data"]['BookList'];
    } catch (e) {
      print(e);
    }
    return models.map((map) {
      return BookBean.fromMap(map);
    }).toList();
  }

  Future<Map> fetchChaptersData(int bookId) async {
    var result = await Dio().get("${BookStringApi.chaptersApi}/$bookId/");
    var data = result.data.toString().replaceAll(",]", "]");
    return json.decode(data);
  }

  Future<Map> fetchChapterData(int bookId, String chapterId) async {
    var result =
        await Dio().get("${BookStringApi.chapterApi}/$bookId/$chapterId.html/");
    var data = result.data.toString().replaceAll(",]", "]");
    return json.decode(data);
  }
}
