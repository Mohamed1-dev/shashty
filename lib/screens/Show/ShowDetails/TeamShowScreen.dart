import 'dart:convert';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/HomeController.dart';
import 'package:shashty_app/controllers/ShowController.dart';
import 'package:shashty_app/data/Models/ChannelShowModel.dart';
import 'package:shashty_app/data/Models/MactchesModel.dart';
import 'package:shashty_app/data/Models/TeamModel.dart';
import 'package:shashty_app/sharedWidget/FavouritePopup.dart';
import 'package:shashty_app/sharedWidget/RatePopup.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;

import '../../NoNetworkScreen.dart';

class TeamShowScreen extends StatefulWidget {
  final int teamID;

  final String token;
  final HomeController homeController;
  final String title;
  final String imageTeam;

  TeamShowScreen(
      {Key key,
        this.teamID,
        this.token,
        this.homeController,
        this.title,
        this.imageTeam})
      : super(key: key);

  @override
  _TeamShowScreenState createState() => _TeamShowScreenState();
}

class _TeamShowScreenState extends State<TeamShowScreen> {
  List<MatchesModel> teamShowModel;
  TeamModel teamshowModel;

  bool isLoading = false;
  int isfavourite = 0;

  Auth auth;

  int selectedIndex = 0;

  bool isSelected = false;

  var screenWidth;
  var screenHeight;
  Future<List<MatchesModel>> futureTeam;
  Future<TeamModel> teamModel;

