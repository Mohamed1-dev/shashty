class CategoryModel {
  int id;
  String name;
  String image;
  dynamic parentShowId;
  int views;
  int shares;
  dynamic createdAt;
  dynamic updatedAt;
  int rating;
  List<Category> category;
  List<Slider> slider;
  bool isShowed;
  String brief;
  int userFavourite, userRemind, userRate;
  List<Media> media;

  CategoryModel(
      {this.id,
      this.media,
      this.name,
      this.image,
      this.parentShowId,
      this.views,
      this.shares,
      this.createdAt,
      this.updatedAt,
      this.rating,
      this.category,
      this.slider,
      this.isShowed,
      this.brief,
      this.userFavourite,
      this.userRemind,
      this.userRate});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      new CategoryModel(
          id: json["id"] == null ? null : json["id"],
          name: json["name"] == null ? null : json["name"],
          image: json["image"] == null ? null : json["image"],
          parentShowId: json["parent_show_id"],
          views: json["views"] == null ? null : json["views"],
          shares: json["shares"] == null ? null : json["shares"],
          createdAt: json["created_at"],
          updatedAt: json["updated_at"],
          rating: json["rating"] == null ? null : json["rating"],
          category: json["category"] == null
              ? null
              : new List<Category>.from(
                  json["category"].map((x) => Category.fromJson(x))),
          slider: json["slider"] == null
              ? null
              : new List<Slider>.from(
                  json["slider"].map((x) => Slider.fromJson(x))),
          isShowed: false,
          brief: json["brief"] == null ? null : json["brief"],
          media: json["media"] == null
              ? null
              : new List<Media>.from(
                  json["media"].map((x) => Media.fromJson(x))),
          userFavourite:
              json["userFavourite"] == null ? null : json["userFavourite"],
          userRemind: json["userRemind"] == null ? null : json["userRemind"],
          userRate: json["userRate"] == null ? null : json["userRate"]);
}

class Media {
  int id;
  int mediableId;
  Type mediableType;
  String image;
  String type;
  DateTime createdAt;
  DateTime updatedAt;

  Media({
    this.id,
    this.mediableId,
    this.image,
  });

  factory Media.fromJson(Map<String, dynamic> json) => new Media(
        id: json["id"] == null ? null : json["id"],
        mediableId: json["mediable_id"] == null ? null : json["mediable_id"],
        image: json["image"] == null ? null : json["image"],
      );
}

class Category {
  int id;
  String name;
  dynamic createdAt;
  dynamic updatedAt;

  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => new Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class Slider {
  int id;
  String image;
  String sliderType;
  int sliderId;
  int kind;
  dynamic createdAt;
  dynamic updatedAt;

  Slider({
    this.id,
    this.image,
    this.sliderType,
    this.sliderId,
    this.kind,
    this.createdAt,
    this.updatedAt,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => new Slider(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        sliderType: json["slider_type"] == null ? null : json["slider_type"],
        sliderId: json["slider_id"] == null ? null : json["slider_id"],
        kind: json["kind"] == null ? null : json["kind"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "image": image == null ? null : image,
        "slider_type": sliderType == null ? null : sliderType,
        "slider_id": sliderId == null ? null : sliderId,
        "kind": kind == null ? null : kind,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
