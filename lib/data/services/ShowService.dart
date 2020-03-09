import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shashty_app/data/Models/ChannelOrPersonModel.dart';
import 'package:shashty_app/data/Models/ChannelShowModel.dart';
import 'package:shashty_app/data/Models/FavouriteModel.dart';
import 'package:shashty_app/data/Models/MactchesModel.dart';
import 'package:shashty_app/data/Models/MovieShowModel.dart';
import 'package:shashty_app/data/Models/OtherShowModel.dart';
import 'package:shashty_app/data/Models/PersonShowModel.dart';
import 'package:shashty_app/data/Models/ProgramOrSeriesShowModel.dart';
import 'package:shashty_app/data/Models/ShowTimeModel.dart';
import 'package:shashty_app/data/Models/TeamModel.dart';
import 'package:shashty_app/data/repositories/ShowRepository.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';

class ShowService extends ShowRepository {
  @override
  Future<ChannelOrPersonModel> getAllChannelsOrPersons(
      String token, bool isChannel) async {
    return await http.get(
      isChannel ? ApiRoutes.channels : ApiRoutes.persons,
      headers: {"Authorization": token.toString()},
    ).then((response) {
      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue;
        if (isChannel) {
          jsonValue = json.decode(response.body)["channels"];
        } else {
          jsonValue = json.decode(response.body)["persons"];
        }
        print(jsonValue);
        return ChannelOrPersonModel.fromJson(jsonValue);
      } else {
        return ChannelOrPersonModel();
      }
    });
  }

  @override
  Future<List<OtherShowModel>> getOtherShow(int showValue, String token) async {
    String apiValue;

    switch (showValue) {
      case 1:
        apiValue = ApiRoutes.topViews;
        break;
      case 2:
        apiValue = ApiRoutes.showSoon;
        break;
      case 3:
        apiValue = ApiRoutes.suggested;
        break;
      case 4:
        apiValue = ApiRoutes.topRating;
        break;
      case 5:
        apiValue = ApiRoutes.topFavourite;
        break;
      case 6:
        apiValue = ApiRoutes.showNow;
        break;
    }
    return await http.get(apiValue, headers: {
      "Authorization": token,
    }).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        return List<OtherShowModel>.from(
            json.decode(response.body).map((x) => OtherShowModel.fromJson(x)));
      } else {
        return List<OtherShowModel>();
      }
    });
  }

  @override
  Future<ProgramOrSeriesShowModel> getProgramOrSeriesShowModel(
      int programOrSeriesShowModelId, bool isProgram, String token) async {
    String showType = isProgram ? ApiRoutes.programShow : ApiRoutes.seriesShow;
    print("aaa " +
        ApiRoutes.shows +
        programOrSeriesShowModelId.toString() +
        showType);
    return await http.get(
        ApiRoutes.shows + programOrSeriesShowModelId.toString() + showType,
        headers: {
          "Authorization": token,
        }).then((response) {
//      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        print(jsonValue);
        return ProgramOrSeriesShowModel.fromJson(jsonValue);
      } else {
        return ProgramOrSeriesShowModel();
      }
    });
  }

  @override
  Future<MovieShowModel> getMovieShowModel(int showID, String token) async {
    print(ApiRoutes.shows + showID.toString() + ApiRoutes.movieShoe);
    return await http.get(
        ApiRoutes.shows + showID.toString() + ApiRoutes.movieShoe,
        headers: {
          "Authorization": token,
        }).then((response) {
//      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        print(jsonValue);
        return MovieShowModel.fromJson(jsonValue);
      } else {
        return MovieShowModel();
      }
    });
  }

  @override
  Future<PersonShowModel> getPersonShowModel(int showID, String token) async {
    return await http
        .get(ApiRoutes.persons + "/" + showID.toString(), headers: {
      "Authorization": token,
    }).then((response) {
//      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        print(jsonValue);
        return PersonShowModel.fromJson(jsonValue);
      } else {
        return PersonShowModel();
      }
    });
  }

  @override
  Future<ChannelShowModel> getChannelShowModel(int showID, String token ,String  dateDay) async {

    print("*********** ${dateDay.toString()}****************");
    return await http
        .get(ApiRoutes.channels + "/" + showID.toString() + "?date=" + dateDay, headers: {

      "Authorization": token,
    }).then((response) {
      print('${ApiRoutes.channels + "/" + showID.toString() + "?date=" + dateDay.toString()}');
//      print("response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print(jsonValue);
        return ChannelShowModel.fromJson(jsonValue);
      } else {
        return ChannelShowModel();
      }
    });
  }

