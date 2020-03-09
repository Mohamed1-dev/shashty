// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);


import 'CategoryModel.dart';
import 'HomeModelCategory.dart';
import 'SingleModel.dart';

class HomeModel {
  List<HomeModelCategory> categories;
  List<CategoryModel> slider;
  List<CategoryModel> topRated;
  List<CategoryModel> topViews;
  List<CategoryModel> showNow;
  List<CategoryModel> showSoon;
  List<CategoryModel> suggested;
  List<SingleModel> persons;
  List<SingleModel> channels;
  List<CategoryModel> topFavourite;
  List<CategoryModel> teams;

  HomeModel(
      {this.slider,
      this.topFavourite,
      this.topRated,
      this.topViews,
      this.showNow,
      this.showSoon,
      this.suggested,
      this.persons,
      this.channels,
      this.categories,this.teams});

  factory HomeModel.fromJson(Map<String, dynamic> json) => new HomeModel(
        slider: json["slider"] == null
            ? null
            : new List<CategoryModel>.from(
                json["slider"].map((x) => CategoryModel.fromJson(x))),
        topFavourite: json["topFavourite"] == null
            ? null
            : new List<CategoryModel>.from(
                json["topFavourite"].map((x) => CategoryModel.fromJson(x))),
        topRated: json["topRated"] == null
            ? null
            : new List<CategoryModel>.from(
                json["topRated"].map((x) => CategoryModel.fromJson(x))),
        topViews: json["topViews"] == null
            ? null
            : new List<CategoryModel>.from(
                json["topViews"].map((x) => CategoryModel.fromJson(x))),
        showNow: json["showNow"] == null
            ? null
            : new List<CategoryModel>.from(json["showNow"].map((x) =>
                CategoryModel.fromJson(
                    x))), //CategoryModel.fromJson(json["showNow"]),
        showSoon: json["showSoon"] == null
            ? null
            : new List<CategoryModel>.from(
                json["showSoon"].map((x) => CategoryModel.fromJson(x))),
        suggested: json["suggested"] == null
            ? null
            : new List<CategoryModel>.from(
                json["suggested"].map((x) => CategoryModel.fromJson(x))),
        persons: json["persons"] == null
            ? null
            : new List<SingleModel>.from(
                json["persons"].map((x) => SingleModel.fromJson(x))),
        channels: json["channels"] == null
            ? null
            : new List<SingleModel>.from(
                json["channels"].map((x) => SingleModel.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : new List<HomeModelCategory>.from(
                json["categories"].map((x) => HomeModelCategory.fromJson(x))),
        teams: json["teams"] == null
            ? null
            : new List<CategoryModel>.from(
                json["teams"].map((x) => CategoryModel.fromJson(x))),
      );
}

class ShowNow {
  Headers headers;
  List<String> original;
  dynamic exception;

  ShowNow({
    this.headers,
    this.original,
    this.exception,
  });

  factory ShowNow.fromJson(Map<String, dynamic> json) => new ShowNow(
        headers:
            json["headers"] == null ? null : Headers.fromJson(json["headers"]),
        original: json["original"] == null
            ? null
            : new List<String>.from(json["original"].map((x) => x)),
        exception: json["exception"],
      );
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) => new Headers();

  Map<String, dynamic> toJson() => {};
}
