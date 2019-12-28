import 'package:flutter/material.dart';

import 'category_kind_base_page.dart';

class CategoryRankPage extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryRankPage({Key key, this.categoryId, this.categoryName})
      : super(key: key);

  @override
  _CategoryRankPageState createState() => _CategoryRankPageState();
}

class _CategoryRankPageState extends State<CategoryRankPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<String> _titles = ["最热", "最新", "评分", "完结"];

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _titles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.categoryName,style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            tabs: _titles.map((title) {
              return Tab(
                text: title,
              );
            }).toList(),
            indicatorColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black54,
            labelColor: Theme.of(context).primaryColor,
            controller: _tabController,
          ),
          Expanded(
              child: TabBarView(
            children: [
              CategoryKindBasePage(categoryId:widget.categoryId, kind:"hot"),
              CategoryKindBasePage(categoryId:widget.categoryId, kind:"new"),
              CategoryKindBasePage(categoryId:widget.categoryId, kind:"vote"),
              CategoryKindBasePage(categoryId:widget.categoryId, kind:"over"),
            ],
            controller: _tabController,
          ))
        ],
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
    _tabController.dispose();
  }
}
