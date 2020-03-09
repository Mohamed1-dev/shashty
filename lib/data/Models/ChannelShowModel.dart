class ChannelShowModel {
  Channel channel;
  List<Show> shows;


  ChannelShowModel({
    this.channel,
    this.shows,
  });

  factory ChannelShowModel.fromJson(Map<String, dynamic> json) =>
      new ChannelShowModel(
        channel:
        json["channel"] == null ? null : Channel.fromJson(json["channel"]),
        shows: json["shows"] == null
            ? null
            : new List<Show>.from(json["shows"].map((x) => Show.fromJson(x))),

      );
}

class Channel {
  int id;
  String name;
  String image;

  Channel({
    this.id,
    this.name,
    this.image,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => new Channel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
  );
}

class Show {
  int id;
  DateTime startDate;
  DateTime endDate;
  int showId;
  int userRemind;
  Shows shows;

  Show({
    this.id,
    this.startDate,
    this.endDate,
    this.showId,
    this.userRemind,
    this.shows,
  });

  factory Show.fromJson(Map<String, dynamic> json) => Show(
    id: json["id"] == null ? null : json["id"],
    startDate: json["start_date"] == null
        ? null
        : DateTime.parse(json["start_date"]),
    endDate:
    json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    showId: json["show_id"] == null ? null : json["show_id"],
    userRemind: json["userRemind"] == null ? null : json["userRemind"],

    shows: json["shows"] == null ? null :Shows.fromJson(json["shows"]),
  );


}

class Shows {
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
  int userRate;
  List<Person> persons;

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
    this.persons,
  });

  factory Shows.fromJson(Map<String, dynamic> json) => Shows(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    brief: json["brief"] == null ? null : json["brief"],
    parentShowId: json["parent_show_id"] == null ? null : json["parent_show_id"],
    views: json["views"] == null ? null : json["views"],
    shares: json["shares"] == null ? null : json["shares"],
    rating: json["rating"] == null ? null : json["rating"],
    category:json["category"] == null ? null : List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    userRemind: json["userRemind"] == null ? null : json["userRemind"],
    userFavourite: json["userFavourite"] == null ? null : json["userFavourite"],
    media: json["media"] == null ? null : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
    userRate: json["userRate"] == null ? null : json["userRate"] ,
    persons:json["persons"] == null ? null : List<Person>.from(json["persons"].map((x) => Person.fromJson(x))),
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

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"] == null ? null : json["id"],
    mediableId: json["mediable_id"] == null ? null : json["mediable_id"],
    mediableType: json["mediable_type"] == null ? null : json["mediable_type"] ,
    image: json["image"] == null ? null :  json["image"] ,
    type: json["type"] == null ? null : json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null :  DateTime.parse(json["updated_at"]),
  );

}

class Person {
  int id;
  String name;
  String image;
  String brief;
  int rating;
  int userFavourite;
  List<PersonCategory> personcategory;

  Person({
    this.id,
    this.name,
    this.image,
    this.brief,
    this.rating,
    this.userFavourite,
    this.personcategory,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null :  json["image"] ,
    brief: json["brief"] == null ? null : json["brief"],
    rating: json["rating"] == null ? null : json["rating"],
    userFavourite: json["userFavourite"]== null ? null : json["userFavourite"],
    personcategory: json["category"] == null ? null : List<PersonCategory>.from(json["category"].map((x) => PersonCategory.fromJson(x))),
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


class PersonCategory {
  int id;
  String name;

  PersonCategory({
    this.id,
    this.name,
  });

  factory PersonCategory.fromJson(Map<String, dynamic> json) => new PersonCategory(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );
}

