
class TeamModel {
  int id;
  String name;
  String image;
  int userFavourite;
  String kind;

  TeamModel({this.id, this.name, this.image, this.userFavourite, this.kind});

  TeamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    userFavourite = json['userFavourite'];
    kind = json['kind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['userFavourite'] = this.userFavourite;
    data['kind'] = this.kind;
    return data;
  }
}
