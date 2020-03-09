import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shashty_app/data/Models/FilterCategoryModel.dart';
import 'package:shashty_app/data/repositories/FiltterRepository.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';

class FilterService extends FiltterRepository {
  @override
  Future<FilterCategoryModel> getFilterCategory(int id, String token) async {
    print(ApiRoutes.filterCategories + id.toString());
    return await http.get(ApiRoutes.filterCategories + id.toString(), headers: {
      "Authorization": token,
    }).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        return FilterCategoryModel.fromJson(jsonValue);
      } else
        return FilterCategoryModel();
    });
  }

  @override
  Future<FilterCategoryModel> getFilterCategoryNextPage(
      int id, int page, String token) async {
    return await http.get(
        ApiRoutes.filterCategories +
            id.toString() +
            ApiRoutes.page +
            page.toString(),
        headers: {
          "Authorization": token,
        }).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print("done " + jsonValue.toString());
        return FilterCategoryModel.fromJson(jsonValue);
      } else
        print("error get all home");
      return FilterCategoryModel();
    });
  }
}
