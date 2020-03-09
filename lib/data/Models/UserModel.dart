class UserModel {
  int id;
  String name;
  String email;
  String phone;
  String image;
  String tokenId;
  int countryId;
  int cityId;
  String provider;
  int providerId;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.tokenId,
    this.countryId,
    this.cityId,
    this.provider,
    this.providerId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        image: json["image"] == null ? null : json["image"],
        tokenId: json["token_id"] == null ? null : json["token_id"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        provider: json["provider"] == null ? null : json["provider"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "image": image == null ? null : image,
        "token_id": tokenId == null ? null : tokenId,
        "country_id": countryId == null ? null : countryId,
        "city_id": cityId == null ? null : cityId,
        "provider": provider == null ? null : provider,
        "provider_id": providerId == null ? null : providerId,
      };
}