// @override
//  Future<List<MatchesModel>>  getTeamShowModel(int showID, String token ,String  dateDay ,int teamID ) async {
//
//    print("*********** ${dateDay.toString()}****************");
//    return await http
//        .get(ApiRoutes.scheduleTeams + "?teams" + showID.toString() + "?dateFilter=" + dateDay + "&team=" + teamID.toString() , headers: {
//
//      "Authorization": token,
//    }).then((response) {
//      print('${ApiRoutes.scheduleTeams + "?teams" + showID.toString() + "?dateFilter=" + dateDay + "&team=" + teamID.toString()}');
//
//      if (response.statusCode == 200) {
////        var jsonValue = json.decode(response.body);
////        print(jsonValue);
//        return List<MatchesModel>
//      .from(
//      json.decode(response.body).map((x) => MatchesModel.fromJson(x)));
//      } else {
//        return List<MatchesModel>();
//      }
//    });
//  }




  Future<String> rateShow(
      int rate, int showId, String userToken, bool isParentShow) async {
    return await http
        .post(ApiRoutes.rate,
        headers: {"Authorization": userToken},
        body: isParentShow
            ? {"parent_show_id": showId.toString(), "rate": rate.toString()}
            : {"show_id": showId.toString(), "rate": rate.toString()})
        .then((response) {
      if (response.statusCode == 200) {
        Map jsonValue = json.decode(response.body);

        print(jsonValue);
        print(jsonValue.values.toList()[0].toString() + " ratevalue");
        return jsonValue.values.toList()[0].toString();
      } else {
        return null;
      }
    });
  }

  Future<bool> favShow(
      bool isFav, int showId, String userToken, bool isParentShow) async {
    String favType;
    if(isParentShow==null){
      favType="team";
    }else {
      if (isParentShow) {
        favType = "parent_show";
      } else {
        favType = "shows";
      }
    }

    if (isFav) {
      return await http.delete(
          ApiRoutes.favourite + "/" + showId.toString() + "?kind=$favType",
          headers: {"Authorization": userToken}).then((response) {
        if (response.statusCode == 200) {
          var jsonValue = json.decode(response.body);

          print(jsonValue);
          return true;
        } else {
          return false;
        }
      });
    } else {
      print(favType + " typeeee");
      print(showId.toString());
      print((ApiRoutes.favourite));
      try{
        return await http.post(ApiRoutes.favourite, headers: {
          "Authorization": userToken
        }, body: {
          "favourite_id": showId.toString(),
          "favourite_type": favType
        }).then((response) {
          if (response.statusCode == 200) {
            var jsonValue = json.decode(response.body);
            print("favourite success ${jsonValue.toString()}");

            print(jsonValue);
            return true;
          } else {
            print("favourite excp}");

            return false;
          }
        });
      }catch(e){
        print("favourite error ${e.toString()}");
      }
    }
  }

  Future<bool> favPerson(bool isFav, int showId, String userToken) async {
    if (isFav) {
      return await http.delete(
          ApiRoutes.favourite + "/" + showId.toString() + "?kind=person",
          headers: {"Authorization": userToken}).then((response) {
        if (response.statusCode == 200) {
          var jsonValue = json.decode(response.body);

          print(jsonValue);
          return true;
        } else {
          return false;
        }
      });
    } else {
      print("aaa");
      print(showId.toString());
      print((ApiRoutes.favourite));
      return await http.post(ApiRoutes.favourite, headers: {
        "Authorization": userToken
      }, body: {
        "favourite_id": showId.toString(),
        "favourite_type": "person"
      }).then((response) {
        if (response.statusCode == 200) {
          var jsonValue = json.decode(response.body);

          print(jsonValue);
          return true;
        } else {
          return false;
        }
      });
    }
  }
  Future<bool> favTeam(bool isFav, int teamId, String userToken) async {
    if (isFav) {
      return await http.delete(
          ApiRoutes.favourite + "/" + teamId.toString() + "?kind=team",
          headers: {"Authorization": userToken}).then((response) {
        if (response.statusCode == 200) {
          var jsonValue = json.decode(response.body);

          print(jsonValue);
          return true;
        } else {
          return false;
        }
      });
    } else {
      print("teamId");
      print(teamId.toString());
      print((ApiRoutes.favourite));
      return await http.post(ApiRoutes.favourite, headers: {
        "Authorization": userToken
      }, body: {
        "favourite_id": teamId.toString(),
        "favourite_type": "team"
      }).then((response) {
        if (response.statusCode == 200) {
          var jsonValue = json.decode(response.body);

          print(jsonValue);
          TeamModel.fromJson(jsonValue);
          return true;
        } else {
          return false;
        }
      });
    }
  }

