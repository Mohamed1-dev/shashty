class HomeModelCategory {
  int id;
  String name;
  List<SubCategoryElement> subCategories;

  HomeModelCategory({
    this.id,
    this.name,
    this.subCategories,
  });

  factory HomeModelCategory.fromJson(Map<String, dynamic> json) =>
      new HomeModelCategory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        subCategories: json["sub_categories"] == null
            ? null
            : new List<SubCategoryElement>.from(json["sub_categories"]
                .map((x) => SubCategoryElement.fromJson(x))),
      );
}

class SubCategoryElement {
  int id;
  String name;

  SubCategoryElement({
    this.id,
    this.name,
  });

  factory SubCategoryElement.fromJson(Map<String, dynamic> json) =>
      new SubCategoryElement(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );
}
