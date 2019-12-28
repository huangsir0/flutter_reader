class CategaryItemBean {
  String id;
  String name;
  int count;

  CategaryItemBean({this.id, this.name, this.count});

  CategaryItemBean.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    count = json['Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Count'] = this.count;
    return data;
  }
}