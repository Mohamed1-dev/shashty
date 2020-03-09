//List<ShowRemindModel> showRemindModelFromJson(String str) =>
//    new List<ShowRemindModel>.from(
//        json.decode(str).map((x) => ShowRemindModel.fromJson(x)));
//
//String showRemindModelToJson(List<ShowRemindModel> data) =>
//    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ShowRemindModel {
  int id;
  int userId;
  int reminderable_id;
  String kind;
  DateTime startDate;
  Shows shows;

  ShowRemindModel({
    this.id,
    this.userId,
    this.startDate,
    this.shows,
    this.kind,
    this.reminderable_id
  });

  factory ShowRemindModel.fromJson(Map<String, dynamic> json) =>
      new ShowRemindModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        kind: json["kind"]==null?null: json["kind"],
        reminderable_id:json["reminderable_id"]==null?null: json["reminderable_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        shows: json["shows"] == null ? null : Shows.fromJson(json["shows"]),
      );
}

class Shows {
  int id;
  String name;
  String image;
  String brief;
  int parentShowId;
  int views;
  int shares;
  int rating;
  List<Category> category;
  int userRemind;
  int userFavourite;
  List<Media> media;
  int userRate;

  String Home_TeamName;
  String Away_TeamName;
  String AWAY_TEAM_LOGO;
  String HOME_TEAM_LOGO;
  String LeagueName;

  Shows({
    this.id,
    this.name,
    this.image,
    this.brief,
    this.parentShowId,
    this.views,
    this.shares,
    this.rating,
    this.category,
    this.userRemind,
    this.userFavourite,
    this.media,
    this.userRate,
    this.Home_TeamName,
    this.Away_TeamName,
    this.HOME_TEAM_LOGO,
    this.AWAY_TEAM_LOGO,
    this.LeagueName,
   });

  factory Shows.fromJson(Map<String, dynamic> json) => new Shows(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        brief: json["brief"] == null ? null : json["brief"],
        parentShowId:
            json["parent_show_id"] == null ? null : json["parent_show_id"],
        views: json["views"] == null ? null : json["views"],
        shares: json["shares"] == null ? null : json["shares"],
        rating: json["rating"] == null ? null : json["rating"],
        category: json["category"] == null
            ? null
            : new List<Category>.from(
                json["category"].map((x) => Category.fromJson(x))),
        userRemind: json["userRemind"] == null ? null : json["userRemind"],
        userFavourite:
            json["userFavourite"] == null ? null : json["userFavourite"],
        media: json["media"] == null
            ? null
            : new List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        userRate: json["userRate"] == null ? null : json["userRate"],
    Away_TeamName:json["Away_TeamName"]==null?null:json["Away_TeamName"],
    Home_TeamName:json["Home_TeamName"]==null?null:json["Home_TeamName"],
    AWAY_TEAM_LOGO:json["AWAY_TEAM_LOGO"]==null?null:json["AWAY_TEAM_LOGO"],
    HOME_TEAM_LOGO:json["HOME_TEAM_LOGO"]==null?null:json["HOME_TEAM_LOGO"],
    LeagueName:json["LeagueName"]==null?null:json["LeagueName"],



  );
}

class Category {
  int id;
  String name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => new Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );
}

class Media {
  int id;
  int mediableId;
  String mediableType;
  String image;
  int type;

  Media({
    this.id,
    this.mediableId,
    this.mediableType,
    this.image,
    this.type,
  });

  factory Media.fromJson(Map<String, dynamic> json) => new Media(
      id: json["id"] == null ? null : json["id"],
      mediableId: json["mediable_id"] == null ? null : json["mediable_id"],
      mediableType:
          json["mediable_type"] == null ? null : json["mediable_type"],
      image: json["image"] == null ? null : json["image"],
      type: json["type"] == null ? null : json["type"]);
}
