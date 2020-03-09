import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shashty_app/data/Models/CategoriesSearchModel.dart';
import 'package:shashty_app/data/Models/OtherShowModel.dart';
import 'package:shashty_app/data/repositories/SearchRepository.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';

class SearchService extends SearchRepository {
  @override
  Future<CategoriesSearchModel> getAllCategories(String token) async {
    return await http.get(ApiRoutes.categories, headers: {
      "Authorization": token,
    }).then((response) {
//      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        print(jsonValue);
        return CategoriesSearchModel.fromJson(jsonValue);
      } else {
        return CategoriesSearchModel();
      }
    });
  }

  @override
  Future<List<OtherShowModel>> getAllMovieResult(
      String word, DateTime date, int subCatId, String token) async {
    print(word.toString() +
        " 1 " +
        date.toString() +
        " 2 " +
        subCatId.toString() +
        " 3 ");
    String wordApi = "";
    String subCarIdApi = "";
    String dateApi = "";
    if (word.isNotEmpty && word.toString() != "") {
      wordApi = "&name=" + word;
    }

    if (subCatId.toString() != null &&
        subCatId.toString() != "" &&
        subCatId != 0) {
      subCarIdApi = "&subCategory=" + subCatId.toString();
    }

    if (date.toString() != null && date != null && date.toString() != "") {
      dateApi = "&showTime=" +
          date.year.toString() +
          "/" +
          date.month.toString() +
          "/" +
          date.day.toString();
    }
    print(ApiRoutes.filter + "category=1" + subCarIdApi + wordApi + dateApi);
    return await http.get(
        ApiRoutes.filter + "category=1" + subCarIdApi + wordApi + dateApi,
        headers: {
          "Authorization": token,
        }).then((response) {
//      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        return List<OtherShowModel>.from(json
            .decode(response.body)['data']
            .map((x) => OtherShowModel.fromJson(x)));
      } else {
        return List<OtherShowModel>();
      }
    });
  }

  @override
  Future<List<OtherShowModel>> getAllProgramsResult(
      String word, date, int subCatId, String token) async {
    print(word.toString() +
        " 1 " +
        date.toString() +
        " 2 " +
        subCatId.toString() +
        " 3 ");
    String wordApi = "";
    String subCarIdApi = "";
    String dateApi = "";
    if (word.isNotEmpty && word.toString() != "") {
      wordApi = "&name=" + word;
    }

    if (subCatId.toString() != null &&
        subCatId.toString() != "" &&
        subCatId != 0) {
      subCarIdApi = "&subCategory=" + subCatId.toString();
    }

    if (date.toString() != null && date != null && date.toString() != "") {
      dateApi = "&showTime=" +
          date.year.toString() +
          "/" +
          date.month.toString() +
          "/" +
          date.day.toString();
    }
    print(ApiRoutes.filter + "category=3" + subCarIdApi + wordApi + dateApi);
    return await http.get(
        ApiRoutes.filter + "category=3" + subCarIdApi + wordApi + dateApi,
        headers: {
          "Authorization": token,
        }).then((response) {
//      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        return List<OtherShowModel>.from(json
            .decode(response.body)['data']
            .map((x) => OtherShowModel.fromJson(x)));
      } else {
        return List<OtherShowModel>();
      }
    });
  }

  Future<List<OtherShowModel>> getAllSeriesResult(
      word, DateTime date, int subCatId, String token) async {
    print(word.toString() +
        " 1 " +
        date.toString() +
        " 2 " +
        subCatId.toString() +
        " 3 ");
    String wordApi = "";
    String subCarIdApi = "";
    String dateApi = "";
    if (word.isNotEmpty && word.toString() != "") {
      wordApi = "&name=" + word;
    }

    if (subCatId.toString() != null &&
        subCatId.toString() != "" &&
        subCatId != 0) {
      subCarIdApi = "&subCategory=" + subCatId.toString();
    }

    if (date.toString() != null && date != null && date.toString() != "") {
      dateApi = "&showTime=" +
          date.year.toString() +
          "/" +
          date.month.toString() +
          "/" +
          date.day.toString();
    }
    print(ApiRoutes.filter + "category=2" + subCarIdApi + wordApi + dateApi);
    return await http.get(
      ApiRoutes.filter + "category=2" + subCarIdApi + wordApi + dateApi,
      headers: {"Authorization": token},
    ).then((response) {
//      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        return List<OtherShowModel>.from(json
            .decode(response.body)['data']
            .map((x) => OtherShowModel.fromJson(x)));
      } else {
        return List<OtherShowModel>();
      }
    });
  }

  Future<List<OtherShowModel>> getAllPersonsResult(
      word, int subCatId, String token) async {
    String wordApi = "";
    String subCarIdApi = "";

    if (word.isNotEmpty && word.toString() != "") {
      if (subCatId.toString() != null &&
          subCatId.toString() != "" &&
          subCatId != 0) {
        wordApi = "&name=" + word;
      } else {
        wordApi = "?name=" + word;
      }
    }

    if (subCatId.toString() != null &&
        subCatId.toString() != "" &&
        subCatId != 0) {
      subCarIdApi = "?subCategory=" + subCatId.toString();
    }

    print(ApiRoutes.persons + subCarIdApi + wordApi);
    return await http.get(
      ApiRoutes.persons + subCarIdApi + wordApi,
      headers: {"Authorization": token},
    ).then((response) {
//      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        return List<OtherShowModel>.from(json
            .decode(response.body)["persons"]['data']
            .map((x) => OtherShowModel.fromJson(x)));
      } else {
        return List<OtherShowModel>();
      }
    });
  }

  Future<List<OtherShowModel>> getAllChannelsResult(
      word, int subCatId, String token) async {
    String wordApi = "";
    String subCarIdApi = "";

    if (word.isNotEmpty && word.toString() != "") {
      if (subCatId.toString() != null &&
          subCatId.toString() != "" &&
          subCatId != 0) {
        wordApi = "&name=" + word;
      } else {
        wordApi = "?name=" + word;
      }
    }

    if (subCatId.toString() != null &&
        subCatId.toString() != "" &&
        subCatId != 0) {
      subCarIdApi = "?subCategory=" + subCatId.toString();
    }

    print(ApiRoutes.channels + subCarIdApi + wordApi);
    return await http.get(
      ApiRoutes.channels + subCarIdApi + wordApi,
      headers: {"Authorization": token},
    ).then((response) {
//      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        return List<OtherShowModel>.from(json
            .decode(response.body)["channels"]['data']
            .map((x) => OtherShowModel.fromJson(x)));
      } else {
        return List<OtherShowModel>();
      }
    });
  }
}
