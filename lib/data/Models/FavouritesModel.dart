// To parse this JSON data, do
//
//     final favouriteModel = favouriteModelFromJson(jsonString);

import 'dart:convert';

FavouriteModel favouriteModelFromJson(String str) => FavouriteModel.fromJson(json.decode(str));

String favouriteModelToJson(FavouriteModel data) => json.encode(data.toJson());

class FavouriteModel {
  List<Datum> data;
  String firstPageUrl;
   int lastPage;


  FavouriteModel({
    this.data,
    this.firstPageUrl,
     this.lastPage,

  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
     lastPage: json["last_page"],
    );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
     "last_page": lastPage,

  };
}

class Datum {
  int id;
  String name;
  String image;
   bool isSelected;

  Datum({
    this.id,
    this.name,
    this.image,

    this.isSelected
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    image: json["image"],

    isSelected: false
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,

  };
}
