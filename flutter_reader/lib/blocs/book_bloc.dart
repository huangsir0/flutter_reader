import 'package:flutter_reader/beans/book_bean.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class BookBloc extends BaseBloc {
  //
  final _bookBeanFetcher = PublishSubject<List<BookBean>>();

  //监听
  Observable<List<BookBean>> get categaryItems => _bookBeanFetcher.stream;

  void fetchBookBeans(String categoryId, String kind, int curPage) async {

    List<BookBean> datas =
    await netApi.fetchCategoryRankData(categoryId, kind, curPage);
    if (!_bookBeanFetcher.isClosed) {

      _bookBeanFetcher.sink.add(datas);
    }
  }

  void fetchBookRank(
      String categoryId, String kind, String time, int curPage) async {
    List<BookBean> datas =
    await netApi.fetchRankData(categoryId, kind, time, curPage);
    if (!_bookBeanFetcher.isClosed) {

      _bookBeanFetcher.sink.add(datas);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bookBeanFetcher?.close();
  }
}
