class CategoriesSearchModel {
  List<Category> categories;

  CategoriesSearchModel({
    this.categories,
  });

  factory CategoriesSearchModel.fromJson(Map<String, dynamic> json) =>
      new CategoriesSearchModel(
          categories: json["categories"] == null
              ? null
              : new List<Category>.from(
                  json["categories"].map((x) => Category.fromJson(x))));
}

class Category {
  int id;
  String name;
  List<SubCategory> subCategories;

  Category({
    this.id,
    this.name,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => new Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        subCategories: json["sub_categories"] == null
            ? null
            : new List<SubCategory>.from(
                json["sub_categories"].map((x) => SubCategory.fromJson(x))),
      );
}

class SubCategory {
  int id;
  String name;

  SubCategory({
    this.id,
    this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => new SubCategory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );
}
