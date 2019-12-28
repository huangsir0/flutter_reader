import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/blocs/book_bloc.dart';
import 'package:flutter_reader/common/utils/constans.dart';
import 'package:flutter_reader/widgets/book_item.dart';
import 'package:flutter_reader/widgets/loading_widget.dart';

class BookRank extends StatefulWidget {
  @override
  _BookRankState createState() => _BookRankState();
}

class _BookRankState extends State<BookRank>
    with AutomaticKeepAliveClientMixin {
  List<String> _sexTitles = ["男生", "女生"];

  List<String> _sexs = ["man", "lady"];

  List<String> _kindTitles = ["最热", "推荐", "完结", "收藏", "新书", "评分"];

  List<String> _Kinds = ['hot', 'commend', "over", "collect", 'new', 'vote'];

  List<String> _timeTitles = ["周榜", "月榜", "总榜"];

  List<String> _times = ["week", "month", "total"];

  String _curSex = 'man';

  String _curKind = 'hot';

  String _curTime = 'week';

  int _curPage = 1;

  List<BookBean> _books = List();

  BookBloc _bookBloc = new BookBloc();

  bool _isLoadMore = false;

  final _scrollController = ScrollController();
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(

        body: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 40, left: 20,right: 10),
                height: kToolbarHeight + 20,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "排行榜",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                    IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(
                        MyIcons.searchIcon,
                        color:Theme.of(context).primaryColor,
                        size: 30,
                      ),
                      onPressed: () {
                        toast("跳转到搜索页面。。。", Theme.of(context).primaryColor);
                      },
                    )
                  ],
                )),
            _choiceGroup(),
            Expanded(
              child: StreamBuilder(
                  stream: _bookBloc.categaryItems,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<BookBean>> snapshot) {
                    if (snapshot.hasData) {
                      if (!_isLoadMore) _books.clear();
                      _books.addAll(snapshot.data);
                      return EasyRefresh(
                        key: _easyRefreshKey,
                        refreshHeader: ClassicsHeader(
                          moreInfoColor: Theme.of(context).primaryColor,
                          bgColor: Colors.white10,
                          textColor: Theme.of(context).primaryColor,
                          key: _headerKey,
                          refreshText: "用力一点",
                          refreshReadyText: "释放",
                          refreshingText: "刷新中",
                          refreshedText: "刷新完成",
                          moreInfo: "上次刷新: %T",
                          showMore: true,
                        ),
                        refreshFooter: ClassicsFooter(
                          moreInfoColor: Theme.of(context).primaryColor,
                          bgColor: Colors.white10,
                          textColor: Theme.of(context).primaryColor,
                          key: _footerKey,
                          loadText: "用力一点",
                          loadReadyText: "释放",
                          loadingText: "加载中",
                          loadedText: "加载完成",
                          moreInfo: "上次加载：%T",
                          showMore: true,
                        ),
                        child: ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return bookBeanItem(
                                  context, _books[index], false);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                color: Theme.of(context).primaryColor,
                                height: 2,
                              );
                            },
                            itemCount: _books.length),
                        onRefresh: () async {
                          _initData();
                        },
                        loadMore: () async {
                          _curPage++;
                          _bookBloc.fetchBookRank(
                              _curSex, _curKind, _curTime, _curPage);
                        },
                      );
                    } else {
                      return Center(
                        child: WaitingWidget(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                  }),
            )
          ],
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bookBloc.dispose();
  }

  Widget _choiceGroup() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, bottom: 10.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: _getItemWidgets(_sexTitles, _sexs, _curSex, (sex) {
              _curSex = sex;
              _initData();
              print(_curSex);
            }).toList(),
          ),
          Row(
            children: _getItemWidgets(_kindTitles, _Kinds, _curKind, (kind) {
              _curKind = kind;
              _initData();
              print(_curKind);
            }).toList(),
          ),
          Row(
            children: _getItemWidgets(_timeTitles, _times, _curTime, (time) {
              _curTime = time;
              _initData();
              print(_curTime);
            }).toList(),
          )
        ],
      ),
    );
  }

  Iterable<Widget> _getItemWidgets(
      List<String> showTitles,
      List<String> trueTitles,
      String current,
      ValueChanged<String> onSelect) sync* {
    for (String title in trueTitles) {
      yield Container(
        margin: EdgeInsets.only(right: 6.0),
        child: ChoiceChip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          selectedColor: Theme.of(context).primaryColor.withOpacity(0.8),
          backgroundColor:Colors.grey[500] ,
          label: Text(
            showTitles[trueTitles.indexOf(title)],
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w200, color: Colors.white),
          ),
          selected: current == title,
          onSelected: (bool value) {
            if (onSelect != null) {
              setState(() {});
              onSelect(title);
            }
          },
        ),
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _initData() {
    _isLoadMore = false;
    _curPage = 1;
    _bookBloc.fetchBookRank(_curSex, _curKind, _curTime, _curPage);
  }
}
