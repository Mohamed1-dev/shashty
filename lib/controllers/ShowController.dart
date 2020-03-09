import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/data/Models/MactchesModel.dart';
import 'package:shashty_app/data/Models/TeamModel.dart';

import '../data/Models/ChannelOrPersonModel.dart';
import '../data/Models/ChannelShowModel.dart';
import '../data/Models/FavouriteModel.dart';
import '../data/Models/MovieShowModel.dart';
import '../data/Models/OtherShowModel.dart';
import '../data/Models/PersonShowModel.dart';
import '../data/Models/ProgramOrSeriesShowModel.dart';
import '../data/Models/ShowTimeModel.dart';
import '../data/services/ShowService.dart';
import '../sharedWidget/SharedWidgets.dart';
import '../utils/AppProvider.dart';
import '../utils/Auth.dart';

class ShowController extends ControllerMVC {
  factory ShowController() {
    if (_this == null) _this = ShowController._();
    return _this;
  }
  static ShowController _this;
  ShowController._();
  static ShowController get con => _this;
  ShowService showService = ShowService();
  ChannelOrPersonModel channelOrPersonModel;
  List<OtherShowModel> listOtherShowModel;
  List<ShowTimeModel> listShowTime;
  ChannelShowModel channelShowModel;
  List<MatchesModel> teamShowModel;
  PersonShowModel personShowModel;
  List<FavouriteModel> listFavourite;
  ProgramOrSeriesShowModel programOrSeriesShowModel;
  bool isLoading = false;
  Auth auth;
  MovieShowModel movieShowModel;
  TeamModel teamModel;

  Future getAllChannelsOrPersons(String token, bool isChannel) async {
    channelOrPersonModel = null;
    isLoading = true;
    refresh();
    channelOrPersonModel =
    await showService.getAllChannelsOrPersons(token, isChannel);
    print("channel or person");
    print("channel or person" + channelOrPersonModel.data[0].name);
    isLoading = false;
    refresh();
  }

  Future getOtherShow(int showValue, String token) async {
    isLoading = true;
    refresh();
    listOtherShowModel = await showService.getOtherShow(showValue, token);
    isLoading = false;
    refresh();
  }

  Future getFav(String token) async {
    isLoading = true;
    refresh();
    listFavourite = await showService.getfav(token);
    isLoading = false;
    refresh();
  }

  Future getProgramAndSeriesShow(
      int programOrSeriesShowModelId, bool isProgram, String token) async {
    programOrSeriesShowModel = null;
    isLoading = true;
    refresh();
    programOrSeriesShowModel = await showService.getProgramOrSeriesShowModel(
        programOrSeriesShowModelId, isProgram, token);
    isLoading = false;
    refresh();
  }

  Future getMovieShowModel(int showId, String token) async {
    movieShowModel = null;
    isLoading = true;
    refresh();
    movieShowModel = await showService.getMovieShowModel(showId, token);
    isLoading = false;
    refresh();
  }

  Future getPersonShowModel(int showId, String token) async {
    personShowModel = null;
    isLoading = true;
    refresh();
    personShowModel = await showService.getPersonShowModel(showId, token);
    isLoading = false;
    refresh();
  }

  Future getChannelShowModel(int showId, String token, String dateTime) async {
    channelShowModel = null;
     isLoading = true;
    // refresh();
    channelShowModel = await showService.getChannelShowModel(showId, token,dateTime);
    isLoading = false;
    // refresh();
  }

//  Future getTeamShowModel(int showId, String token, String dateTime , int teamId) async {
//    teamShowModel = null;
//    // isLoading = true;
//    // refresh();
//    teamShowModel = await showService.getTeamShowModel(showId, token,dateTime, teamId);
//    // isLoading = false;
//    // refresh();
//  }

//  Future getChannelShowModelButtons(int showId, String token, String dateTime) async {
//    channelShowModel = null;
////    isLoading = true;
////    refresh();
//    channelShowModel = await showService.getChannelShowModel(showId, token,dateTime);
////    isLoading = false;
////    refresh();
//  }

  Future<String> rateShow(
      int showId, bool isParentShow, rateValue, context) async {
    SharedWidgets.loading(context);
    auth = AppProvider.of(context).auth;
    String res = await showService.rateShow(
        rateValue, showId, auth.userToken, isParentShow);
    Navigator.pop(context);
    return res;
  }

  Future<bool> favShow(
      int showId, bool isParentShow, bool isFav, context) async {
    SharedWidgets.loading(context);
    auth = AppProvider.of(context).auth;
    bool res =
    await showService.favShow(isFav, showId, auth.userToken, isParentShow);
    Navigator.pop(context);
    return res;
  }

  Future<bool> favPerson(int showId, bool isFav, context) async {
    SharedWidgets.loading(context);
    auth = AppProvider.of(context).auth;
    bool res = await showService.favPerson(isFav, showId, auth.userToken);
    Navigator.pop(context);
    return res;
  }
//  ****************** fav tream ****************
  Future<bool> favTeam(int teamId, bool isFav, context) async {
    SharedWidgets.loading(context);
    auth = AppProvider.of(context).auth;
    bool res = await showService.favTeam(isFav, teamId, auth.userToken);
    Navigator.pop(context);
    return res;
  }

   Future getShowTime(int showId, bool isFilm,context,
      {bool isChannel = false, int channelID = 0}) async {
    //    SharedWidgets.loading(context);
    auth = AppProvider.of(context).auth;
    listShowTime = await showService.getShowTime(showId, auth.userToken, DateTime.now(),isFilm);
    //    Navigator.pop(context);
    refresh();
    return listShowTime;
  }

  Future<bool> remindShow(int showId, bool isParentShow, bool isRemind, context,
      DateTime startDate) async {
    SharedWidgets.loading(context);
    auth = AppProvider.of(context).auth;

    if(startDate.isBefore(DateTime.now())){
      SharedWidgets.showToastMsg("لا يمكن اضافة تذكير لمعاد فائت", false);
      return false;
    }else{
      bool res = await showService.remindShow(
          isRemind, showId, auth.userToken, isParentShow, startDate);
      SharedWidgets.showToastMsg("تمت العملية بنجاح", false);
      Navigator.pop(context);
      refresh();

      return res;
    }


  }
}
