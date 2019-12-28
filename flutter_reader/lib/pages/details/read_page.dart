import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/beans/volume_bean.dart';
import 'package:flutter_reader/blocs/map_bloc.dart';
import 'package:flutter_reader/common/utils/constans.dart';
import 'package:flutter_reader/widgets/loading_widget.dart';

import 'catalog_page.dart';

class ReadPage extends StatefulWidget {
  ReadPage(this.bookId, {this.chapter});

  final int bookId;

  final ChapterBean chapter;

  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  final BookSqlite _bookSqlite = BookSqlite();

  double _letterSpace = 2.0;
  double _lineHeight = 2.0;
  double _titleFontSize = 30.0;
  double _contentFontSize = 18.0;
  bool _isShowMenu = false;

  bool _isDayMode = true;
  int _curPosition = 0;
  List<VolumeBean> _volumes = [];

  List<ChapterBean> _chapters = [];

  BookBean _book;
  double _progress = 0.0;

  bool _isAdd = false;

  String _content = "";

  MapBloc _mapBloc = new MapBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //查询是否已经添加过
    _bookSqlite.queryBookIsAdd(widget.bookId).then((isAdd) {
      _isAdd = isAdd;
      if (_isAdd) {
        _bookSqlite.getBook(widget.bookId).then((value) {
          _book = value;
        });
      }
    });
    _getChaptersData();
  }

  //获取章节信息
  _getChaptersData() {
    _mapBloc.fetchChaptersData(widget.bookId).then((map) {
      setState(() {
        //获取目录列表
        for (int i = 0; i < map['data']['list'].length; i++) {
          _volumes.add(VolumeBean.fromMap(map['data']['list'][i]));
        }

        for (int i = 0; i < _volumes.length; i++) {
          _chapters.add(
              ChapterBean(name: _volumes[i].name, isHeader: true, headerId: i));

          _chapters.addAll(_volumes[i].list);
        }

        if (widget.chapter != null) {
          //目录跳转
          if (widget.chapter.isHeader) {
            for (int i = 0; i < _chapters.length; i++) {
              if (_chapters[i].isHeader &&
                  _chapters[i].headerId == widget.chapter.headerId) {
                _curPosition = i;
              }
            }
          } else {
            //章
            for (int i = 0; i < _chapters.length; i++) {
              if (widget.chapter.id.toString() == _chapters[i].id.toString()) {
                _curPosition = i;
              }
            }
          }
        } else {
          //直接阅读
          print("直接阅读");
          if (_isAdd) {
            _curPosition = _book.position;
          }
        }
        _getChapterData();
      });
    });
  }

  _getChapterData() {
    setState(() {
      _progress = _curPosition / _chapters.length;
      print("阅读位置$_curPosition");
      print("阅读进度$_progress");
    });
    if (_chapters[_curPosition].isHeader) {
      setState(() {
        _content = "点击左右侧翻页";
      });
    } else {
      _mapBloc
          .fetchChapterData(
              widget.bookId, _chapters[_curPosition].id.toString())
          .then((map) {
            _scrollController?.jumpTo(0);
        setState(() {
          _content = map['data']['content'].toString();
        });
      });

      if (_isAdd) {
        _updateReadProgress();
      }
    }
  }

  void _updateReadProgress() {
    _book.position = _curPosition;
    _bookSqlite.update(_book).then((result) {
      if (1 == result) {
        print("更新阅读进度${_book.position}");
      }
    });
  }

  Widget _contentView() {
    return Container(
      child: Text(
        _content,
        style: TextStyle(
            color: _isDayMode
                ? AppColors.DayModeTextColor
                : AppColors.NightModeTextColor,
            height: _lineHeight,
            fontSize: _contentFontSize,
            letterSpacing: _letterSpace),
      ),
    );
  }

  Widget _titleView() {
    return Text(
      _chapters[_curPosition].name,
      style: TextStyle(
          color: _isDayMode
              ? AppColors.DayModeTextColor
              : AppColors.NightModeTextColor,
          fontSize: _titleFontSize,
          letterSpacing: 2),
    );
  }

  void onChange(ChapterBean chapter) {
    setState(() {
      if (chapter != null) {
        //目录跳转
        if (chapter.isHeader) {
          //卷
          for (int i = 0; i < _chapters.length; i++) {
            if (_chapters[i].isHeader &&
                _chapters[i].headerId == chapter.headerId) {
              _curPosition = i;
            }
          }
        } else {
          //章
          for (int i = 0; i < _chapters.length; i++) {
            if (chapter.id.toString() == _chapters[i].id.toString()) {
              _curPosition = i;
            }
          }
          _getChapterData();
        }
      }
    });
  }

  Widget iconTitle(
      BuildContext context, IconData iconData, String title, int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Scaffold.of(context).openDrawer();
            break;
          case 1:
            setState(() {
              _isDayMode = !_isDayMode;
            });
            break;
          case 2:
            _isShowMenu = !_isShowMenu;
            _isShowMenu
                ? SystemChrome.setEnabledSystemUIOverlays(
                    [SystemUiOverlay.top, SystemUiOverlay.bottom])
                : SystemChrome.setEnabledSystemUIOverlays([]);
            showSheet(context);
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 10),
        child: Column(
          children: <Widget>[
            Icon(
              iconData,
              color: _isDayMode
                  ? AppColors.DayModeIconTitleButtonColor
                  : AppColors.NightModeIconTitleButtonColor,
            ),
            Text(
              title,
              style: TextStyle(
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: _isDayMode
              ? AppColors.DayModeMenuBgColor
              : AppColors.NightModeMenuBgColor,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              controlContentTextSize(),
              controlTitleTextSize(),
              controlLineHeight(),
              controlLetterSpace(),
            ],
          ),
        );
      },
    );
  }

  Widget controlContentTextSize() {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Text(
              "正文字体",
              style: TextStyle(
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.remove,
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
              onPressed: () {
                setState(() {
                  _contentFontSize--;
                });
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.add,
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
              onPressed: () {
                setState(() {
                  _contentFontSize++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget controlTitleTextSize() {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              "标题字体",
              style: TextStyle(
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.remove,
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
              onPressed: () {
                setState(() {
                  _titleFontSize--;
                });
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.add,
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
              onPressed: () {
                setState(() {
                  _titleFontSize++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget controlLineHeight() {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              "行高",
              style: TextStyle(
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.remove,
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
              onPressed: () {
                setState(() {
                  _lineHeight--;
                });
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.add,
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
              onPressed: () {
                setState(() {
                  _lineHeight++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget controlLetterSpace() {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              "间距",
              style: TextStyle(
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.remove,
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
              onPressed: () {
                setState(() {
                  _letterSpace--;
                });
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Icon(
                Icons.add,
                color: _isDayMode
                    ? AppColors.DayModeIconTitleButtonColor
                    : AppColors.NightModeIconTitleButtonColor,
              ),
              onPressed: () {
                setState(() {
                  _letterSpace++;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _topMenu() {
    return Container(
        color: _isDayMode
            ? AppColors.DayModeMenuBgColor
            : AppColors.NightModeMenuBgColor,
        height: kToolbarHeight + MediaQuery.of(context).padding.top,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        child: Padding(padding: EdgeInsets.only(top: 20),
        child: IconButton(
          icon: Icon(
            MyIcons.backIcon,
            size: 24,
            color: _isDayMode
                ? AppColors.DayModeIconTitleButtonColor
                : AppColors.NightModeIconTitleButtonColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),));
  }

  Widget _bottomMenu() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: _isDayMode
          ? AppColors.DayModeMenuBgColor
          : AppColors.NightModeMenuBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  _loadPre();
                },
                child: Text(
                  "上一章",
                  style: TextStyle(
                    color: _isDayMode
                        ? AppColors.DayModeIconTitleButtonColor
                        : AppColors.NightModeIconTitleButtonColor,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _loadNext();
                },
                child: Text(
                  "下一章",
                  style: TextStyle(
                    color: _isDayMode
                        ? AppColors.DayModeIconTitleButtonColor
                        : AppColors.NightModeIconTitleButtonColor,
                  ),
                ),
              )
            ],
          ),
          //这里有目录路由，所以套一层Builder
          Builder(
            builder: (context) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                iconTitle(context, Icons.menu, "目录", 0),
                iconTitle(context, Icons.tonality, _isDayMode ? "夜间" : "日间", 1),
                iconTitle(context, Icons.text_format, "设置", 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reader() {
    return Container(
      color: _isDayMode ? AppColors.DayModeBgColor : AppColors.NightModeBgColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: kToolbarHeight,
              ),
              child: _content == "点击左右侧翻页"
                  ? Center(
                      child: _titleView(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _titleView(),
                        _contentView(),
                      ],
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _loadPre();
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _loadNext();
                  },
                ),
              )
            ],
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isShowMenu = !_isShowMenu;
                    _isShowMenu
                        ? SystemChrome.setEnabledSystemUIOverlays(
                            [SystemUiOverlay.top, SystemUiOverlay.bottom])
                        : SystemChrome.setEnabledSystemUIOverlays([]);
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _loadPre() {
    if (_curPosition != 0) {
      setState(() {
        _curPosition--;
        _getChapterData();
      });
    }
  }

  _loadNext() {
    if (_curPosition != _chapters.length - 1) {
      setState(() {
        _curPosition++;
        _getChapterData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _chapters.length == 0
        ? Material(
            child: WaitingWidget(
              color: Theme.of(context).primaryColor,
            ),
          )
        : Scaffold(
            drawer: Drawer(
              child: CatalogPage(
                widget.bookId,
                callBack: (ChapterBean chapter) => onChange(chapter),
              ),
            ),
            body: Stack(
              children: <Widget>[
                reader(),
                _isShowMenu
                    ? Positioned(
                        child: _topMenu(),
                        top: 0,
                      )
                    : Container(),
                _isShowMenu
                    ? Positioned(
                        child: _bottomMenu(),
                        bottom: 0,
                      )
                    : Container(),
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

    _bookSqlite.close();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    _mapBloc.dispose();
    super.dispose();
  }
}
