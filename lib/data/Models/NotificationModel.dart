class NotificationModel {
  Data data;
  int unreadCount;

  NotificationModel({
    this.data,
    this.unreadCount,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      new NotificationModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        unreadCount: json["unread_count"] == null ? null : json["unread_count"],
      );
}

class Data {
  int currentPage;
  List<DataModel> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null
        ? null
        : new List<DataModel>.from(
        json["data"].map((x) => DataModel.fromJson(x))),
    firstPageUrl:
    json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    lastPageUrl:
    json["last_page_url"] == null ? null : json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );
}

class DataModel {
  int id;
  String text;
  String route;
  int showsId;
  int parentShowId;
  String image;
  int reading;
  dynamic createdAt;
  DateTime updatedAt;

  DataModel({
    this.id,
    this.text,
    this.route,
    this.showsId,
    this.parentShowId,
    this.image,
    this.reading,
    this.createdAt,
    this.updatedAt,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => new DataModel(
    id: json["id"] == null ? null : json["id"],
    text: json["text"] == null ? null : json["text"],
    route: json["route"] == null ? null : json["route"],
    showsId: json["shows_id"] == null ? null : json["shows_id"],
    parentShowId:
    json["parent_show_id"] == null ? null : json["parent_show_id"],
    image: json["image"] == null ? null : json["image"],
    reading: json["reading"] == null ? null : json["reading"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "text": text == null ? null : text,
    "route": route == null ? null : route,
    "shows_id": showsId == null ? null : showsId,
    "parent_show_id": parentShowId == null ? null : parentShowId,
    "image": image == null ? null : image,
    "reading": reading == null ? null : reading,
    "created_at": createdAt,
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}