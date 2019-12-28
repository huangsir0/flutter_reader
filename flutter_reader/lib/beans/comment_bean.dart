class Comment {
  Activity_infoBean activityInfo;
  int cmtSum;
  List<CommentsBean> comments;
  List<dynamic> expert;
  List<HotsBean> hots;
  int mode;
  int outerCmtSum;
  int participationSum;
  int topicId;
  int totalPageNo;
  List<User_levelBean> userLevel;

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Comment commentBean = Comment();
    commentBean.activityInfo = Activity_infoBean.fromMap(map['activity_info']);
    commentBean.cmtSum = map['cmt_sum'];
    commentBean.comments = List()
      ..addAll(
          (map['comments'] as List ?? []).map((o) => CommentsBean.fromMap(o)));
    commentBean.expert = map['expert'];
    commentBean.hots = List()
      ..addAll((map['hots'] as List ?? []).map((o) => HotsBean.fromMap(o)));
    commentBean.mode = map['mode'];
    commentBean.outerCmtSum = map['outer_cmt_sum'];
    commentBean.participationSum = map['participation_sum'];
    commentBean.topicId = map['topic_id'];
    commentBean.totalPageNo = map['total_page_no'];
    commentBean.userLevel = List()
      ..addAll((map['user_level'] as List ?? [])
          .map((o) => User_levelBean.fromMap(o)));
    return commentBean;
  }
}

/// exp : 0
/// isvId : 0
/// level : 1
/// privilege : 0
/// privilegeDesp : "{}"
/// privilegeDespAsJson : {}
/// title : "潜水"

class User_levelBean {
  int exp;
  int isvId;
  int level;
  int privilege;
  String privilegeDesp;
  PrivilegeDespAsJsonBean privilegeDespAsJson;
  String title;

  static User_levelBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    User_levelBean user_levelBean = User_levelBean();
    user_levelBean.exp = map['exp'];
    user_levelBean.isvId = map['isvId'];
    user_levelBean.level = map['level'];
    user_levelBean.privilege = map['privilege'];
    user_levelBean.privilegeDesp = map['privilegeDesp'];
    user_levelBean.privilegeDespAsJson =
        PrivilegeDespAsJsonBean.fromMap(map['privilegeDespAsJson']);
    user_levelBean.title = map['title'];
    return user_levelBean;
  }
}

class PrivilegeDespAsJsonBean {
  static PrivilegeDespAsJsonBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PrivilegeDespAsJsonBean privilegeDespAsJsonBean = PrivilegeDespAsJsonBean();
    return privilegeDespAsJsonBean;
  }
}

/// attachments : []
/// comment_id : 1552167025
/// comments : []
/// content : "至尊骨，命孤苦，踏天路，展雄图，却牵伊人火桑树。囚笼处，罪血出，天骄路，谁人阻，鲲鹏翼展震万古。雷劫途，何人渡，轮回路，前贤输，万物母气来求助。战异域，闯藏土，帝关处，多无助，为了亲友命不顾。茫茫路，万古枯，神威怒，战心苏，独断万古无归路。"
/// create_time : 1526046989000
/// elite : false
/// floor_count : 0
/// from : "Good客户端"
/// hide : false
/// hide_floor : false
/// highlight : false
/// ip : "112.24.93.49"
/// ip_location : "江苏省"
/// metadata : "metadata"
/// oppose_count : 0
/// passport : {"expired":false,"fee":0,"followers_count":0,"from":"","grant":false,"img_url":"http://sucimg.itc.cn/avatarimg/964771136_1526046971533_c55","is_official":false,"is_shared":false,"nickname":"姚星宇","platform_id":-1,"user_id":964771136}
/// quick : false
/// reply_count : 0
/// reply_id : 0
/// score : 1
/// status : 0
/// support_count : 67
/// top : false
/// userScore : {"isvId":0,"level":2,"levelUp":0,"privilege":{},"score":2,"title":"冒泡","userId":0}
/// user_id : 964771136

class HotsBean {
  List<dynamic> attachments;
  int commentId;
  List<dynamic> comments;
  String content;
  int createTime;
  bool elite;
  int floorCount;
  String from;
  bool hide;
  bool hideFloor;
  bool highlight;
  String ip;
  String ipLocation;
  String metadata;
  int opposeCount;
  PassportBean passport;
  bool quick;
  int replyCount;
  int replyId;
  int score;
  int status;
  int supportCount;
  bool top;
  UserScoreBean userScore;
  int userId;

  static HotsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    HotsBean hotsBean = HotsBean();
    hotsBean.attachments = map['attachments'];
    hotsBean.commentId = map['comment_id'];
    hotsBean.comments = map['comments'];
    hotsBean.content = map['content'];
    hotsBean.createTime = map['create_time'];
    hotsBean.elite = map['elite'];
    hotsBean.floorCount = map['floor_count'];
    hotsBean.from = map['from'];
    hotsBean.hide = map['hide'];
    hotsBean.hideFloor = map['hide_floor'];
    hotsBean.highlight = map['highlight'];
    hotsBean.ip = map['ip'];
    hotsBean.ipLocation = map['ip_location'];
    hotsBean.metadata = map['metadata'];
    hotsBean.opposeCount = map['oppose_count'];
    hotsBean.passport = PassportBean.fromMap(map['passport']);
    hotsBean.quick = map['quick'];
    hotsBean.replyCount = map['reply_count'];
    hotsBean.replyId = map['reply_id'];
    hotsBean.score = map['score'];
    hotsBean.status = map['status'];
    hotsBean.supportCount = map['support_count'];
    hotsBean.top = map['top'];
    hotsBean.userScore = UserScoreBean.fromMap(map['userScore']);
    hotsBean.userId = map['user_id'];
    return hotsBean;
  }
}

