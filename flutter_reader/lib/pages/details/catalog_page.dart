import 'package:flutter/material.dart';

import 'chapter_page.dart';

class CatalogPage extends StatefulWidget {
  final int bookId;

  final callBack;

  CatalogPage(this.bookId, {this.callBack});

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: widget.callBack == null
            ? Theme.of(context).primaryColor
            : Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "目录",
          style: TextStyle(
              color: widget.callBack == null
                  ? Colors.white
                  : Theme.of(context).primaryColor),
        ),
      ),
      body: ChapterPage(widget.bookId, widget.callBack),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
