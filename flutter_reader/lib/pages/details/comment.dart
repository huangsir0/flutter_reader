import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/book_info_bean.dart';
import 'package:flutter_reader/beans/comment_bean.dart';
import 'package:flutter_reader/blocs/map_bloc.dart';
import 'package:flutter_reader/widgets/comment_item.dart';
import 'package:flutter_reader/widgets/loading_widget.dart';


class CommentPage extends StatefulWidget {
  final BookInfoBean bookInfo;

  CommentPage({Key key, this.bookInfo}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  Comment _comment;

  MapBloc _mapBloc= new MapBloc();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mapBloc.dispose();
    _getCommentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("评论"),
      ),
      body: _comment == null
          ? WaitingWidget()
          : RefreshIndicator(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return commentItem(context, _comment.comments[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1.0,
                  color: Colors.black12,
                );
              },
              itemCount: _comment.comments.length),
          onRefresh: _onRefresh),
    );
  }

  void _getCommentData() {
    _mapBloc.fetchCommentData(widget.bookInfo.data.name, widget.bookInfo.data.id, 100).then((map) {
      setState(() {
        _comment = null;
        _comment = Comment.fromMap(map);
      });
    });
  }



  Future<void> _onRefresh() async {
    _getCommentData();
    return;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mapBloc.dispose();
  }
}
