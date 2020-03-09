class PersonShowModel {
  Person person;
  List<Show> shows;

  PersonShowModel({
    this.person,
    this.shows,
  });

  factory PersonShowModel.fromJson(Map<String, dynamic> json) =>
      new PersonShowModel(
        person: json["person"] == null ? null : Person.fromJson(json["person"]),
        shows: json["shows"] == null
            ? null
            : new List<Show>.from(json["shows"].map((x) => Show.fromJson(x))),
      );
}

class Person {
  int id;
  String name;
  String image;
  String brief;
  int rating;
  int userFavourite;
  List<Category> category;

  Person({
    this.id,
    this.name,
    this.image,
    this.brief,
    this.rating,
    this.userFavourite,
    this.category,
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

class Show {
  int id;
  String name;
  String image;
  String brief;
  dynamic parentShowId;
  int views;
  int shares;
  int rating;
  List<Category> category;
  int userRemind;
  int userFavourite;
  List<Media> media;
  Pivot pivot;

  Show({
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
    this.pivot,
  });

  factory Show.fromJson(Map<String, dynamic> json) => new Show(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    brief: json["brief"] == null ? null : json["brief"],
    parentShowId: json["parent_show_id"],
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
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
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

class Pivot {
  int personId;
  int showsId;
  int parentShowId;

  Pivot({
    this.personId,
    this.showsId,
    this.parentShowId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => new Pivot(
    personId: json["person_id"] == null ? null : json["person_id"],
    showsId: json["shows_id"] == null ? null : json["shows_id"],
    parentShowId:
    json["parent_show_id"] == null ? null : json["parent_show_id"],
  );
}