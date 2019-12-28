import 'package:flutter_reader/beans/categary_item_bean.dart';
import 'package:flutter_reader/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CategaryBloc extends BaseBloc {
  //
  final _categarysFetcher = PublishSubject<List<CategaryItemBean>>();

  //监听
  Observable<List<CategaryItemBean>> get categaryItems => _categarysFetcher.stream;

  void fetchCategaryItems() async {
    List<CategaryItemBean> datas = await netApi.fetchCategoryData();
    if(!_categarysFetcher.isClosed){

      _categarysFetcher.sink.add(datas);
    }

  }


  @override
  void dispose() {
    // TODO: implement dispose
    _categarysFetcher?.close();
  }


}
