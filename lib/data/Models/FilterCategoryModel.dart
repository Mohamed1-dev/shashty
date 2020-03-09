// To parse this JSON data, do
//
//     final filterCategoryModel = filterCategoryModelFromJson(jsonString);

import 'dart:convert';

import 'OtherShowModel.dart';

FilterCategoryModel filterCategoryModelFromJson(String str) =>
    FilterCategoryModel.fromJson(json.decode(str));

class FilterCategoryModel {
  int currentPage;
  List<OtherShowModel> data;
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

  FilterCategoryModel({
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

  factory FilterCategoryModel.fromJson(Map<String, dynamic> json) =>
      new FilterCategoryModel(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : new List<OtherShowModel>.from(
                json["data"].map((x) => OtherShowModel.fromJson(x))),
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
  String mediableId;
  String mediableType;
  String image;
  String type;
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
