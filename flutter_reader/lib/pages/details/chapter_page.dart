import 'package:adsorptionview_flutter/adsorptionview_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_reader/beans/volume_bean.dart';
import 'package:flutter_reader/blocs/map_bloc.dart';
import 'package:flutter_reader/common/utils/constans.dart';
import 'package:flutter_reader/pages/details/read_page.dart';
import 'package:flutter_reader/widgets/draggable_scrollbar.dart';
import 'package:flutter_reader/widgets/loading_widget.dart';

class ChapterPage extends StatefulWidget {
  @override
  _ChapterPageState createState() => _ChapterPageState();

  final int bookId;

  final callBack;

  ChapterPage(this.bookId, this.callBack);
}

class _ChapterPageState extends State<ChapterPage>
    with AutomaticKeepAliveClientMixin {


  MapBloc _mapBloc =new MapBloc();

  List<VolumeBean> _volumes = [];
  List<ChapterBean> _chapters = [];
  ScrollController _rrectController = ScrollController();

  @override
  initState() {
    super.initState();
    _getChaptersData();
  }

  _getChaptersData() {
    _mapBloc.fetchChaptersData(widget.bookId).then((map) {
      for (int i = 0; i < map['data']['list'].length; i++) {
        _volumes.add(VolumeBean.fromMap(map['data']['list'][i]));
      }
      setState(() {
        for (int i = 0; i < _volumes.length; i++) {
          _chapters.add(
            ChapterBean(name: _volumes[i].name, isHeader: true, headerId: i),
          );
          _chapters.addAll(_volumes[i].list);
        }
      });
    });
  }

  void change(ChapterBean chapter) {
    if (widget.callBack != null) {
      widget.callBack(chapter);
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return ReadPage(
              widget.bookId,
              chapter: chapter,
            );
          }));
    }
  }

  Widget _chapterText(ChapterBean chapter) {
    return InkWell(
      onTap: () {
        change(chapter);
      },
      child: Container(
        height: 60,
        padding: EdgeInsets.only(left: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            chapter.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _chapters.length == 0
        ? WaitingWidget(color: Theme.of(context).primaryColor,)
        : Scaffold(
      body: DraggableScrollbar.rrect(
          controller: _rrectController,
          child: ListView.builder(
            cacheExtent: 100,
            controller: _rrectController,
            itemBuilder: (context, index) =>
                _chapterText(_chapters[index]),
            itemCount: _chapters.length,
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mapBloc.dispose();
  }
}
