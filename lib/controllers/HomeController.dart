import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/data/Models/FilterCategoryModel.dart';
import 'package:shashty_app/data/Models/HomeModel.dart';
import 'package:shashty_app/data/Models/MactchesModel.dart';
import 'package:shashty_app/data/Models/ShowTimeModel.dart';
//import 'package:shashty_app/data/Models/TeamShowModel.dart';
import 'package:shashty_app/data/services/FilterService.dart';
import 'package:shashty_app/data/services/HomeService.dart';
import 'package:shashty_app/data/services/ShowService.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:http/http.dart' as http;

class HomeController extends ControllerMVC {
  factory HomeController() {
    if (_this == null) _this = HomeController._();
    return _this;
  }
  List<Tab> listTabs = List<Tab>();
  TabController tabController;
  int currentValue;
  static HomeController _this;
  HomeController._();
  List<ShowTimeModel> listShowTime;
  List<Widget> listTabsWidgets = List<Widget>();
  Widget selectedView;
//  TabController tabController;
//  List<Tab> listTabs = List<Tab>();
//  List<Widget> listTabsWidgets = List<Widget>();
  ShowService showService = ShowService();
  HomeService homeService = HomeService();
  HomeModel homeModel;
  List<MatchesModel> matchesToday;
  bool isLoading = true;
  Future init(String token) async {
    homeModel = null;
    isLoading = true;
    print("1   => ******* isLoading = true;");
    print(isLoading.toString() + "1");
    refresh();
    print("11   *****   refresh();");
    print(isLoading.toString() + "2");
     await getAllMatches(token).then((value)async{
       matchesToday=value;
       await getGetAllCategory(token);
     });


    print("111");
    print("loading matches");

    print(isLoading.toString() + "3");
    isLoading = false;
    print("1111");
    print(isLoading.toString() + "4");
    refresh();
    print("there 1");
  }

  Future getGetAllCategory(String token) async {
    print("11111");
    print(isLoading.toString() + "5");
    homeModel = await homeService.getAllHomeCategory(token);
    print("111111");
    isLoading = false;

    refresh();
    print(isLoading.toString() + "6");
  }
  Future<List<MatchesModel>> getAllMatches(String token) async {
    return await http.get("http://api.shashty.tv/api/get-teams-played-today", headers: {
      "Authorization": token,
    }).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print("matches success " + jsonValue.toString());
        return matchesModelFromJson(response.body);
      } else
        print("error get all home");
      return null;
    });
   }
//   ********************** getTeamMatches **********

//   Future<List<TeamShowModel>> getTeamMatches(String token , int teamId , String dateTeam) async {
//    return await http.get("api.shashty.tv/api/get-schedule-teams?teams[0]=$teamId&dateFilter=$dateTeam", headers: {
//      "Authorization": token,
//    }).then((response) {
//      print("api.shashty.tv/api/get-schedule-teams?teams[0]=$teamId&dateFilter=$dateTeam");
//      if (response.statusCode == 200) {
//        var jsonValue = json.decode(response.body);
//        print("matches success " + jsonValue.toString());
//        return teamShowModelFromJson(response.body);
//      } else
//        print("error get all home");
//      return null;
//    });
//   }






 /* Future getAllMatches(String token) async {
    print("matches");
    print(isLoading.toString() + "5");
     await homeService.getAllMatches(token);
    print("111111");
    isLoading = false;

    refresh();
    print(isLoading.toString() + "6");
  }*/
  Auth auth;

  static HomeController get con => _this;
  int get _currentTab => currentTab;
  int currentTab = 0;

  Future getShowTime(int showId, bool isFilm,context) async {
//    SharedWidgets.loading(context);
    auth = AppProvider.of(context).auth;
    listShowTime = await showService.getShowTime(showId, auth.userToken,DateTime.now(),isFilm);
//    Navigator.pop(context);
    refresh();
    return listShowTime;
  }

  Future<bool> remindShow(int showId, bool isParentShow, bool isRemind, context,
      DateTime startDate) async {

    var now = new DateTime.now();
    var later = now.add(const Duration(days: 60));

    if(startDate.isAfter(later)){
      SharedWidgets.showToastMsg("لا يمكن اضافة تذكير لموعد بعد شهرين", true);
      return false;
    }else {
      print(showId.toString() + " ww");
      SharedWidgets.loading(context);
      auth = AppProvider.of(context).auth;
      bool res = await showService.remindShow(
          isRemind, showId, auth.userToken, isParentShow, startDate);
      SharedWidgets.showToastMsg("تمت العملية بنجاح", false);
      Navigator.pop(context);
      return res;
    }
  }

  bool isLoadingFilter = false;

  FilterService filterService = FilterService();
  FilterCategoryModel filterCategoryModel;
  Future initFilter(BuildContext context, int id, String token) async {
    filterCategoryModel = null;
    isLoadingFilter = true;
    refresh();
    print("get all catttttt $id");
    await getAllCategory(id, token);
    isLoadingFilter = false;
    refresh();
  }

  Future getAllCategory(int id, String token) async {
    print("get all cat $id");
    filterCategoryModel = await filterService.getFilterCategory(id, token);
    isLoadingFilter = false;
    refresh();
  }

  bool isThereMoreChild = true;

  Future getAllNextPage(int id, int page, String token) async {
    print("i'm here next page " + page.toString());
    isLoadingFilter = true;
    refresh();
    await filterService.getFilterCategoryNextPage(id, page, token).then((v) {
      if (v.data.length != 0) {
        filterCategoryModel.data.addAll(v.data);
      } else {
        isThereMoreChild = false;
      }
    });
    isLoadingFilter = false;
    refresh();
  }
}
