import 'dart:convert';

List<OtherShowModel> otherShowModelFromJson(String str) =>
    new List<OtherShowModel>.from(
        json.decode(str).map((x) => OtherShowModel.fromJson(x)));

class OtherShowModel {
  int id;
  String name;
  String image;
  String brief;
  int views;
  int shares;
  int rating;
  List<Category> category;
  int userRemind;
  int userFavourite;
  List<Media> media;
  dynamic parentShowId;

  OtherShowModel({
    this.id,
    this.name,
    this.image,
    this.brief,
    this.views,
    this.shares,
    this.rating,
    this.category,
    this.userRemind,
    this.userFavourite,
    this.media,
    this.parentShowId,
  });

  factory OtherShowModel.fromJson(Map<String, dynamic> json) =>
      new OtherShowModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        brief: json["brief"] == null ? null : json["brief"],
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
        parentShowId: json["parent_show_id"],
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
  dynamic createdAt;
  dynamic updatedAt;

  Media({
    this.id,
    this.mediableId,
    this.mediableType,
    this.image,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) => new Media(
        id: json["id"] == null ? null : json["id"],
        mediableId: json["mediable_id"] == null ? null : json["mediable_id"],
        mediableType:
            json["mediable_type"] == null ? null : json["mediable_type"],
        image: json["image"] == null ? null : json["image"],
        type: json["type"] == null ? null : json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
