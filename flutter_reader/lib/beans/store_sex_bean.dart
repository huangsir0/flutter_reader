import 'package:flutter_reader/common/utils/constans.dart';

class StoreSexBean {
  int status;
  String info;
  List<Data> data;

  StoreSexBean({this.status, this.info, this.data});

  StoreSexBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    info = json['info'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['info'] = this.info;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String category;
  List<Books> books;
  List<Categories> categories;
  BookList bookList;

  Data({this.category, this.books, this.categories, this.bookList});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['Category'];
    if (json['Books'] != null) {
      books = new List<Books>();
      json['Books'].forEach((v) {
        books.add(new Books.fromJson(v));
      });
    }
    if (json['Categories'] != null) {
      categories = new List<Categories>();
      json['Categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    bookList = json['BookList'] != null
        ? new BookList.fromJson(json['BookList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Category'] = this.category;
    if (this.books != null) {
      data['Books'] = this.books.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['Categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.bookList != null) {
      data['BookList'] = this.bookList.toJson();
    }
    return data;
  }
}

class Books {
  int id;
  String name;
  String author;
  String img;
  String desc;
  String cName;
  String score;

  Books(
      {this.id,
        this.name,
        this.author,
        this.img,
        this.desc,
        this.cName,
        this.score});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    author = json['Author'];
    img = getCompleteImgUrl(json['Img'].toString()) ?? "";
    desc = json['Desc'];
    cName = json['CName'];
    score = json['Score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Author'] = this.author;
    data['Img'] = this.img;
    data['Desc'] = this.desc;
    data['CName'] = this.cName;
    data['Score'] = this.score;
    return data;
  }
}

class Categories {
  String categoryName;
  int categoryId;

  Categories({this.categoryName, this.categoryId});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryName = json['CategoryName'];
    categoryId = json['CategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryName'] = this.categoryName;
    data['CategoryId'] = this.categoryId;
    return data;
  }
}

class BookList {
  String imgUrl;
  int listId;
  String title;
  String description;

  BookList({this.imgUrl, this.listId, this.title, this.description});

  BookList.fromJson(Map<String, dynamic> json) {
    imgUrl = json['ImgUrl'];
    listId = json['ListId'];
    title = json['Title'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImgUrl'] = this.imgUrl;
    data['ListId'] = this.listId;
    data['Title'] = this.title;
    data['Description'] = this.description;
    return data;
  }
}