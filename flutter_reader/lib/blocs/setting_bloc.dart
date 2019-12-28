import 'package:flutter_reader/beans/store_sex_bean.dart';
import 'package:flutter_reader/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SettingBloc extends BaseBloc {
  //
  final _setting = PublishSubject<bool>();




  //监听
  Observable<bool> get setting => _setting.stream;

  void changeBackState(bool isBack) {

    if (!_setting.isClosed) {

      _setting.sink.add(isBack);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _setting?.close();
  }
}
