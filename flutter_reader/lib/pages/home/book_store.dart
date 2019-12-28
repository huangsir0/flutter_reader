import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reader/common/utils/screen.dart';
import 'package:flutter_reader/pages/details/categary_page.dart';
import 'package:flutter_reader/pages/store/list_page.dart';
import 'package:flutter_reader/pages/store/sex_page.dart';

class BookStore extends StatefulWidget {
  @override
  _BookStoreState createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<String> _tabTitles = ["男生", "女生", "分类", "专题"];

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: _tabTitles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Text(
                  "书城",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 26,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 10),
                child: TabBar(
                  tabs: _tabTitles.map((title) {
                    return Tab(text: title);
                  }).toList(),
                  labelStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: 16),
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.black54,
                  controller: _tabController,
                ),
              ))
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: TabBarView(
            children: [
              SexPage(sex: "man"),
              SexPage(sex: "lady"),
              CategaryPage(),
              ListPage(),
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
}
