import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shashty_app/data/Models/HomeModel.dart';
import 'package:shashty_app/data/Models/MactchesModel.dart';
import 'package:shashty_app/data/repositories/HomeRepository.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';

class HomeService extends HomeRepository {
  @override
  Future<HomeModel> getAllHomeCategory(String token) async {
    print(ApiRoutes.home + "   home");
    return await http.get(ApiRoutes.home, headers: {
      "Authorization": token,
    }).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print("done " + jsonValue.toString());
        return HomeModel.fromJson(jsonValue);
      } else
        print("error get all home");
      return HomeModel();
    });
  }


}
