import 'package:dio/dio.dart' as Dio;
import 'package:http/http.dart';
import 'package:shashty_app/data/Models/EditProfileModel.dart';
import 'package:shashty_app/data/Models/LoginUserModel.dart';
import 'package:shashty_app/data/Models/RegisterUserModel.dart';

import 'Repository.dart';

abstract class UserRepository extends Repository {
  Future<Response> signInWithEmailAndPassword(LoginUserModel loginUserModel);

  Future<Response> regNewUser(RegisterUserModel registerUserModel);

  Future<Response> getCurrentUser(String token);
  Future<Response> resetPassword(String email);
  Future<Dio.Response<dynamic>> editProfile(
      EditProfileModel editProfileModel, String token);

  Future<bool> logOut(String token, String fireBaseToken);
}
