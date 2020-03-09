class SingleModel {
  int id;
  String name;
  String image;
  SingleModel({
    this.id,
    this.name,
    this.image,
  });

  factory SingleModel.fromJson(Map<String, dynamic> json) => new SingleModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
      );
}
