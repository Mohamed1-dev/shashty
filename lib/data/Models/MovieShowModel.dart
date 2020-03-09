class MovieShowModel {
  int id;
  String name;
  String image;
  String brief;
  dynamic parentShowId;
  int views;
  int shares;
  List<Channel> channels;
  int rating;
  List<Category> category;
  int userRemind;
  int userFavourite;
  int userRate;
  List<dynamic> media;
  List<Person> persons;

  MovieShowModel(
      {this.id,
      this.name,
      this.image,
      this.brief,
      this.parentShowId,
      this.views,
      this.shares,
      this.channels,
      this.rating,
      this.category,
      this.userRemind,
      this.userFavourite,
      this.media,
      this.persons,
      this.userRate});

  factory MovieShowModel.fromJson(Map<String, dynamic> json) =>
      new MovieShowModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        brief: json["brief"] == null ? null : json["brief"],
        parentShowId: json["parent_show_id"],
        views: json["views"] == null ? null : json["views"],
        shares: json["shares"] == null ? null : json["shares"],
        channels: json["channels"] == null
            ? null
            : new List<Channel>.from(
                json["channels"].map((x) => Channel.fromJson(x))),
        rating: json["rating"] == null ? null : json["rating"],
        category: json["category"] == null
            ? null
            : new List<Category>.from(
                json["category"].map((x) => Category.fromJson(x))),
        userRemind: json["userRemind"] == null ? null : json["userRemind"],
        userFavourite:
            json["userFavourite"] == null ? null : json["userFavourite"],
        userRate: json["userRate"] == null ? null : json["userRate"],
        media: json["media"] == null
            ? null
            : new List<dynamic>.from(json["media"].map((x) => x)),
        persons: json["persons"] == null
            ? null
            : new List<Person>.from(
                json["persons"].map((x) => Person.fromJson(x))),
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

class ShowTime {
  int id;
  DateTime startDate;
  DateTime endDate;
  int showId;
  int userRemind;
  ShowTimePivot pivot;

  ShowTime({
    this.id,
    this.startDate,
    this.endDate,
    this.showId,
    this.userRemind,
    this.pivot,
  });

  factory ShowTime.fromJson(Map<String, dynamic> json) => new ShowTime(
        id: json["id"] == null ? null : json["id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        showId: json["show_id"] == null ? null : json["show_id"],
        userRemind: json["userRemind"] == null ? null : json["userRemind"],
        pivot: json["pivot"] == null
            ? null
            : ShowTimePivot.fromJson(json["pivot"]),
      );
}

class ShowTimePivot {
  int channelId;
  int showTimeId;

  ShowTimePivot({
    this.channelId,
    this.showTimeId,
  });

  factory ShowTimePivot.fromJson(Map<String, dynamic> json) =>
      new ShowTimePivot(
        channelId: json["channel_id"] == null ? null : json["channel_id"],
        showTimeId: json["show_time_id"] == null ? null : json["show_time_id"],
      );
}

class Channel {
  int id;
  String name;
  String image;
  List<ShowTime> showTime;

  Channel({
    this.id,
    this.name,
    this.image,
    this.showTime,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => new Channel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        showTime: json["show_time"] == null
            ? null
            : new List<ShowTime>.from(
                json["show_time"].map((x) => ShowTime.fromJson(x))),
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
  String showsId;
  String personId;

  Pivot({
    this.showsId,
    this.personId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => new Pivot(
        showsId: json["shows_id"] == null ? null : json["shows_id"],
        personId: json["person_id"] == null ? null : json["person_id"],
      );
}
