import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/categary_item_bean.dart';
import 'package:flutter_reader/common/utils/constans.dart';
import 'package:flutter_reader/pages/details/category_rank_page.dart';

Widget categoryItem(
    BuildContext context, int index, CategaryItemBean category) {
  return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return CategoryRankPage(
              categoryId: category.id, categoryName: category.name);
        }));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          getCompleteImgUrl(
                              "${StringConstants.categoryImages[index]}.jpg"),
                        ),
                        fit: BoxFit.cover),
                  )),
              borderRadius: BorderRadius.all(Radius.circular(1)),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                category.name,
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ));
}
