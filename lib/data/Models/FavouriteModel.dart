import 'dart:convert';

List<FavouriteModel> favouriteModelFromJson(String str) =>
    new List<FavouriteModel>.from(
        json.decode(str).map((x) => FavouriteModel.fromJson(x)));

class FavouriteModel {
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
  int userRate;
  String kind;
  dynamic parentShowId;

  FavouriteModel({
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
    this.userRate,
    this.parentShowId,
    this.kind
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) =>
      new FavouriteModel(
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
        userRate: json["userRate"] == null ? null : json["userRate"],
        kind: json["kind"] == null ? null : json["kind"],

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
  DateTime createdAt;
  DateTime updatedAt;

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
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );
}