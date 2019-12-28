/// name : "作品相关"
/// list : [{"id":4785213,"name":"新书即将开始了","hasContent":0},{"id":4785214,"name":"上架了,求订阅,求月票!","hasContent":0},null]
import 'package:adsorptionview_flutter/adsorptiondatabin.dart';

/// list : [{"id":4785213,"name":"新书即将开始了","hasContent":0},{"id":4785214,"name":"上架了,求订阅,求月票!","hasContent":0},null]

/// list : [{"id":4785213,"name":"新书即将开始了","hasContent":0},{"id":4785214,"name":"上架了,求订阅,求月票!","hasContent":0},null]

/// list : [{"id":4785213,"name":"新书即将开始了","hasContent":0},{"id":4785214,"name":"上架了,求订阅,求月票!","hasContent":0},null]

/// list : [{"id":4785213,"name":"新书即将开始了","hasContent":0},{"id":4785214,"name":"上架了,求订阅,求月票!","hasContent":0},null]

/// list : [{"id":4785213,"name":"新书即将开始了","hasContent":0},{"id":4785214,"name":"上架了,求订阅,求月票!","hasContent":0},null]

/// list : [{"id":4785213,"name":"新书即将开始了","hasContent":0},{"id":4785214,"name":"上架了,求订阅,求月票!","hasContent":0},null]

/// list : [{"id":4785213,"name":"新书即将开始了","hasContent":0},{"id":4785214,"name":"上架了,求订阅,求月票!","hasContent":0},null]

/// list : [{"id":4785213,"name":"新书即将开始了","hasContent":0},{"id":4785214,"name":"上架了,求订阅,求月票!","hasContent":0},null]

/// list : [{"id":4785213,"name":"新书即将开始了","hasContent":0},{"id":4785214,"name":"上架了,求订阅,求月票!","hasContent":0},null]

class VolumeBean {
  String name;
  List<ChapterBean> list;

  static VolumeBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VolumeBean volumeBean = VolumeBean();
    volumeBean.name = map['name'];
    volumeBean.list = List()
      ..addAll((map['list'] as List ?? []).map((o) => ChapterBean.fromMap(o)));
    return volumeBean;
  }
}

/// id : 4785213
/// name : "新书即将开始了"
/// hasContent : 0

class ChapterBean extends AdsorptionData {
  int id;
  String name;
  int hasContent;
  bool isHeader;
  int headerId;

  ChapterBean({this.name, this.isHeader, this.headerId});

  static ChapterBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChapterBean listBean = ChapterBean();
    listBean.id = map['id'];
    listBean.name = map['name'];
    listBean.hasContent = map['hasContent'];
    listBean.isHeader = false;
    listBean.headerId = -1;
    return listBean;
  }
}
