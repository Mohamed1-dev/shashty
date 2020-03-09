import 'UserModel.dart';

class UserModelWithToken {
  String accessToken;
  String tokenType;
  UserModel userModel;

  UserModelWithToken({
    this.accessToken,
    this.tokenType,
    this.userModel,
  });

  factory UserModelWithToken.fromJson(Map<String, dynamic> json) =>
      new UserModelWithToken(
        tokenType: json["token_type"] == null ? null : json["token_type"],
        accessToken: json["access_token"] == null
            ? null
            : "Bearer " + json["access_token"],
        userModel:
            json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );
}
