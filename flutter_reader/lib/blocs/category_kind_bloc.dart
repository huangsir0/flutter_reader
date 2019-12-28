
import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';


class CategoryKindBaseBloc extends BaseBloc {
  //
  final _categoryFetcher = PublishSubject<List<BookBean>>();

  //监听
  Observable<List<BookBean>> get bookListStream => _categoryFetcher.stream;

  void fetchCategoryRank(String categoryId, String kind, int page) async {
    List<BookBean> datas = await netApi.fetchCategoryRankData(categoryId, kind, page);
    if (!_categoryFetcher.isClosed) {

      _categoryFetcher.sink.add(datas);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _categoryFetcher?.close();
  }
}
