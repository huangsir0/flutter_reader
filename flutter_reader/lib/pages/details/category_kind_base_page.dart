import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/blocs/category_kind_bloc.dart';
import 'package:flutter_reader/widgets/book_item.dart';
import 'package:flutter_reader/widgets/loading_widget.dart';

class CategoryKindBasePage extends StatefulWidget {
  final String categoryId;
  final String kind;

  const CategoryKindBasePage({Key key, this.categoryId, this.kind})
      : super(key: key);

  @override
  _CategoryKindBasePageState createState() => _CategoryKindBasePageState();
}

class _CategoryKindBasePageState extends State<CategoryKindBasePage>
    with AutomaticKeepAliveClientMixin {
  CategoryKindBaseBloc _kindBaseBloc = new CategoryKindBaseBloc();

  ScrollController _scrollController = new ScrollController();

  //当前是否加载更多
  bool _isLoadMore = false;
  List<BookBean> _books = List();

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  //当前页
  int _curPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoadMore = false;
    _books.clear();
    _kindBaseBloc.fetchCategoryRank(widget.categoryId, widget.kind, _curPage);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<List<BookBean>> centent) {
          if (centent.hasData) {
            if (!_isLoadMore) {
              _books.clear();
            }
            _books.addAll(centent.data);
            return EasyRefresh(
              key: _easyRefreshKey,
              child: ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return bookBeanItem(context, _books[index], false);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Theme.of(context).primaryColor,
                      height: 10,
                    );
                  },
                  itemCount: _books.length),
              refreshHeader: ClassicsHeader(
                  key: _headerKey,
                  refreshText: "下拉刷新",
                  refreshReadyText: "释放刷新",
                  refreshingText: "刷新中...",
                  refreshedText: "刷新结束",
                  bgColor: Colors.white,
                  textColor: Theme.of(context).primaryColor,
                  refreshHeight: 40.0,
                  moreInfo: "上次更新 %T"),
              refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  loadText: "上拉加载",
                  loadReadyText: "松手加载",
                  loadingText: "加载中...",
                  loadedText: "加载完成",
                  bgColor: Colors.white,
                  textColor: Theme.of(context).primaryColor,

                  loadHeight: 40.0,
                  moreInfo: "上次加载 %T"),
              onRefresh: () async {
                _isLoadMore = false;
                _curPage = 1;
                _kindBaseBloc.fetchCategoryRank(
                    widget.categoryId, widget.kind, _curPage);
              },
              loadMore: () async {
                _isLoadMore = true;
                _curPage++;
                _kindBaseBloc.fetchCategoryRank(
                    widget.categoryId, widget.kind, _curPage);
              },
            );
          } else {
            return Center(
              child: WaitingWidget(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        },
        stream: _kindBaseBloc.bookListStream,
      ),
    );
  }

  @override
// TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _kindBaseBloc.dispose();
  }
}
