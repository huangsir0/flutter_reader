import 'package:flutter_reader/beans/banner_item_bean.dart';
import 'package:flutter_reader/beans/categary_item_bean.dart';
import 'package:flutter_reader/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BannerBloc extends BaseBloc {
  //
  final _bannerFetcher = PublishSubject<List<BannerItemBean>>();

  //监听
  Observable<List<BannerItemBean>> get categaryItems => _bannerFetcher.stream;

  void fetchBannerItems(String sex) async {
    List<BannerItemBean> datas = await netApi.fetchBannerItems(sex);
    if(!_bannerFetcher.isClosed){

      _bannerFetcher.sink.add(datas);
    }

  }


  @override
  void dispose() {
    // TODO: implement dispose
    _bannerFetcher?.close();
  }


}
