import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/data/Models/FilterCategoryModel.dart';
import 'package:shashty_app/data/services/FilterService.dart';

class FilterController extends ControllerMVC {
  factory FilterController() {
    if (_this == null) _this = FilterController._();
    return _this;
  }
  static FilterController _this;
  FilterController._();

  FilterService filterService = FilterService();
  FilterCategoryModel filterCategoryModel;
  bool isLoading = false;
  Future init(BuildContext context, int id, String token) async {
    filterCategoryModel = null;
    isLoading = true;
    refresh();
    print("get all catttttt $id");
    await getAllCategory(id, token);
    isLoading = false;
    refresh();
  }

  Future getAllCategory(int id, String token) async {
    print("get all cat $id");
    filterCategoryModel = await filterService.getFilterCategory(id, token);
    isLoading = false;
    refresh();
  }

  bool isThereMoreChild = true;

  Future getAllNextPage(int id, int page, String token) async {
    print("i'm here next page " + page.toString());
    isLoading = true;
    refresh();
    await filterService.getFilterCategoryNextPage(id, page, token).then((v) {
      if (v.data.length != 0) {
        filterCategoryModel.data.addAll(v.data);
      } else {
        isThereMoreChild = false;
      }
    });
    isLoading = false;
    refresh();
  }

  static FilterController get con => _this;
}
