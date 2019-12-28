
import 'package:flutter_reader/common/utils/constans.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


/// status : 1
/// info : "success"
/// data : [{"Id":"146769","Name":"剑来","Author":"烽火戏诸侯","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/jianlai.jpg","Desc":"大千世界，无奇不有。我陈平安，唯有一剑，可搬山，倒海，降妖，镇魔，敕神，摘星，断江，摧城，开天！","BookStatus":"连载","LastChapterId":"7774558","LastChapter":"第五百五十一章 真人一到便叩关","CName":"玄幻奇幻","UpdateTime":"2019-05-19 00:00:00"},{"Id":"321763","Name":"剑来也","Author":"古月的春天","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/jianlaiye.jpg","Desc":"这是一个小小少年因缘际会，持一把破烂铁剑，踏上问天之路的故事。","BookStatus":"连载","LastChapterId":"1724907","LastChapter":"给你","CName":"玄幻奇幻","UpdateTime":"2018-09-10 00:00:00"},{"Id":"295380","Name":"剑来疯","Author":"一介武夫1","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/jianlaifeng.jpg","Desc":"“漫漫雪中夜，有两人相伴，倒也不错。”黄去病蹲坐了下来，用手中竹剑拍打着雪地，像是一颗颗麻子。\n　　师傅，公子，钰儿师姐，铃铃姑娘，这次我可能真的要死了呐。","BookStatus":"连载","LastChapterId":"1597299","LastChapter":"冬湖","CName":"武侠仙侠","UpdateTime":"2018-07-10 00:00:00"},{"Id":"292445","Name":"剑来封天","Author":"洗星辰","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/jianlaifengtian.jpg","Desc":"【【网文之王玄幻“BOSS流”征文】参赛作品】神秘剑修创下剑来宗后不知所踪，是阴谋的使成还是希望的火种？一群少年逆天而行，无依无靠，风雨同舟，谱写大世凄凉，体验世事沧桑，一切尽在——剑来封天！百里奚：万里群山，大雪纷飞，冰天雪地，百宗围困，我自为你弹奏一曲，来世我们再续前缘！秋枫：此生此世，红枫尽头我独处，万里孤冢我伴你！小林子：滚滚红尘，携你一抹青","BookStatus":"连载","LastChapterId":"1704098","LastChapter":"第180章 一魔镇千州,怒问仙神何处有 下","CName":"玄幻奇幻","UpdateTime":"2018-09-30 00:00:00"},{"Id":"328433","Name":"剑来山河","Author":"赵小圆","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/jianlaishanhe.jpg","Desc":"燕地是中土大陆，从小生长于燕地的宋遇河偶得神兵回寰剑，又有一个半疯不傻的便宜师傅相助，仅以年庚二十一登武林至尊之位，难知顺风顺水的人生变故突生。妻子背叛，管家反水，好友失踪。\n　　看似毫无干系，不知此后人生皆从此次起真正开始。","BookStatus":"连载","LastChapterId":"1675508","LastChapter":"十五章 观墨欲逃离","CName":"武侠仙侠","UpdateTime":"2018-09-25 00:00:00"},{"Id":"344078","Name":"刀未剑来","Author":"飘祛来","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/daoweijianlai.jpg","Desc":"刀，武之孤者。剑，武之爱者，以刀捍剑的修仙世界是个怎样的世界，以凡逆仙的世界是个怎样的世界，我不懂，你们也不懂，到底能走多远，拭目以待。。。。","BookStatus":"连载","LastChapterId":"1735666","LastChapter":"第130章-再见!神武","CName":"武侠仙侠","UpdateTime":"2018-10-30 00:00:00"},{"Id":"423107","Name":"剑来酒来","Author":"乐碧水","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/jianlaijiulai.jpg","Desc":"康熙初年，木从心系朝廷秘密特务组织“十三司衙门”之一员，外出查案之时，无意间在鬼市得到一把天月剑，同时为人陷害，身中剧毒而被逐出官府，流落江湖。\n　　其时三藩初平，肘腋之间有朱三太子意存反复，东南沿岸有延平王、倭寇搅得海警四起；白莲教盘踞在昆仑龙脉，绿林盟驻扎于四川青城，更有自由石匠三级分会势力，为打开鸦片市场而渗入炎黄大地。\n　　一人一剑，行走于猛兽横行的江湖，犹如雨打浮萍，他将何以自处，这","BookStatus":"连载","LastChapterId":"2263098","LastChapter":"第九节 武痴 一","CName":"武侠仙侠","UpdateTime":"2019-05-21 00:00:00"},{"Id":"333974","Name":"生死剑来","Author":"羽翼降丰","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/shengsijianlai.jpg","Desc":"灵武大陆灵天剑派一个小小的外门弟子林羽，捡到一个美女剑侍，而这美女却是他的金手指，请看林羽背负使命一路崛起。","BookStatus":"连载","LastChapterId":"1768635","LastChapter":"第三章 颜妍剑挑真龙","CName":"玄幻奇幻","UpdateTime":"2018-10-07 00:00:00"},{"Id":"385322","Name":"剑来大纲","Author":"一念化沧海","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/jianlaidagang.jpg","Desc":"准确地说，这是剑来的设定","BookStatus":"连载","LastChapterId":"1992584","LastChapter":"9.附","CName":"玄幻奇幻","UpdateTime":"2019-01-28 00:00:00"},{"Id":"252439","Name":"雨中铁剑来","Author":"景涵秋","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/yuzhongtiejianlai.jpg","Desc":"这江湖，有身穿麻衣，腰别铁剑的汉子；\n　　有甩着一对坐山臀，恰着水桶腰，扬言要坐死全天下英雄好汉的女侠；\n　　也有天不怕，地不怕，就喜欢凑热闹的江湖老汉。\n　　走一段江湖，喝二两小酒，有仇报仇，有怨报怨，除了穷酸一些，日子还算能过得去。\n　　庙堂、江湖，两座武林，相看两相厌，干脆彼此视而不见。\n　　在这个纷争不休的年代，有江湖败类想夺我神功，有父辈仇敌要害我性命，也有异族高手欲乱我方大界","BookStatus":"连载","LastChapterId":"1395419","LastChapter":"第095章 十二羽毛","CName":"武侠仙侠","UpdateTime":"2018-04-14 00:00:00"},{"Id":"358979","Name":"都市之剑来","Author":"剑酒黄","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/doushizhijianlai.jpg","Desc":"当灵气复苏的时代来临，一位做梦的少年，拿着把木剑，离开了家乡，开始了自己的修仙之旅……\n　　群号：866817364","BookStatus":"连载","LastChapterId":"1846906","LastChapter":"第19章 感谢你的坦诚 中","CName":"都市言情","UpdateTime":"2018-12-02 00:00:00"},{"Id":"237608","Name":"剑来同人故事","Author":"小月这妖孽","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/jianlaitongrengushi.jpg","Desc":"陈皮安：“你是我的瀺，秀色可餐！”崔瀺：“到底谁是谁的餐？”bl向同人连载小故事。故事所有主角源自《剑来》——烽火戏诸侯甜甜甜注：1）本文纯属胡编乱造，为了兴趣而编！！！2）雷者慎入！！！3）崔党天下第一！！！扬我大崔党河山！！！4）不定期更新…","BookStatus":"连载","LastChapterId":"1673977","LastChapter":"更新预告!","CName":"网游竞技","UpdateTime":"2019-03-01 00:00:00"},{"Id":"271701","Name":"一朝江湖仗剑来","Author":"凌霄客","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/yichaojianghuzhangjianlai.jpg","Desc":"我丈三尺长剑，自当横行江湖。世间千万阻难，以何解?一剑之事尔。","BookStatus":"连载","LastChapterId":"1452951","LastChapter":"第四章 登山","CName":"武侠仙侠","UpdateTime":"2018-05-28 00:00:00"},{"Id":"434732","Name":"人在江湖之剑来","Author":"武关一霸","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/renzaijianghuzhijianlai.jpg","Desc":"看似平静的江湖实则暗流涌动，依靠武力试图颠覆现有秩序，死不值钱，命掌握在何人手中，你看那大雨滂沱，失路之人又在何处躲雨，你听，有人窃窃私语，似是一声:“剑来!”","BookStatus":"连载","LastChapterId":"2265595","LastChapter":"最毒少年心","CName":"武侠仙侠","UpdateTime":"2019-05-20 00:00:00"},{"Id":"237799","Name":"峰峦剑来斩千盛","Author":"河右楚天流","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/fengluanjianlaizhanqiansheng.jpg","Desc":"起于峰峦上，终于千盛海，我有一把剑，可斩天下间。可我，终究是，没有斩下去……","BookStatus":"连载","LastChapterId":"1549594","LastChapter":"第十一章 封绝禁","CName":"武侠仙侠","UpdateTime":"2018-03-08 00:00:00"},{"Id":"415048","Name":"我自长青","Author":"乘风御剑来","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/wozizhangqing.jpg","Desc":"人生而为人以注定不平等…\n　　我叫常青，万古长青的青。","BookStatus":"连载","LastChapterId":"2234454","LastChapter":"第八章 成功","CName":"武侠仙侠","UpdateTime":"2019-04-10 00:00:00"},{"Id":"400604","Name":"蒸汽下的帝国","Author":"剑来","Img":"https://imgapi.jiaston.com/BookFiles/BookImages/zhengqixiadediguo.jpg","Desc":"火焰与钢铁，蒸汽与狼人。\n　　万物皆臣服于龙骑士，蒸汽车碾压一切不平。\n　　钢铁战机从空中呼啸而过，带来死亡与阴影。\n　　席恩·坦格利安站在帝国大厦之上，透过蒸汽广播让整个帝国的人民都听到\n　　“帝国万岁！”","BookStatus":"连载","LastChapterId":"2029880","LastChapter":"第五章 剿匪『二』","CName":"玄幻奇幻","UpdateTime":"2019-03-08 00:00:00"}]

