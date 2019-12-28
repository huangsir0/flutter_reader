import 'package:flutter_reader/common/utils/constans.dart';

class BookInfoBean {
  int status;
  String info;
  Data data;

  BookInfoBean({this.status, this.info, this.data});

  BookInfoBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    info = json['info'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['info'] = this.info;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String img;
  String author;
  String desc;
  int cId;
  String cName;
  String lastTime;
  int firstChapterId;
  String lastChapter;
  int lastChapterId;
  String bookStatus;
  List<SameUserBooks> sameUserBooks;
  List<SameCategoryBooks> sameCategoryBooks;
  BookVote bookVote;

  Data(
      {this.id,
        this.name,
        this.img,
        this.author,
        this.desc,
        this.cId,
        this.cName,
        this.lastTime,
        this.firstChapterId,
        this.lastChapter,
        this.lastChapterId,
        this.bookStatus,
        this.sameUserBooks,
        this.sameCategoryBooks,
        this.bookVote});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    img = getCompleteImgUrl(json['Img'].toString()) ?? "";
    author = json['Author'];
    desc = json['Desc'];
    cId = json['CId'];
    cName = json['CName'];
    lastTime = json['LastTime'];
    firstChapterId = json['FirstChapterId'];
    lastChapter = json['LastChapter'];
    lastChapterId = json['LastChapterId'];
    bookStatus = json['BookStatus'];
    if (json['SameUserBooks'] != null) {
      sameUserBooks = new List<SameUserBooks>();
      json['SameUserBooks'].forEach((v) {
        sameUserBooks.add(new SameUserBooks.fromJson(v));
      });
    }
    if (json['SameCategoryBooks'] != null) {
      sameCategoryBooks = new List<SameCategoryBooks>();
      json['SameCategoryBooks'].forEach((v) {
        sameCategoryBooks.add(new SameCategoryBooks.fromJson(v));
      });
    }
    bookVote = json['BookVote'] != null
        ? new BookVote.fromJson(json['BookVote'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Img'] = this.img;
    data['Author'] = this.author;
    data['Desc'] = this.desc;
    data['CId'] = this.cId;
    data['CName'] = this.cName;
    data['LastTime'] = this.lastTime;
    data['FirstChapterId'] = this.firstChapterId;
    data['LastChapter'] = this.lastChapter;
    data['LastChapterId'] = this.lastChapterId;
    data['BookStatus'] = this.bookStatus;
    if (this.sameUserBooks != null) {
      data['SameUserBooks'] =
          this.sameUserBooks.map((v) => v.toJson()).toList();
    }
    if (this.sameCategoryBooks != null) {
      data['SameCategoryBooks'] =
          this.sameCategoryBooks.map((v) => v.toJson()).toList();
    }
    if (this.bookVote != null) {
      data['BookVote'] = this.bookVote.toJson();
    }
    return data;
  }
}

class SameUserBooks {
  int id;
  String name;
  String author;
  String img;
  int lastChapterId;
  String lastChapter;
  double score;

  SameUserBooks(
      {this.id,
        this.name,
        this.author,
        this.img,
        this.lastChapterId,
        this.lastChapter,
        this.score});

  SameUserBooks.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    author = json['Author'];
    img = json['Img'];
    lastChapterId = json['LastChapterId'];
    lastChapter = json['LastChapter'];
    score = json['Score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Author'] = this.author;
    data['Img'] = this.img;
    data['LastChapterId'] = this.lastChapterId;
    data['LastChapter'] = this.lastChapter;
    data['Score'] = this.score;
    return data;
  }
}

class SameCategoryBooks {
  int id;
  String name;
  String img;
  double score;

  SameCategoryBooks({this.id, this.name, this.img, this.score});

  SameCategoryBooks.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    img = getCompleteImgUrl(json['Img'].toString()) ?? "";
    score = json['Score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Img'] = this.img;
    data['Score'] = this.score;
    return data;
  }
}

class BookVote {
  int bookId;
  int totalScore;
  int voterCount;
  double score;

  BookVote({this.bookId, this.totalScore, this.voterCount, this.score});

  BookVote.fromJson(Map<String, dynamic> json) {
    bookId = json['BookId'];
    totalScore = json['TotalScore'];
    voterCount = json['VoterCount'];
    score = json['Score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookId'] = this.bookId;
    data['TotalScore'] = this.totalScore;
    data['VoterCount'] = this.voterCount;
    data['Score'] = this.score;
    return data;
  }
}