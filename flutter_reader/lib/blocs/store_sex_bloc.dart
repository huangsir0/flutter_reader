import 'package:flutter_reader/beans/store_sex_bean.dart';
import 'package:flutter_reader/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class StoreSexBloc extends BaseBloc {
  //
  final _storeSexFetcher = PublishSubject<StoreSexBean>();

  //监听
  Observable<StoreSexBean> get storeSexData => _storeSexFetcher.stream;

  void fetchStoreSex(String sex) async {
    StoreSexBean data = await netApi.fetchStoreSexData(sex);
    if (!_storeSexFetcher.isClosed) {

      _storeSexFetcher.sink.add(data);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _storeSexFetcher?.close();
  }
}
