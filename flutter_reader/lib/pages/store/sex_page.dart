import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/banner_item_bean.dart';
import 'package:flutter_reader/beans/store_sex_bean.dart';
import 'package:flutter_reader/blocs/banner_bloc.dart';
import 'package:flutter_reader/blocs/store_sex_bloc.dart';
import 'package:flutter_reader/widgets/banner_widget.dart';
import 'package:flutter_reader/widgets/loading_widget.dart';
import 'package:flutter_reader/widgets/reload_widget.dart';
import 'package:flutter_reader/widgets/store_item.dart';

class SexPage extends StatefulWidget {
  final String sex;

  const SexPage({Key key, this.sex}) : super(key: key);

  @override
  _SexPageState createState() => _SexPageState();
}

class _SexPageState extends State<SexPage> with AutomaticKeepAliveClientMixin {
  BannerBloc _bannerBloc = new BannerBloc();

  StoreSexBloc _storeSexBloc = new StoreSexBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerBloc.fetchBannerItems(widget.sex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(

        child: StreamBuilder(
      builder:
          (BuildContext context, AsyncSnapshot<List<BannerItemBean>> banner) {
        if (banner.hasData) {
          _storeSexBloc.fetchStoreSex(widget.sex);
          return RefreshIndicator(
            displacement: 0,
              color: Theme.of(context).primaryColor,
              child: StreamBuilder(
                builder: (BuildContext context,
                    AsyncSnapshot<StoreSexBean> content) {
                  if (content.hasData) {
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              bannerWidget(context, banner.data),
                              storeItem(context, content.data.data[0].category,
                                  content.data.data[0].books),
                            ],
                          );
                        } else {
                          return storeItem(
                              context,
                              content.data.data[index].category,
                              content.data.data[index].books);
                        }
                      },
                      itemCount: content.data.data.length,
                    );
                  } else if (content.connectionState ==
                          ConnectionState.active &&
                      content.data == null) {
                    return ReloadWidget(refresh: _refresh);
                  } else {
                    return WaitingWidget(color: Theme.of(context).primaryColor);
                  }
                },
                stream: _storeSexBloc.storeSexData,
              ),
              onRefresh: _refresh);
        } else if (banner.connectionState == ConnectionState.active &&
            banner.data == null) {
          return ReloadWidget(refresh: _refresh);
        } else {
          return WaitingWidget(color: Theme.of(context).primaryColor);
        }
      },
      stream: _bannerBloc.categaryItems,
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerBloc.dispose();
    _storeSexBloc.dispose();
  }

  Future<void> _refresh() async {
    _bannerBloc.fetchBannerItems(widget.sex);
    _storeSexBloc.fetchStoreSex(widget.sex);
  }
}
