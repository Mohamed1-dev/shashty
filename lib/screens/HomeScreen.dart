import 'package:auto_size_text/auto_size_text.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/HomeController.dart';
import 'package:shashty_app/data/Models/CategoryModel.dart';
import 'package:shashty_app/data/Models/MactchesModel.dart';
import 'package:shashty_app/data/Models/SingleModel.dart';
import 'package:shashty_app/screens/MatchesScreen.dart';
import 'package:shashty_app/screens/Show/ChannelsOrPersonsScreen.dart';
import 'package:shashty_app/screens/Show/ShowDetails/TeamShowScreen.dart';
import 'package:shashty_app/sharedWidget/FavouritePopup.dart';
import 'package:shashty_app/sharedWidget/HomeSlider.dart';
import 'package:shashty_app/sharedWidget/RatePopup.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import 'package:intl/date_symbol_data_local.dart';
import '../sharedWidget/SharedWidgets.dart';
import 'NoNetworkScreen.dart';
import 'Show/OtherShowScreen.dart';
import 'Show/ShowDetails/ChannelShowScreen.dart';
import 'Show/ShowDetails/MovieShowScreen.dart';
import 'Show/ShowDetails/PersonShowScreen.dart';
import 'Show/ShowDetails/ProgramAndSeriesShowScreen.dart';

class HomeScreen extends StatefulWidget {
  @protected
  @override
  createState() => HomeView();
}

class HomeView extends StateMVC<HomeScreen> {
  HomeView() : super(HomeController()) {
    _homeController = HomeController.con;
  }

  Auth auth;
  HomeController _homeController;

  @override
  void didChangeDependencies() async {
    await initializeDateFormatting("ar_SA", null);
//    await _homeController.init(context);
//    refresh();
    super.didChangeDependencies();
  }

  StrokeCap strokeCap;

  /// the stroke joint style
  StrokeJoin strokeJoin;

  /// the stroke width
  double strokeWidth;

  /// the stroke color
  Color strokeColor;

  /// the `Text` widget to apply stroke on
  Text child;
  bool isShowed1 = false,
      isShowed2 = false,
      isShowed3 = false,
      isShowed4 = false,
      isShowed5 = false,
      isShowed6 = false;

  @override
  Widget build(BuildContext context) {
    auth = AppProvider.of(context).auth;
    var isConnected = AppProvider.of(context).isConnected;
    return !isConnected
        ? NoNetworkScreen()
        : _homeController.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Colors.black,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    _homeController.homeModel.slider.length != 0
                        ? HomeSlider(
                            _homeController.homeModel.slider,
                          )
                        : SizedBox(
                            height: 2,
                          ),
                    _homeController.homeModel.topViews.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: categoryView(
                                _homeController.homeModel.topViews,
                                "اكتر مشاهده",
                                1,
                                isShowed1),
                          )
                        : Container(),
                    _homeController.matchesToday.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: MatchesToday(_homeController.matchesToday))
                        : Container(
                            height: MediaQuery.of(context).size.height / 4,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, top: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "مباريات اليوم",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      InkWell(
                                        child: Icon(
                                          Icons.apps,
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MatchesTodayScreen(
                                                          matches:
                                                              _homeController
                                                                  .matchesToday,
                                                          homeController:
                                                              _homeController,
                                                          token: auth.userToken
                                                              .toString())));
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'لا يوجد مباريات اليوم ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    _homeController.homeModel.persons.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: personsView(
                                _homeController.homeModel.persons, "مشاهير"),
                          )
                        : Container(),
                    _homeController.homeModel.showSoon.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: categoryView(
                                _homeController.homeModel.showSoon,
                                "يعرض قريبا",
                                2,
                                isShowed2,
                                isSoon: true),
                          )
                        : Container(),
                    _homeController.homeModel.showNow.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: categoryView(
                                _homeController.homeModel.showNow,
                                "يعرض االان",
                                6,
                                isShowed6,
                                isSoon: true),
                          )
                        : Container(),
                    _homeController.homeModel.suggested.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: categoryView(
                                _homeController.homeModel.suggested,
                                "مقترح لك",
                                3,
                                isShowed3),
                          )
                        : Container(),
                    _homeController.homeModel.topRated.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: categoryView(
                                _homeController.homeModel.topRated,
                                "الاكثر تقيما",
                                4,
                                isShowed4),
                          )
                        : Container(),
                    _homeController.homeModel.topFavourite.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: categoryView(
                                _homeController.homeModel.topFavourite,
                                "الاكثر تفضيلا",
                                5,
                                isShowed5),
                          )
                        : Container(),
                    _homeController.homeModel.channels.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: channelsView(
                                _homeController.homeModel.channels, "قنوات"),
                          )
                        : Container(),
                  ],
                ),
              );
  }

  Widget MatchesToday(List<MatchesModel> matches) {
    matches.sort((a, b) => a.matchDate.compareTo(b.matchDate));
    return Container(
        //  height: 200,
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "مباريات اليوم",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.apps,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MatchesTodayScreen(
                              matches: matches,
                              homeController: _homeController,
                              token: auth.userToken.toString())));
                    },
                  )
                ],
              ),
            ),
            Flexible(
              child: TransformerPageView(
                  loop: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TeamShowScreen(
                                                    teamID: matches[index]
                                                        .homeTeamId,
                                                    token: auth.userToken
                                                        .toString(),
                                                    homeController:
                                                        _homeController,
                                                    title: matches[index]
                                                        .homeTeamName,
                                                    imageTeam: matches[index]
                                                        .homeTeamLogo,
                                                  )));
                                    },
                                  ),
                                ),
                                AutoSizeText(
                                  "${matches[index].homeTeamName}",
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
//                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Flexible(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  AutoSizeText(
                                    "${matches[index].leagueName.toString()}",
                                    maxLines: 1, overflow: TextOverflow.clip,
//                                    matches[index].leagueName.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11),
                                    textAlign: TextAlign.center,
                                  ),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        "${DateFormat.jm('ar_SA').format(matches[index].matchDate)} ",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
