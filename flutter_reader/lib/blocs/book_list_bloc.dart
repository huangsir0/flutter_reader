import 'package:flutter_reader/beans/banner_item_bean.dart';
import 'package:flutter_reader/beans/book_item_bean.dart';
import 'package:flutter_reader/beans/categary_item_bean.dart';
import 'package:flutter_reader/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BookListBloc extends BaseBloc {
  //
  final _bookListFetcher = PublishSubject<List<BookItemBean>>();

  //监听
  Observable<List<BookItemBean>> get bookListStream => _bookListFetcher.stream;

  void fetchBookList(String sex, String kind, int page) async {
    List<BookItemBean> datas = await netApi.fetchBookList(sex, kind, page);
    if (!_bookListFetcher.isClosed) {

      _bookListFetcher.sink.add(datas);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bookListFetcher?.close();
  }
}
