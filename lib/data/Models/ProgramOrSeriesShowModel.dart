class ProgramOrSeriesShowModel {
  int id;
  String name;
  String image;
  String brief;
  int views;
  int shares;
  int rating;
  List<Category> category;
  int userRemind;
  int userRate;
  int userFavourite;
  List<dynamic> media;
  List<Person> persons;
  List<ProgramOrSeriesShowModel> shows;
  int parentShowId;

  ProgramOrSeriesShowModel(
      {this.id,
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
      this.persons,
      this.shows,
      this.parentShowId,
      this.userRate});

  factory ProgramOrSeriesShowModel.fromJson(Map<String, dynamic> json) =>
      new ProgramOrSeriesShowModel(
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
        userRate: json["userRate"] == null ? null : json["userRate"],
        userFavourite:
            json["userFavourite"] == null ? null : json["userFavourite"],
        media: json["media"] == null
            ? null
            : new List<dynamic>.from(json["media"].map((x) => x)),
        persons: json["persons"] == null
            ? null
            : new List<Person>.from(
                json["persons"].map((x) => Person.fromJson(x))),
        shows: json["shows"] == null
            ? null
            : new List<ProgramOrSeriesShowModel>.from(
                json["shows"].map((x) => ProgramOrSeriesShowModel.fromJson(x))),
        parentShowId:
            json["parent_show_id"] == null ? null : json["parent_show_id"],
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

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class Person {
  int id;
  String name;
  String image;
  String brief;
  int rating;
  int userFavourite;
  List<Category> category;
  Pivot pivot;

  Person({
    this.id,
    this.name,
    this.image,
    this.brief,
    this.rating,
    this.userFavourite,
    this.category,
    this.pivot,
  });

  factory Person.fromJson(Map<String, dynamic> json) => new Person(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        brief: json["brief"] == null ? null : json["brief"],
        rating: json["rating"] == null ? null : json["rating"],
        userFavourite:
            json["userFavourite"] == null ? null : json["userFavourite"],
        category: json["category"] == null
            ? null
            : new List<Category>.from(
                json["category"].map((x) => Category.fromJson(x))),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );
}

class Pivot {
  String parentShowId;
  String personId;

  Pivot({
    this.parentShowId,
    this.personId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => new Pivot(
        parentShowId:
            json["parent_show_id"] == null ? null : json["parent_show_id"],
        personId: json["person_id"] == null ? null : json["person_id"],
      );
}