//class SearchBean {
//  int status;
//  String info;
//  List<DataBean> data;
//
//  static SearchBean fromMap(Map<String, dynamic> map) {
//    if (map == null) return null;
//    SearchBean bookBean = SearchBean();
//    bookBean.status = map['status'];
//    bookBean.info = map['info'];
//    bookBean.data = List()
//      ..addAll((map['data'] as List ?? []).map((o) => DataBean.fromMap(o)));
//    return bookBean;
//  }
//}

/// Id : "146769"
/// Name : "剑来"
/// Author : "烽火戏诸侯"
/// Img : "https://imgapi.jiaston.com/BookFiles/BookImages/jianlai.jpg"
/// Desc : "大千世界，无奇不有。我陈平安，唯有一剑，可搬山，倒海，降妖，镇魔，敕神，摘星，断江，摧城，开天！"
/// BookStatus : "连载"
/// LastChapterId : "7774558"
/// LastChapter : "第五百五十一章 真人一到便叩关"
/// CName : "玄幻奇幻"
/// UpdateTime : "2019-05-19 00:00:00"

final String tableBook = 'book';
final String columnId = 'Id';
final String columnName = 'Name';
final String columnAuthor = 'Author';
final String columnImg = 'Img';
final String columnDesc = 'Desc';
final String columnBookStatus = 'BookStatus';
final String columnLastChapterId = 'LastChapterId';
final String columnLastChapter = 'LastChapter';
final String columnCName = 'CName';
final String columnUpdateTime = 'UpdateTime';
final String columnPosition = 'Positon';