/// isvId : 0
/// level : 2
/// levelUp : 0
/// privilege : {}
/// score : 2
/// title : "冒泡"
/// userId : 0

class UserScoreBean {
  int isvId;
  int level;
  int levelUp;
  PrivilegeBean privilege;
  int score;
  String title;
  int userId;

  static UserScoreBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserScoreBean userScoreBean = UserScoreBean();
    userScoreBean.isvId = map['isvId'];
    userScoreBean.level = map['level'];
    userScoreBean.levelUp = map['levelUp'];
    userScoreBean.privilege = PrivilegeBean.fromMap(map['privilege']);
    userScoreBean.score = map['score'];
    userScoreBean.title = map['title'];
    userScoreBean.userId = map['userId'];
    return userScoreBean;
  }
}

class PrivilegeBean {
  static PrivilegeBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PrivilegeBean privilegeBean = PrivilegeBean();
    return privilegeBean;
  }
}

/// expired : false
/// fee : 0
/// followers_count : 0
/// from : ""
/// grant : false
/// img_url : "http://sucimg.itc.cn/avatarimg/964771136_1526046971533_c55"
/// is_official : false
/// is_shared : false
/// nickname : "姚星宇"
/// platform_id : -1
/// user_id : 964771136

class PassportBean {
  bool expired;
  int fee;
  int followersCount;
  String from;
  bool grant;
  String imgUrl;
  bool isOfficial;
  bool isShared;
  String nickname;
  int platformId;
  int userId;

  static PassportBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PassportBean passportBean = PassportBean();
    passportBean.expired = map['expired'];
    passportBean.fee = map['fee'];
    passportBean.followersCount = map['followers_count'];
    passportBean.from = map['from'];
    passportBean.grant = map['grant'];
    passportBean.imgUrl = map['img_url'];
    passportBean.isOfficial = map['is_official'];
    passportBean.isShared = map['is_shared'];
    passportBean.nickname = map['nickname'];
    passportBean.platformId = map['platform_id'];
    passportBean.userId = map['user_id'];
    return passportBean;
  }
}

/// attachments : []
/// comment_id : 1596834946
/// comments : []
/// content : "喜欢看的不一定是写的好的，写的好的也不一定就会喜欢看"
/// create_time : 1559422132000
/// elite : false
/// floor_count : 0
/// from : "Goodwap版"
/// hide : false
/// hide_floor : false
/// highlight : false
/// ip : "120.36.78.202"
/// ip_location : "福建省福州市"
/// metadata : "{\"clientPort\":\"25255\"}"
/// metadataAsJson : {"clientPort":"25255"}
/// oppose_count : 0
/// passport : {"expired":false,"fee":0,"followers_count":0,"from":"","grant":false,"img_url":"http://0d077ef9e74d8.cdn.sohucs.com/c_zoom,w_200/fac494264beff70ed91fedf32783552b_default_1449555982090_jpg","is_official":false,"is_shared":false,"nickname":"牵着你的手","platform_id":15,"user_id":100000878623}
/// quick : false
/// reply_count : 0
/// reply_id : 0
/// score : 0
/// status : 0
/// support_count : 1
/// top : false
/// userScore : {"isvId":0,"level":2,"levelUp":0,"privilege":{},"score":8,"title":"冒泡","userId":0}
/// user_id : 100000878623

class CommentsBean {
  List<dynamic> attachments;
  int commentId;
  List<dynamic> comments;
  String content;
  int createTime;
  bool elite;
  int floorCount;
  String from;
  bool hide;
  bool hideFloor;
  bool highlight;
  String ip;
  String ipLocation;
  String metadata;
  MetadataAsJsonBean metadataAsJson;
  int opposeCount;
  PassportBean passport;
  bool quick;
  int replyCount;
  int replyId;
  int score;
  int status;
  int supportCount;
  bool top;
  UserScoreBean userScore;
  int userId;

  static CommentsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CommentsBean commentsBean = CommentsBean();
    commentsBean.attachments = map['attachments'];
    commentsBean.commentId = map['comment_id'];
    commentsBean.comments = map['comments'];
    commentsBean.content = map['content'];
    commentsBean.createTime = map['create_time'];
    commentsBean.elite = map['elite'];
    commentsBean.floorCount = map['floor_count'];
    commentsBean.from = map['from'];
    commentsBean.hide = map['hide'];
    commentsBean.hideFloor = map['hide_floor'];
    commentsBean.highlight = map['highlight'];
    commentsBean.ip = map['ip'];
    commentsBean.ipLocation = map['ip_location'];
    commentsBean.metadata = map['metadata'];
    commentsBean.metadataAsJson =
        MetadataAsJsonBean.fromMap(map['metadataAsJson']);
    commentsBean.opposeCount = map['oppose_count'];
    commentsBean.passport = PassportBean.fromMap(map['passport']);
    commentsBean.quick = map['quick'];
    commentsBean.replyCount = map['reply_count'];
    commentsBean.replyId = map['reply_id'];
    commentsBean.score = map['score'];
    commentsBean.status = map['status'];
    commentsBean.supportCount = map['support_count'];
    commentsBean.top = map['top'];
    commentsBean.userScore = UserScoreBean.fromMap(map['userScore']);
    commentsBean.userId = map['user_id'];
    return commentsBean;
  }
}

/// clientPort : "25255"

class MetadataAsJsonBean {
  String clientPort;

  static MetadataAsJsonBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MetadataAsJsonBean metadataAsJsonBean = MetadataAsJsonBean();
    metadataAsJsonBean.clientPort = map['clientPort'];
    return metadataAsJsonBean;
  }
}


class Activity_infoBean {
  static Activity_infoBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Activity_infoBean activity_infoBean = Activity_infoBean();
    return activity_infoBean;
  }
}