//  Future<bool> remindShow(bool isRemind, int showId, String userToken,
//      bool isParentShow, DateTime startDate) async {
//    String remindType;
//    if(isParentShow==null){
//      remindType = "team";
//
//    }else{
//      if (isParentShow) {
//        remindType = "parent_show";
//      } else {
//        remindType = "shows";
//      }
//    }
//
//    if (isRemind) {
//      return await http.delete(
//          ApiRoutes.reminder +
//              "/" +
//              showId.toString() +
//              "?kind=$remindType&start_date=" +
//              startDate.year.toString() +
//              "/" +
//              startDate.month.toString() +
//              "/" +
//              startDate.day.toString() +
//              " " +
//              startDate.hour.toString() +
//              ":" +
//              startDate.minute.toString() +
//              ":" +
//              startDate.second.toString(),
//          headers: {"Authorization": userToken}).then((response) {
//        if (response.statusCode == 200) {
//          var jsonValue = json.decode(response.body);
//
//          print("response reminder ****  $jsonValue");
//
//          return true;
//        } else {
//          return false;
//        }
//      });
//    } else {
//      print({
//        "reminderable_id": showId.toString(),
//        "reminderable_type": remindType,
//        "start_date": startDate.year.toString() +
//            "/" +
//            startDate.month.toString() +
//            "/" +
//            startDate.day.toString() +
//            " " +
//            startDate.hour.toString() +
//            ":" +
//            startDate.minute.toString() +
//            ":" +
//            startDate.second.toString()
//      }.toString() +
//          " john");
//      print(showId.toString());
//      print((ApiRoutes.reminder));
//      return await http.post(ApiRoutes.reminder, headers: {
//        "Authorization": userToken
//      }, body: {
//        "reminderable_id": showId.toString(),
//        "reminderable_type": remindType,
//        "start_date": startDate.year.toString() +
//            "/" +
//            startDate.month.toString() +
//            "/" +
//            startDate.day.toString() +
//            " " +
//            startDate.hour.toString() +
//            ":" +
//            startDate.minute.toString() +
//            ":" +
//            startDate.second.toString()
//      }).then((response) {
//        if (response.statusCode == 200) {
//          var jsonValue = json.decode(response.body);
//          print(jsonValue.toString() + " valueaa");
//          print(jsonValue);
//          return true;
//        } else {
//          return false;
//        }
//      });
//    }
//  }


  Future<bool> remindShow(bool isRemind, int showId, String userToken,
      bool isParentShow, DateTime startDate) async {
    String remindType;
    if(isParentShow==null){
      remindType = "team";
    }else{
      remindType = "shows";
    }

    if (isRemind) {

      return await http.delete(
          ApiRoutes.reminder +
              "/" +
              showId.toString() +
              "?kind=$remindType&start_date="+DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate),

          headers: {"Authorization": userToken}).then((response) {
        if (response.statusCode == 200) {
          var jsonValue = json.decode(response.body);

          print("response remove reminder ****  $jsonValue");

          return null;
        } else {
          return false;
        }

      });
    }
    else {
      print({
        "reminderable_id": showId.toString(),
        "reminderable_type": remindType,
        "start_date": DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate)
//        startDate.year.toString() +
//            "/" +
//            startDate.month.toString() +
//            "/" +
//            startDate.day.toString() +
//            " " +
//            startDate.hour.toString() +
//            ":" +
//            startDate.minute.toString() +
//            ":" +
//            startDate.second.toString()
      }.toString() +
          " ****** jhon ****");
      print(showId.toString());
      print(('${ApiRoutes.reminder}?reminderable_id: ${showId.toString()}&"reminderable_type": $remindType&"start_date":${DateFormat('yyyy-MM-dd hh:mm:ss').format(startDate)}'));
      return await http.post(ApiRoutes.reminder, headers: {
        "Authorization": userToken
      }, body: {
        "reminderable_id": showId.toString(),
        "reminderable_type": remindType,
        "start_date":DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate)

      }).then((response) {
        if (response.statusCode == 200) {
          var jsonValue = json.decode(response.body);
          print("response add reminder ****  $jsonValue");
          print(jsonValue);
          return true;
        } else {
          return false;
        }
      });
    }
  }

   Future<List<ShowTimeModel>> getShowTime(int showId, String userToken,DateTime dateDay,bool isFilm,
       { int channelID = 0}) async {
    print("show times gets called");
    print("is film value"+ isFilm.toString());

    try{
     return await http.get(
     isFilm?
          "http://api.shashty.tv/api/shows/" + showId.toString()+"?category_id=1"+"?date=$dateDay"
             :"http://api.shashty.tv/api/show-times/"+ showId.toString()+"?date=$dateDay",
         //ApiRoutes.showTime + showId.toString() + "?channel_id=$channelID?date=$dateDay",
          headers: {
           "Authorization": userToken,
         }).then((response) {
       if (response.statusCode == 200) {
         print("show time "+ response.toString());
         List<dynamic> jsonValue;
         if(isFilm)
         jsonValue = json.decode(response.body)["channels"];
         else
           jsonValue = json.decode(response.body);
          return  List<ShowTimeModel>.from(
              jsonValue.map((x) => ShowTimeModel.fromJson(x)));
       } else {
         return List<ShowTimeModel>();
       }
     });
   }catch(e){
      print("get shows exceptions"+e.toString());
    }
  }

  Future<List<FavouriteModel>> getfav(String token) async {
    return await http.get(ApiRoutes.favourite, headers: {
      "Authorization": token,
    }).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print(jsonValue);
        return List<FavouriteModel>.from(
            json.decode(response.body).map((x) => FavouriteModel.fromJson(x)));
      } else {
        return List<FavouriteModel>();
      }
    });
  }


}