class BookBean {
  int id;
  int position;
  String name;
  String author;
  String img;
  String desc;
  String bookStatus;
  String lastChapterId;
  String lastChapter;
  String cname;
  String updateTime;

  static BookBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookBean book = BookBean();
    book.id = int.parse(map['Id'].toString());
    book.position = map['Positon'] ?? 0;
    book.name = map['Name'] ?? "";
    book.author = map['Author'] ?? "";
    book.img = getCompleteImgUrl(map['Img'].toString()) ?? "";
    book.desc = map['Desc'] ?? "";
    book.bookStatus = map['BookStatus'] ?? "";
    book.lastChapterId = map['LastChapterId'] ?? "";
    book.lastChapter = map['LastChapter'] ?? "";
    book.cname = map['CName'] ?? "";
    book.updateTime = map['UpdateTime'] ?? "";
    return book;
  }

  static BookBean fromListDetailMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookBean book = BookBean();
    book.id = int.parse(map['BookId'].toString());
    book.position = map['Positon'] ?? 0;
    book.name = map['BookName'] ?? "";
    book.author = map['Author'] ?? "";
    book.img = getCompleteImgUrl(map['BookImage'].toString()) ?? "";
    book.desc = map['Description'] ?? "";
    book.bookStatus = "";
    book.lastChapterId = "";
    book.lastChapter = "";
    book.cname = map['CategoryName'] ?? "";
    book.updateTime = "";
    return book;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnAuthor: author,
      columnImg: img,
      columnDesc: desc,
      columnBookStatus: bookStatus,
      columnLastChapterId: lastChapterId,
      columnLastChapter: lastChapter,
      columnCName: cname,
      columnUpdateTime: updateTime,
      columnPosition: position,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

