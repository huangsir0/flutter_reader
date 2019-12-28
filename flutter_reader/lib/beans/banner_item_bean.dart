class BannerItemBean {
  String type;
  String param;
  String imgurl;

  BannerItemBean({this.type, this.param, this.imgurl});

  BannerItemBean.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    param = json['param'];
    imgurl = json['imgurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['param'] = this.param;
    data['imgurl'] = this.imgurl;
    return data;
  }
}