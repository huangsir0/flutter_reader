import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/categary_item_bean.dart';
import 'package:flutter_reader/blocs/categary_bloc.dart';
import 'package:flutter_reader/widgets/category_item.dart';
import 'package:flutter_reader/widgets/loading_widget.dart';
import 'package:flutter_reader/widgets/reload_widget.dart';

class CategaryPage extends StatefulWidget {
  @override
  _CategaryPageState createState() => _CategaryPageState();
}

class _CategaryPageState extends State<CategaryPage>
    with AutomaticKeepAliveClientMixin {
  CategaryBloc _categaryBloc = new CategaryBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categaryBloc.fetchCategaryItems();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StreamBuilder(
          stream: _categaryBloc.categaryItems,
          builder: (BuildContext context,
              AsyncSnapshot<List<CategaryItemBean>> content) {
            if (content.hasData) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: GridView.count(crossAxisCount: 3,shrinkWrap: true,
                  crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    //宽高比
                    childAspectRatio: 1.7 / 3,
                    children: content.data.map((data){
                      return categoryItem(
                          context, content.data.indexOf(data), data);
                    }).toList(),
                  ),
                );
            } else if (content.data == null &&
                content.connectionState == ConnectionState.active) {
              return ReloadWidget(refresh: _refresh);
            } else {
              return WaitingWidget(color: Theme
                  .of(context)
                  .primaryColor,);
            }
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categaryBloc.dispose();
  }

  Future<void> _refresh() {
    _categaryBloc.fetchCategaryItems();
    return null;
  }
}
