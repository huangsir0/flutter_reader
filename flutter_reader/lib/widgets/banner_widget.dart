import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/beans/banner_item_bean.dart';
import 'package:flutter_reader/pages/details/list_detail_page.dart';

Widget bannerWidget(BuildContext context, List<BannerItemBean> imgs) {
  return CarouselSlider(
      autoPlay: true,
      height: 160,
      items: imgs.map((img) {
        return Builder(builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ListDetialPage(listId: img.param);
                }));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: img.imgurl,
                ),
              ),
            ),
          );
        });
      }).toList());
}
