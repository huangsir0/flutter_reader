import 'package:flutter/material.dart';
import 'package:flutter_reader/common/global_stage.dart';
import 'package:flutter_reader/common/redux/theme_redux.dart';
import 'package:flutter_reader/common/utils/constans.dart';
import 'package:flutter_reader/common/utils/settings.dart';
import 'package:flutter_reader/pages/home/book_setting.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'home/book_rank.dart';
import 'home/book_shelf.dart';
import 'home/book_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  var _currenIndex = 0;


  var _tabs = ["书架", "书城", "排行榜", "设置"];

  List<BottomNavigationBarItem> _bottomBars;

  List<Widget> _pages;

  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomBars = [
      _initBottomItem(_tabs[0], MyIcons.shelfIcon, MyIcons.shelfIcon),
      _initBottomItem(_tabs[1], MyIcons.storeIcon, MyIcons.storeIcon),
      _initBottomItem(_tabs[2], MyIcons.rankIcon, MyIcons.rankIcon),
      _initBottomItem(_tabs[3], MyIcons.home_setting, MyIcons.home_setting),
    ];

    _pages = [
      BookShelf(),
      BookStore(),
      BookRank(),
      BookSettingPage(),
    ];
    _pageController = new PageController(initialPage: 0);

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _tabs.length,
        onPageChanged: (int index) {
          setState(() {
            _currenIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBars,
        currentIndex: _currenIndex,
        fixedColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _initBottomItem(
      String title, IconData icon, IconData activeIcon) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: Colors.black54,
        ),
        activeIcon: Icon(activeIcon),
        title: Text(title));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}