//

                                  matches[index]
                                      .matchDate
                                      .isBefore(DateTime.now()) ?
                                  SizedBox(height: 0,)

                                      :
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        "تذكير بالموعد؟",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10),
                                      ),

                                        IconButton(
                                              icon: Icon(
                                                Icons.alarm,
                                                color: _homeController
                                                            .matchesToday[index]
                                                            .userRemind ==
                                                        1
                                                    ? Colors.red
                                                    : Colors
                                                        .white, // Colors.white70,
                                              ),
                                              onPressed: () async {
                                                print("match id homescreen " +
                                                    matches[index]
                                                        .matchId
                                                        .toString());

                                                print(
                                                    '********************  ${_homeController.matchesToday[index].userRemind} **** =>  widget.homeController.matchesToday[index].userRemind');
                                                await _homeController
                                                    .remindShow(
                                                        matches[index].matchId,
                                                        null,
                                                        _homeController
                                                                    .matchesToday[
                                                                        index]
                                                                    .userRemind ==
                                                                1
                                                            ? true
                                                            : false,
                                                        context,
                                                        matches[index]
                                                            .matchDate)
                                                    .then((value) {
                                                  if (value) {
                                                    _homeController
                                                        .matchesToday[index]
                                                        .userRemind = 1;
                                                    matches[index].userRemind =
                                                        1;
                                                    setState(() {});
                                                  } else {
                                                    _homeController
                                                        .matchesToday[index]
                                                        .userRemind = 0;
                                                    matches[index].userRemind =
                                                        0;
                                                    setState(() {});
                                                  }
                                                  setState(() {});
                                                });
                                                print(
                                                    '********************  ${_homeController.matchesToday[index].userRemind} **** =>  widget.homeController.matchesToday[index].userRemind');
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                                    token: auth.userToken
                                                        .toString(),
                                                    homeController:
                                                        _homeController,
                                                    title: matches[index]
                                                        .awayTeamName,
                                                    imageTeam: matches[index]
                                                        .awayTeamLogo,
                                                  )));
                                    },
                                  ),
                                ),
                                AutoSizeText(
                                  "${matches[index].awayTeamName}",
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                  textAlign: TextAlign.center,
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
                  },
                  itemCount: matches.length),
            ),
          ],
        ));
  }

  Widget categoryView(
      List<CategoryModel> listModel, String name, int showValue, bool isShowed,
      {bool isSoon = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtherShowScreen(showValue, name)),
                  );
                },
                child: Icon(
                  Icons.apps,
                  color: Colors.white,
                ),
              )
            ],
          ),
          categoryViewHorizontal(listModel, isShowed, isSoon: isSoon),
        ],
      ),
    );
  }

  Widget personsView(List<SingleModel> listModel, String name) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChannelsOrPersonsScreen(false, "مشاهير")),
                    );
                  },
                  child: Icon(
                    Icons.apps,
                    color: Colors.white,
                  ))
            ],
          ),
          personsViewHorizontal(listModel)
        ],
      ),
    );
  }

  Widget channelsView(List<SingleModel> listModel, String name) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            GestureDetector(
                onTap: () {
//                  if (auth.isGuest) {
//                    SharedWidgets.mustLogin(context);
//                  } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChannelsOrPersonsScreen(true, "قنوات")),
                  );
//                  }
                },
                child: Icon(
                  Icons.apps,
                  color: Colors.white,
                ))
          ],
        ),
        channelViewHorizontal(listModel),
      ],
    ));
  }

  Widget categoryViewHorizontal(List<CategoryModel> cats, bool isShowed,
      {bool isSoon = false}) {
    Widget item = Container();
    bool isS = false;
    cats.forEach((v) {
      if (v.isShowed) {
        isS = true;
        item = Card(
          color: Colors.black,
          child: GestureDetector(
            onTap: () {
              if (v.category[0].name.toString().trim() == "افلام") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieShowScreen(v.id, "افلام")));
              } else if (v.category[0].name.toString().trim() == "مسلسلات") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProgramAndSeriesShowScreen(v.id, "مسلسلات", false)),
                );
              } else if (v.category[0].name.toString().trim() == "برامج") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProgramAndSeriesShowScreen(v.id, "برامج", true)),
                );
              }
            },
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Text(
                            v.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                          SmoothStarRating(
                              allowHalfRating: false,
                              onRatingChanged: (v) {},
                              starCount: 5,
                              rating: v.rating.toDouble(),
                              size: 15.0,
                              color: Colors.yellowAccent,
                              borderColor: Colors.yellowAccent,
                              spacing: 1.0),
                          Text(
                            v.brief,
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                v.category.length != 0
                                    ? InkWell(
                                        child: Icon(
                                          Icons.favorite,
                                          color: v.userFavourite == 1
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onTap: () {
                                          print(v.userFavourite.toString() +
                                              " fav value");
                                          if (auth.isGuest) {
                                            SharedWidgets.mustLogin(context);
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return FavouritePopup(
                                                      v.id,
                                                      v.userFavourite == 1
                                                          ? true
                                                          : false,
                                                      v.category[0].name
                                                                  .trim() ==
                                                              "افلام"
                                                          ? false
                                                          : true, (value) {
                                                    print(value.toString() +
                                                        " valueee");
                                                    v.userFavourite =
                                                        value.toInt();
                                                    refresh();
                                                  });
                                                });
                                          }
                                          refresh();
                                        },
                                      )
                                    : Container(),
                                (v.category.length == 0 ||
                                            (v.category[0].name.trim() ==
                                                "افلام")) &&
                                        isSoon
                                    ? InkWell(
                                        child: Icon(
                                          Icons.access_alarm,
                                          color: v.userRemind == 1
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onTap: () {
                                          if (auth.isGuest) {
                                            SharedWidgets.mustLogin(context);
                                          } else {
                                            showModalBottomSheet<void>(
                                                context: context,
                                                backgroundColor:
                                                    Colors.grey[850],
                                                builder:
                                                    (BuildContext context) {
                                                  return FutureBuilder(
                                                    future: _homeController
                                                        .getShowTime(
                                                      v.id,
                                                      true,
                                                      context,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasError)
                                                        return Center(
                                                            child: Text(
                                                                "Network Error"));
                                                      return snapshot.hasData
                                                          ? Container(
                                                              height: 250,
                                                              child: _homeController
                                                                          .listShowTime
                                                                          .length ==
                                                                      0
                                                                  ? Center(
                                                                      child:
                                                                          Text(
                                                                      "لا توجد مواعيد عرض حاليا",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              25),
                                                                    ))
                                                                  : ListView
                                                                      .separated(
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      shrinkWrap:
                                                                          true,
                                                                      primary:
                                                                          true,
                                                                      itemCount: _homeController
                                                                          .listShowTime
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int i) {
                                                                        return Padding(
                                                                          padding:
                                                                              EdgeInsets.all(5),
                                                                          child:
                                                                              Column(
                                                                            children: <Widget>[
                                                                              Image.network(ApiRoutes.public + _homeController.listShowTime[i].image, width: 50, height: 50),
                                                                              Text(
                                                                                "قائمة المواعيد",
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(30.0),
                                                                                child: ConstrainedBox(
                                                                                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .2, minHeight: MediaQuery.of(context).size.height * .1),
                                                                                    child: ListView.separated(
                                                                                      itemCount: _homeController.listShowTime[i].showTime.length,
                                                                                      separatorBuilder: (BuildContext context, int index) {
                                                                                        return Divider(
                                                                                          color: Colors.transparent,
                                                                                        );
                                                                                      },
                                                                                      itemBuilder: (BuildContext context, int index) {
                                                                                        return Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: <Widget>[
                                                                                            Icon(
                                                                                              Icons.calendar_today,
                                                                                              color: Colors.red,
                                                                                            ),
                                                                                            Text(
                                                                                              " يوم " + DateFormat('yyyy-MM-dd').format(_homeController.listShowTime[i].showTime[index].startDate).toString() + " الساعة " + DateFormat('kk:mm').format(_homeController.listShowTime[i].showTime[index].startDate).toString(),
                                                                                              style: TextStyle(color: Colors.redAccent),
                                                                                            ),
                                                                                            _homeController.listShowTime[i].showTime[index].startDate.isBefore(DateTime.now())
                                                                                                ? IconButton(
                                                                                                    icon: Icon(
                                                                                                      Icons.access_alarm,
                                                                                                      color: _homeController.listShowTime[i].showTime[index].userRemind == 1 ? Colors.red : Colors.grey,
                                                                                                    ),
                                                                                              onPressed: () {
                                                                                                SharedWidgets.showToastMsg("لا يمكن اضافة تذكير لمعاد فائت", true);
                                                                                              },
                                                                                                  )
//

                                                                                                : IconButton(
                                                                                                    icon: Icon(
                                                                                                      Icons.access_alarm,
                                                                                                      color: _homeController.listShowTime[i].showTime[index].userRemind == 1 ? Colors.red : Colors.white,
                                                                                                    ),
                                                                                                    onPressed: () async {
                                                                                                      if (auth.isGuest) {
                                                                                                        SharedWidgets.mustLogin(context);
                                                                                                      } else {
                                                                                                        print(_homeController.listShowTime[i].id.toString() + " awfrg");
                                                                                                        print(v.id.toString() + " awfrg");
                                                                                                        await _homeController.remindShow(v.id, false, _homeController.listShowTime[i].showTime[index].userRemind == 1 ? true : false, context, _homeController.listShowTime[i].showTime[index].startDate).then((value) {
                                                                                                          if (value == null) {
                                                                                                            _homeController.listShowTime[i].showTime[index].userRemind = 0;
                                                                                                            v.userRemind = 0;
                                                                                                          } else if (value) {
                                                                                                            _homeController.listShowTime[i].showTime[index].userRemind = 1;
                                                                                                            v.userRemind = 1;
                                                                                                          }
                                                                                                          refresh();
                                                                                                          Navigator.pop(context);
                                                                                                        });
                                                                                                      }
                                                                                                    })
                                                                                          ],
                                                                                        );
                                                                                      },
                                                                                    )),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                      separatorBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Divider(
                                                                          color:
                                                                              Colors.grey,
                                                                        );
                                                                      },
                                                                    ),
                                                            )
                                                          : Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                    },
                                                  );
                                                });
                                          }
                                          refresh();
                                        },
                                      )
                                    : Container(),
                                InkWell(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  ),
                                  onTap: () {
                                    if (auth.isGuest) {
                                      SharedWidgets.mustLogin(context);
                                    } else {
                                      print(v.userRate.toString() + " rate");
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return RatePopup(
                                                v.id,
                                                v.userRate.toDouble(),
                                                v.category.length == 0 ||
                                                        v.category[0].name
                                                                .trim() ==
                                                            "افلام"
                                                    ? false
                                                    : true,
                                                (value, int rateValue) {
                                              v.userRate = value.toInt();
                                              v.rating = rateValue;
                                              refresh();
                                            });
                                          });
                                    }
                                    refresh();
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 5,
                    child: Image.network(
                      v.media.isNotEmpty
                          ? ApiRoutes.public + v.media[0].image
                          : ApiRoutes.public + v.image,
//                    width: 10,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
        );
      }
      refresh();
    });

