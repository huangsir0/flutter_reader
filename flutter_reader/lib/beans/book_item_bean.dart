
import 'package:flutter_reader/common/utils/constans.dart';

/// ListId : 24119
/// UserName : "19946785421"
/// ForMan : true
/// Cover : "bianshenzhiwozhenbushiNPC.jpg"
/// Title : "变身，同人，无限流，亲身试毒，本本精品！"
/// Description : "变身，同人，无限流，亲身试毒，本本精品！"
/// BookCount : 9
/// CollectionCount : 0
/// CommendCount : 0
/// IsCheck : true
/// AddTime : "2019/05/20 06:39:25"
/// UpdateTime : "2019/05/20 08:19:12"

class BookItemBean {
  int ListId;
  String UserName;
  bool ForMan;
  String Cover;
  String Title;
  String Description;
  int BookCount;
  int CollectionCount;
  int CommendCount;
  bool IsCheck;
  String AddTime;
  String UpdateTime;

  static BookItemBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookItemBean bookList = BookItemBean();
    bookList.ListId = map['ListId'];
    bookList.UserName = map['UserName'] ?? "";
    bookList.ForMan = map['ForMan'];
    bookList.Cover = getCompleteImgUrl(map['Cover'].toString());
    bookList.Title = map['Title'] ?? "";
    bookList.Description = map['Description'] ?? "";
    bookList.BookCount = map['BookCount'];
    bookList.CollectionCount = map['CollectionCount'];
    bookList.CommendCount = map['CommendCount'];
    bookList.IsCheck = map['IsCheck'];
    bookList.AddTime = map['AddTime'] ?? "";
    bookList.UpdateTime = map['UpdateTime'] ?? "";
    return bookList;
  }
}
