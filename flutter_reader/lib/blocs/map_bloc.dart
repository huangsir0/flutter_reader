import 'package:flutter_reader/beans/store_sex_bean.dart';
import 'package:flutter_reader/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc extends BaseBloc {
  //
  final _mapFetcher = PublishSubject<Map>();

  //监听
  Observable<Map> get storeMap => _mapFetcher.stream;

  void fetchListDetailData(String listId) async {
    Map data = await netApi.fetchListDetailData(listId);
    if (!_mapFetcher.isClosed) {
      _mapFetcher.sink.add(data);
    }
  }

  Future<Map> fetchChaptersData(int bookId) async {
    return await netApi.fetchChaptersData(bookId);
  }

  Future<Map> fetchChapterData(int bookId, String chapterId) async {
    return await netApi.fetchChapterData(bookId, chapterId);
  }

  Future<Map> fetchCommentData(
      String topic_title, int topic_source_id, int page_size) async {
    return await netApi.getCommentData(topic_title, topic_source_id, page_size);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mapFetcher?.close();
  }
}
