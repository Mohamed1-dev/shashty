import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shashty_app/controllers/HomeController.dart';
import 'package:shashty_app/data/Models/MactchesModel.dart';
import 'package:shashty_app/screens/Show/ShowDetails/TeamShowScreen.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:http/http.dart' as http;

class MatchesTodayScreen extends StatefulWidget {
  List<MatchesModel> matches;
  HomeController homeController;
  String token;

  MatchesTodayScreen({this.matches, this.homeController, this.token});

  @override
  _MatchesTodayScreenState createState() => _MatchesTodayScreenState();
}

class _MatchesTodayScreenState extends State<MatchesTodayScreen> {
  List<DateTime> _pickedDate = [
    DateTime.now(),
    DateTime.now().add(Duration(days: 1)),
    DateTime.now().add(Duration(days: 2)),
    DateTime.now().add(Duration(days: 3)),
    DateTime.now().add(Duration(days: 4)),
  ];
  int selectedIndex = 0;
  bool isSelected = false;
  bool isLoading = false;
  List<MatchesModel> matches;

  @override
  void initState() {
    // TODO: implement initState
    matches = widget.matches;

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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.9),
        title: Text('مواعيد المباريات'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
//        shrinkWrap: true,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.only(bottom: 6.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _pickedDate.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        print(
                            'date Time Tapped *** ${DateFormat("yyyy-MM-dd").format(_pickedDate[index])}');
                        selectedIndex = index;

                        await getAllMatches(DateFormat("yyyy-MM-dd")
                                .format(_pickedDate[selectedIndex])
                                .toString())
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5.0,
                        child: Container(
                          color: Colors.black87,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                '${DateFormat.EEEE('ar_SA').format(_pickedDate[index]).toString()}',
                                style: TextStyle(
                                    color: index == selectedIndex
                                        ? Colors.white
                                        : Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${DateFormat.MMMMd('ar_SA').format(_pickedDate[index]).toString()}',
                                style: TextStyle(
                                    color: index == selectedIndex
                                        ? Colors.white
                                        : Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
//              height: MediaQuery.of(context).size.height ,
//              width: MediaQuery.of(context).size.width,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : matches.length == 0
                      ? Container(
                          child: Center(
                            child: Text(
                              'لا يوجد مباريات اليوم ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        )
                      : ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(color: Colors.grey);
                          },
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: matches.length,
                          itemBuilder: (context, index) {
                            matches.sort(
                                (a, b) => a.matchDate.compareTo(b.matchDate));

//                        matches[index].matchDate ??
//                            DateTime.now()
//                                .difference(matches[index].matchDate);

                            return Container(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: new BoxDecoration(
                                            color: const Color(0xff7c94b6),
                                            image: new DecorationImage(
                                              image: NetworkImage(
                                                "http://koramania.cloudapp.net/FBMSImages/${matches[index].homeTeamLogo}",
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(50)),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              print(
                                                  '${matches.length} ****  matches.length');
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TeamShowScreen(
                                                            teamID:
                                                                matches[index]
                                                                    .homeTeamId,
                                                            token: widget.token,
                                                            homeController: widget
                                                                .homeController,
                                                            title: matches[
                                                                    index]
                                                                .homeTeamName,
                                                            imageTeam: matches[
                                                                    index]
                                                                .homeTeamLogo,
                                                          )));
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: AutoSizeText(
                                            "${matches[index].homeTeamName}",
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11),
                                            textAlign: TextAlign.center,
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
                                      padding: const EdgeInsets.all(1.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Text(
                                              matches[index]
                                                  .leagueName
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Text(
                                            "${DateFormat.jm('ar_SA').format(matches[index].matchDate)} ",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                          matches[index]
                                                  .matchDate
                                                  .isBefore(DateTime.now())
                                              ? SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  height: 0,
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      "تذكير بالموعد؟",
                                                      style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 14),
                                                    ),
                                                    IconButton(
                                                        icon: Icon(
                                                          Icons.alarm,
                                                          color: matches[index]
                                                                      .userRemind ==
                                                                  1
                                                              ? Colors.red
                                                              : Colors
                                                                  .white, // Colors.white70,
                                                        ),
                                                        onPressed: () async {
                                                          print(
                                                              '********************  ${matches[index].userRemind} **** => matches[index].userRemind');
//                                                    print(
//                                                        '********************  ${widget.homeController.matchesToday[index].userRemind} **** => widget.homeController.matchesToday[index].userRemind');
                                                          print(
                                                              ' ******  before tapped   matches screen ************** ');

                                                          await widget
                                                              .homeController
                                                              .remindShow(
                                                                  matches[index]
                                                                      .matchId,
                                                                  null,
                                                                  matches[index]
                                                                              .userRemind ==
                                                                          1
                                                                      ? true
                                                                      : false,
                                                                  context,
                                                                  matches[index]
                                                                      .matchDate)
                                                              .then((value) {
                                                            if (value == null) {
//                                                        widget
//                                                            .homeController
//                                                            .matchesToday[index]
//                                                            .userRemind = 1;
                                                              matches[index]
                                                                  .userRemind = 0;
                                                              setState(() {});
                                                            } else if (value) {
//                                                        widget
//                                                            .homeController
//                                                            .matchesToday[index]
//                                                            .userRemind = 0;
                                                              matches[index]
                                                                  .userRemind = 1;
                                                              setState(() {});
                                                            }
//                                                  setState(() {});
                                                          });
                                                          print(
                                                              ' ******  after tapped matches screen ************** ');
                                                          print(
                                                              '********************  ${matches[index].userRemind} **** => matches[index].userRemind');
//                                                    print(
//                                                        '********************  ${widget.homeController.matchesToday[index].userRemind} **** => widget.homeController.matchesToday[index].userRemind');
                                                        }),
                                                  ],
                                                ),
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
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: new BoxDecoration(
                                            color: const Color(0xff7c94b6),
                                            image: new DecorationImage(
                                              image: NetworkImage(
                                                "http://koramania.cloudapp.net/FBMSImages/${matches[index].awayTeamLogo}",
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(50)),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TeamShowScreen(
                                                    teamID: matches[index]
                                                        .awayTeamId,
                                                    token: widget.token,
                                                    homeController:
                                                        widget.homeController,
                                                    title: matches[index]
                                                        .awayTeamName,
                                                    imageTeam: matches[index]
                                                        .awayTeamLogo,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: AutoSizeText(
                                            "${matches[index].awayTeamName}",
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11),
                                            textAlign: TextAlign.center,
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
                            );
                          }),
            )
          ],
        ),
      ),
    );
  }

  Future<List<MatchesModel>> getAllMatches(String dateFilter) async {
    setState(() {
      isLoading = true;
    });

    return await http.get(
        "http://api.shashty.tv/api/get-schedule-for-all-teams?dateFilter=$dateFilter",
        headers: {
          "Authorization": widget.token,
        }).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print("matches success " + jsonValue.toString());

        matches = matchesModelFromJson(response.body);
        isLoading = false;

        return matches;
      } else {
        print("error get all home");
        isLoading = false;
        return null;
      }
    });
  }
}