//    changeShowed();
    return Column(
      children: <Widget>[
        Container(
          height: 190, // MediaQuery.of(context).size.height / 2.8, //* 0.15,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cats.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, i) {
              return Stack(
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: FadeInImage(
                              width: 120,
                              height: 175,
                              fit: BoxFit.fill,
                              image: cats[i].image != null
                                  ? NetworkImage(
                                      ApiRoutes.public + cats[i].image)
                                  : AssetImage(FixedAssets.noImage),
                              placeholder: new AssetImage(FixedAssets.noImage),
                            ))),
                    onPressed: () {
                      print(cats[i].isShowed.toString() + " bb");
                      if (cats[i].isShowed == false) {
                        cats.forEach((v) {
                          v.isShowed = false;
                        });
                        cats[i].isShowed = !cats[i].isShowed;
                      } else {
                        cats[i].isShowed = false;
                      }
                      print(cats[i].isShowed.toString() + " aa");
                      refresh();
//                      changeShowed();
                    },
                  ),
                  Positioned(
                    top: cats[i].isShowed ? 160 : 150,
                    right: 50,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: cats[i].isShowed ? Colors.red : Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        isS ? item : Container()
      ],
    );
  }

  Widget personsViewHorizontal(List<SingleModel> cats) {
    return Container(
        height: 145, // MediaQuery.of(context).size.height / 2.8, //* 0.15,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cats.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, i) {
              return Column(children: <Widget>[
                FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Stack(
                      children: <Widget>[
                        Card(
                            color: Colors.transparent,
                            child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(350),
                                    child: FadeInImage(
                                      width: 110,
                                      fit: BoxFit.cover,
                                      height: 110,
                                      image: cats[i].image != null
                                          ? NetworkImage(
                                              ApiRoutes.public + cats[i].image)
                                          : AssetImage(FixedAssets.noImage),
                                      placeholder:
                                          new AssetImage(FixedAssets.noImage),
                                    )))),
                        Positioned(
                            width: 150,
                            height: 250,
                            child: Container(
                                child: Center(
                                    child: BorderedText(
                                        strokeWidth: 10.0,
                                        strokeColor: Colors.black,
                                        child: Text(
                                            cats[i] != null ? cats[i].name : "",
                                            style: TextStyle(
                                                fontFamily:
                                                    FixedAssets.ruqaFont,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis)))))
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonShowScreen(
                                  cats[i].id, cats[i].name.trim())));
//                  if (auth.isGuest) {
//                    SharedWidgets.mustLogin(context);
//                  } else {}
                    })
              ]);
            }));
  }

  Widget channelViewHorizontal(List<SingleModel> cats) {
    return Container(
        height: 145, // MediaQuery.of(context).size.height / 2.8, //* 0.15,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cats.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, i) {
              return Column(children: <Widget>[
                FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Stack(children: <Widget>[
                      Card(
                          color: Colors.transparent,
                          child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(350),
                                  child: FadeInImage(
                                    width: 110,
                                    fit: BoxFit.cover,
                                    height: 110,
                                    image: cats[i].image != null
                                        ? NetworkImage(
                                            ApiRoutes.public + cats[i].image)
                                        : AssetImage(FixedAssets.noImage),
                                    placeholder:
                                        new AssetImage(FixedAssets.noImage),
                                  )))),
                      Positioned(
                          width: 150,
                          height: 250,
                          child: Container(
                              child: Center(
                                  child: BorderedText(
                                      strokeColor: Colors.black,
                                      strokeWidth: 10,
                                      child: Text(
                                        cats[i] != null ? cats[i].name : "",
                                        style: TextStyle(
                                            fontFamily: FixedAssets.ruqaFont,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )))))
                    ]),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChannelShowScreen(cats[i].id, cats[i].name)));
//                  if (auth.isGuest) {
//                    SharedWidgets.mustLogin(context);
//                  } else {}
                    })
              ]);
            }));
  }
}