  @override
  void initState() {
    // TODO: implement initState

    teamModel = getFavouriteTeam(widget.teamID, widget.token);

    futureTeam = getTeamShowModel(
        widget.token,
        DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
        widget.teamID);

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    await initializeDateFormatting("ar_SA", null);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.9),
        title: Text('بيانات الفريق'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: FutureBuilder(
              future: futureTeam,
              builder: (context, snapshot) {
                teamShowModel = snapshot.data;
                return snapshot.data == null
                    ? Center(
                    child: FadeInImage(
                      image: AssetImage(FixedAssets.noImage),
                      placeholder: AssetImage(FixedAssets.noImage),
                    ))
                    : Container(
                  height: screenHeight,
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[

                            Container(
                              width:
                              MediaQuery.of(context).size.width / 3,
                              height:
                              MediaQuery.of(context).size.width / 3,
                              decoration: new BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: new DecorationImage(
                                  image:
                                  widget.imageTeam != null
                                    ? NetworkImage(
                                  "http://koramania.cloudapp.net/FBMSImages/${widget.imageTeam}",
                                )
                                    : AssetImage(
                                    FixedAssets.noImage),
                                  fit: BoxFit.fill,
                                ),
                                border: Border.all(
                                    color: Colors.white,
                                    width: 2.0),
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(
                                        MediaQuery.of(context)
                                            .size
                                            .width /
                                            3)),
                              ),

                            ),
//                            Container(
//                              margin: EdgeInsets.symmetric(
//                                  vertical: 5.0, horizontal: 5.0),
//                              height: MediaQuery.of(context)
//                                  .size
//                                  .height /
//                                  4,
//                              child: FadeInImage(
//                                width: screenWidth,
//                                fit: BoxFit.cover,
//                                height: MediaQuery.of(context)
//                                    .size
//                                    .height /
//                                    4,
//                                image: widget.imageTeam != null
//                                    ? NetworkImage(
//                                  "http://koramania.cloudapp.net/FBMSImages/${widget.imageTeam}",
//                                )
//                                    : AssetImage(
//                                    FixedAssets.noImage),
//                                placeholder: new AssetImage(
//                                    FixedAssets.noImage),
//                              ),
//                            ),
//
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        child: Column(
                          children: <Widget>[
                            FutureBuilder(
                                future: teamModel,
                                builder: (context, snapshot) {
                                  teamshowModel = snapshot.data;

                                  if (teamShowModel == null) {
                                    return Container(
                                      child: Center(
                                        child:
                                        CircularProgressIndicator(),
                                      ),
                                    );
                                  } else
                                    return Container(
                                      decoration: BoxDecoration( shape: BoxShape.circle, color: Colors.black38),
                                      margin: EdgeInsets.all(5.0),
                                      padding:
                                      const EdgeInsets
                                          .only(top: 3.0,bottom: 5.0,left: 8.0,right: 0.0),
                                      child:
                                      teamshowModel ==
                                          null
                                          ? IconButton(
                                        icon: Icon(Icons
                                            .favorite_border , size: 40,),
                                      )
                                          : IconButton(
                                          icon: Icon(
                                            teamshowModel.userFavourite == 0
                                                ? Icons
                                                .favorite_border
                                                : Icons
                                                .favorite,
                                            color: teamshowModel.userFavourite == 0
                                                ? Colors
                                                .white
                                                : Colors
                                                .red,
                                            size: 40,
                                          ),
                                          onPressed:
                                              () {
//                         ***************** team favourite ************

                                            showDialog(
                                                context:
                                                context,
                                                builder:
                                                    (BuildContext context) {
                                                  return FavouritePopup(
                                                      teamshowModel.id,
                                                      teamshowModel.userFavourite == 1 ? true : false,
                                                      null, (value) {
                                                    print(value.toString() + " valueee");
//                                                                          () {
                                                    teamshowModel.userFavourite = value.toInt();

//                                                                        refresh();
                                                    setState(() {});
                                                  });
                                                });
                                            setState(
                                                    () {});

                                            print(
                                                '${teamshowModel.userFavourite} ****** userFavourite ');
                                            print(
                                                '${teamshowModel.userFavourite} ******  userFavourite future ');
                                            print(
                                                'Favourite time tapped');
                                          }),
                                    );
                                }),

                            BorderedText(
                              strokeWidth: 10.0,
                              strokeColor: Colors.black,
                              child: Text(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: FixedAssets.ruqaFont,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: teamShowModel.length == 0
                            ? Container(
                            child: Center(
                                child: Text(
                                  "لا توجد مواعيد عرض حاليا",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25),
                                )))
                            : ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int i) {
                              return Divider(
                                  color: Colors.grey);
                            },
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: teamShowModel.length,
                            itemBuilder: (context, index) {
                              teamShowModel.sort((a,b) => a.matchDate.compareTo(b.matchDate));
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration:
                                              new BoxDecoration(
                                                color: const Color(
                                                    0xff7c94b6),
                                                image:
                                                new DecorationImage(
                                                  image:
                                                  NetworkImage(
                                                    "http://koramania.cloudapp.net/FBMSImages/${teamShowModel[index].homeTeamLogo}",
                                                  ),
                                                  fit: BoxFit
                                                      .fill,
                                                ),
                                                borderRadius:
                                                new BorderRadius
                                                    .all(
                                                    Radius.circular(
                                                        50)),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Text(
                                                "${teamShowModel[index].homeTeamName}",
                                                style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontSize: 11),
                                                overflow:
                                                TextOverflow
                                                    .clip,
                                                textAlign:
                                                TextAlign
                                                    .center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Flexible(
                                        flex: 5,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .all(1.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical:
                                                    5.0),
                                                child: Text(
                                                  teamShowModel[
                                                  index]
                                                      .leagueName
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors
                                                          .white,
                                                      fontSize:
                                                      11),
                                                  textAlign:
                                                  TextAlign
                                                      .center,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: <
                                                    Widget>[
                                                  AutoSizeText(
                                                    "${DateFormat('yyyy/MM/dd').format(teamShowModel[index].matchDate).toString()}",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .red,
                                                        fontSize:
                                                        18),
                                                    overflow:
                                                    TextOverflow
                                                        .clip,
                                                    textAlign:
                                                    TextAlign
                                                        .center,
                                                  ),
                                                  Text(
                                                    "${DateFormat.jm('ar_SA').format(teamShowModel[index].matchDate)} ",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .red,
                                                        fontSize:
                                                        16),
                                                    textAlign:
                                                    TextAlign
                                                        .center,
                                                  ),
                                                ],
                                              ),

                                              //             Check Time Condition For Time
                                              teamShowModel[index].matchDate.isBefore(DateTime.now())  ?
                                              SizedBox(height: 0,)
                                              : Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: <
                                                    Widget>[
                                                  Text(
                                                    "تذكير بالموعد؟",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white70,
                                                        fontSize:
                                                        14),
                                                  ),


                                                  IconButton(
                                                      icon:
                                                      Icon(
                                                        Icons
                                                            .alarm,
                                                        color: teamShowModel[index].userRemind ==
                                                            1
                                                            ? Colors.red
                                                            : Colors.white,
                                                      ),
                                                      onPressed:
                                                          () async {


                                                        print(
                                                            '${teamShowModel[index].userRemind} **** => teamShowModel[index].userRemind');
//                                                                        print('${widget.homeController.matchesToday[index].userRemind} **** =>  widget.homeController.matchesToday[index].userRemind');
                                                        print(' ******  before tapped  team screen ************** ');
                                                        try{
                                                          await widget
                                                              .homeController
                                                              .remindShow(
                                                              teamShowModel[index].matchId,
                                                              null,
                                                              teamShowModel[index].userRemind == 1 ? true : false,
                                                              context,
                                                              teamShowModel[index].matchDate)
                                                              .then((value) {
                                                            if (value==null) {
//                                                                              widget.homeController.matchesToday[index].userRemind =1;
                                                              teamShowModel[index].userRemind =
                                                              0;
                                                             } else if(value) {
//                                                                            widget.homeController.matchesToday[index].userRemind =0;
                                                              teamShowModel[index].userRemind =
                                                              1;
                                                             }

                                                          });
                                                          setState(
                                                                  () {});
                                                        }catch (e){
                                                          print('error message ******  ${e.toString()} ');
                                                        }
                                                        print(' ******  after tapped  team screen ************** ');
                                                        print(
                                                            '${teamShowModel[index].userRemind} **** =>  teamShowModel[index].userRemind');
//                                                                        print('${widget.homeController.matchesToday[index].userRemind} **** =>  widget.homeController.matchesToday[index].userRemind');
//                                                                        await widget
//                                                                            .homeController
//                                                                            .remindShow(
//                                                                                teamShowModel[index].matchId,
//                                                                                null,
//                                                                                widget.homeController.matchesToday[index].userRemind ==
//                                                                                    1 ? true : false,
//                                                                                context,
//                                                                                widget.homeController.matchesToday[index].matchDate)
//                                                                            .then(
//                                                                          (value) {
//                                                                            if (value) {
//                                                                              widget.homeController.matchesToday[index].userRemind = 1;
//                                                                              teamShowModel[index].userRemind = 1;
//                                                                            } else {
//                                                                              widget.homeController.matchesToday[index].userRemind = 0;
//                                                                              teamShowModel[index].userRemind = 0;
//                                                                            }
//                                                                          },
//                                                                        );
                                                      })

                                                ],
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration:
                                              new BoxDecoration(
                                                color: const Color(
                                                    0xff7c94b6),
                                                image:
                                                new DecorationImage(
                                                  image:
                                                  NetworkImage(
                                                    "http://koramania.cloudapp.net/FBMSImages/${teamShowModel[index].awayTeamLogo}",
                                                  ),
                                                  fit: BoxFit
                                                      .fill,
                                                ),
                                                borderRadius:
                                                new BorderRadius
                                                    .all(
                                                    Radius.circular(
                                                        50)),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Text(
                                                "${teamShowModel[index].awayTeamName}",
                                                style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontSize: 11),
                                                textAlign:
                                                TextAlign
                                                    .center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<List<MatchesModel>> getTeamShowModel(
      String token, String dateDay, int teamID) async {
    print("*********** ${dateDay.toString()}****************");
    try {
      print(
          "http://api.shashty.tv/api/get-schedule-teams?teams[0]=$teamID&dateFilter=$dateDay");
      return await http.post(
          "http://api.shashty.tv/api/get-schedule-teams?teams[0]=$teamID&dateFilter=$dateDay",
          headers: {
            "Authorization": token,
          }).then((response) {
        if (response.statusCode == 200) {
          var jsonValue = json.decode(response.body);
          print("matches success " + jsonValue.toString());
          teamShowModel = matchesModelFromJson(response.body);
          isLoading = false;

          return teamShowModel;
        } else {
          print("error get all home");
          isLoading = false;
          return null;
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<TeamModel> getFavouriteTeam(int teamId, String token) async {
    print("*********** ${teamId.toString()}****************");
    return await http.get('http://api.shashty.tv/api/teams/$teamId', headers: {
      "Authorization": token,
    }).then((response) {
      print('http://api.shashty.tv/api/teams/$teamId');
      print("**** => response code " + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print(jsonValue);
        return TeamModel.fromJson(jsonValue);
      } else {
        return TeamModel();
      }
    });
  }
}