class BookSqlite {
  Database db;

  openSqlite() async {
    // 获取数据库文件的存储路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'book.db');

//根据数据库文件路径和数据库版本号创建数据库表
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
          CREATE TABLE $tableBook (
            $columnId INTEGER PRIMARY KEY, 
            $columnPosition INTEGER,
            $columnName TEXT, 
            $columnAuthor TEXT, 
            $columnImg TEXT, 
            $columnDesc TEXT,
            $columnBookStatus TEXT, 
            $columnLastChapterId TEXT, 
            $columnLastChapter TEXT, 
            $columnCName TEXT,
            $columnUpdateTime TEXT)
          ''');
        });
  }

// 插入一条书籍数据
  Future<int> insert(BookBean book) async {
    await this.openSqlite();
    return await db.insert(tableBook, book.toMap());
  }

// 查找所有书籍信息
  Future<List<BookBean>> queryAll() async {
    await this.openSqlite();
    List<Map> maps = await db.query(tableBook, columns: [
      columnId,
      columnPosition,
      columnName,
      columnAuthor,
      columnImg,
      columnDesc,
      columnBookStatus,
      columnLastChapterId,
      columnLastChapter,
      columnCName,
      columnUpdateTime
    ]);

    if (maps == null || maps.length == 0) {
      return null;
    }

    List<BookBean> books = [];
    for (int i = 0; i < maps.length; i++) {
      books.add(BookBean.fromMap(maps[i]));
    }
    return books;
  }

  Future<bool> queryBookIsAdd(int id) async {
    await this.openSqlite();
    List<Map> maps = await db.query(tableBook,
        columns: [
          columnId,
          columnPosition,
          columnName,
          columnAuthor,
          columnImg,
          columnDesc,
          columnBookStatus,
          columnLastChapterId,
          columnLastChapter,
          columnCName,
          columnUpdateTime
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return true;
    }
    return false;
  }

  // 根据ID查找书籍信息
  Future<BookBean> getBook(int id) async {
    await this.openSqlite();
    List<Map> maps = await db.query(tableBook,
        columns: [
          columnId,
          columnPosition,
          columnName,
          columnAuthor,
          columnImg,
          columnDesc,
          columnBookStatus,
          columnLastChapterId,
          columnLastChapter,
          columnCName,
          columnUpdateTime
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return BookBean.fromMap(maps.first);
    }
    return null;
  }

  // 根据ID删除书籍信息
  Future<int> delete(int id) async {
    await this.openSqlite();
    return await db.delete(tableBook, where: '$columnId = ?', whereArgs: [id]);
  }

  // 更新书籍信息
  Future<int> update(BookBean book) async {
    await this.openSqlite();
    print("更新${book.toMap()}");
    return await db.update(tableBook, book.toMap(),
        where: '$columnId = ?', whereArgs: [book.id]);
  }

  // 记得及时关闭数据库，防止内存泄漏
  close() async {
    await db.close();
  }
}
