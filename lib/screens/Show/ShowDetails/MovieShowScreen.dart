import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/ShowController.dart';
import 'package:shashty_app/sharedWidget/FavouritePopup.dart';
import 'package:shashty_app/sharedWidget/RatePopup.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/sharedWidget/ShowTextFormFieldWidget.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../NoNetworkScreen.dart';
import 'PersonShowScreen.dart';

class MovieShowScreen extends StatefulWidget {
  String name;
  int showID;

  MovieShowScreen(this.showID, this.name);
  @protected
  @override
  createState() => MovieShowScreenState();
}

class MovieShowScreenState extends StateMVC<MovieShowScreen> {
  MovieShowScreenState() : super(ShowController()) {
    _showController = ShowController.con;
  }
  bool isLoaded = false;
  Auth auth;
  @override
  void didChangeDependencies() async {
    auth = AppProvider.of(context).auth;
    if (isLoaded == false) {
      await _showController.getMovieShowModel(
          widget.showID, auth.userToken.toString());
      briefController.text = _showController.movieShowModel.brief.trim();

      refresh();

      isLoaded = true;
      refresh();
    }
    super.didChangeDependencies();
  }

  TextEditingController briefController = TextEditingController();

  var screenWidth;
  var screenHeight;
  ShowController _showController;
  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 3.6;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    var isConnected = AppProvider.of(context).isConnected;
    return !isConnected
        ? NoNetworkScreen()
        : _showController.isLoading
            ? SharedWidgets.loadingWidget(context)
            : Scaffold(
                appBar: SharedWidgets.appBarWithString(context, widget.name),
                backgroundColor: Colors.grey[850],
                body: _showController.movieShowModel == null
                    ? Container()
                    : Container(
                        child: SingleChildScrollView(
                            child: Column(children: <Widget>[

                        Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          child: Stack(
                            children: <Widget>[
//                              SizedBox(height: 20.0,),
                              FadeInImage(
                                width: screenWidth,
                                 fit: BoxFit.cover,
//                          height: screenHeight * 0.70,
                                image:
                                    _showController.movieShowModel.image != null
                                        ? NetworkImage(ApiRoutes.public +
                                            _showController.movieShowModel.image)
                                        : AssetImage(FixedAssets.noImage),
                                placeholder: new AssetImage(FixedAssets.noImage),
                              ),
                              Positioned.fill(
                                child: Align(
//                                rect: Rect.fromCenter(),

                                    alignment: Alignment.bottomCenter,
//                                          top: 140,
//                                          right: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: BorderedText(
                                        strokeWidth: 10.0,
                                        strokeColor: Colors.black,
                                        child: Text(
                                          _showController.movieShowModel.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: FixedAssets.ruqaFont,
                                              fontSize: 30,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (auth.isGuest) {
                                  SharedWidgets.mustLogin(context);
                                } else {
                                  print(_showController.movieShowModel.userRate
                                          .toString() +
                                      " rate");
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return RatePopup(
                                            _showController.movieShowModel.id,
                                            _showController
                                                .movieShowModel.userRate
                                                .toDouble(),
                                            false, (value, int rateValue) {
                                          _showController.movieShowModel
                                              .userRate = value.toInt();
                                          _showController.movieShowModel
                                              .rating = rateValue;
                                          refresh();
                                        });
                                      });
                                }
                                refresh();
                              },
                            ),
                            SizedBox(width: 20),
                            IconButton(
                                icon: Icon(
                                  _showController
                                              .movieShowModel.userFavourite ==
                                          1
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _showController
                                              .movieShowModel.userFavourite ==
                                          1
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 20,
                                ),
                                onPressed: () {
                                  if (auth.isGuest) {
                                    SharedWidgets.mustLogin(context);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return FavouritePopup(
                                              _showController.movieShowModel.id,
                                              _showController.movieShowModel
                                                          .userFavourite ==
                                                      1
                                                  ? true
                                                  : false,
                                              _showController.movieShowModel
                                                          .category[0].name
                                                          .trim() ==
                                                      "افلام"
                                                  ? false
                                                  : true, (value) {
                                            print(
                                                value.toString() + " valueee");
                                            _showController.movieShowModel
                                                .userFavourite = value.toInt();
                                            refresh();
                                          });
                                        });
                                  }
                                  refresh();
                                }),
                            SizedBox(width: 20),
                            SmoothStarRating(
                                allowHalfRating: false,
                                onRatingChanged: (v) {},
                                starCount: 5,
                                rating: _showController.movieShowModel.rating
                                    .toDouble(),
                                size: 20.0,
                                color: Colors.yellowAccent,
                                borderColor: Colors.yellowAccent,
                                spacing: 1.0),
                            SizedBox(width: 20)
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: ShowTextFormFieldWidget(
                              15.0, 20.0, "قصة الفيلم", briefController),
                        ),
                        _showController.movieShowModel.persons.length != 0
                            ? Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "افراد العمل",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(child: Text("لا يوجد افراد عمل.", style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),)),),
                        _showController.movieShowModel.persons.length != 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        primary: true,
                                        itemCount: _showController
                                            .movieShowModel.persons.length,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10,
                                                left: 10,
                                                right: 10),
                                            child: Column(
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PersonShowScreen(
                                                                    _showController
                                                                        .movieShowModel
                                                                        .persons[
                                                                            index]
                                                                        .id,
                                                                    "مشاهير")));
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: FadeInImage(
                                                      height: 110,
                                                      width: 100,
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          ApiRoutes.public +
                                                              _showController
                                                                  .movieShowModel
                                                                  .persons[
                                                                      index]
                                                                  .image),
                                                      placeholder:
                                                          new AssetImage(
                                                              FixedAssets
                                                                  .noImage),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  _showController.movieShowModel
                                                      .persons[index].name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        _showController.movieShowModel.channels.length != 0
                            ? Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "وقت العرض",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Center(child: Text("لا يوجد اوقات عروض.", style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),)),),
                        _showController.movieShowModel.channels.length != 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 180,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        primary: true,
                                        itemCount: _showController
                                            .movieShowModel.channels.length,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return FlatButton(
//                                              padding: EdgeInsets.all(0),
                                              child: Stack(children: <Widget>[
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            13.0),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(350),
                                                        child: FadeInImage(
                                                          width: 110,
                                                          fit: BoxFit.cover,
                                                          height: 110,
                                                          image: _showController
                                                                      .movieShowModel
                                                                      .channels[
                                                                          index]
                                                                      .image !=
                                                                  null
                                                              ? NetworkImage(ApiRoutes
                                                                      .public +
                                                                  _showController
                                                                      .movieShowModel
                                                                      .channels[
                                                                          index]
                                                                      .image)
                                                              : AssetImage(
                                                                  FixedAssets
                                                                      .noImage),
                                                          placeholder:
                                                              new AssetImage(
                                                                  FixedAssets
                                                                      .noImage),
                                                        ))),
                                                Positioned(
                                                    width: 140,
                                                    height: 250,
                                                    child: Container(
                                                        child: Center(
                                                            child: BorderedText(
                                                                strokeColor:
                                                                    Colors
                                                                        .black,
                                                                strokeWidth: 10,
                                                                child: Text(
                                                                  _showController
                                                                              .movieShowModel
                                                                              .channels[
                                                                                  index]
                                                                              .name !=
                                                                          null
                                                                      ? _showController
                                                                          .movieShowModel
                                                                          .channels[
                                                                              index]
                                                                          .name
                                                                      : "",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                )))))
                                              ]),
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                    context: context,
                                                    backgroundColor:
                                                        Colors.grey[850],
                                                    isScrollControlled: false,
                                                    builder: (BuildContext bc) {
                                                      return Container(
                                                        height: 250,
                                                        child: _showController
                                                                    .movieShowModel
                                                                    .channels[
                                                                        index]
                                                                    .showTime
                                                                    .length ==
                                                                0
                                                            ? Center(
                                                                child: Text(
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
//                                                          shrinkWrap: true,
//                                                          primary: true,
                                                                itemCount: _showController
                                                                    .movieShowModel
                                                                    .channels[
                                                                        index]
                                                                    .showTime
                                                                    .length,
//                                                          physics:
//                                                              ClampingScrollPhysics(),
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int i) {
                                                                  return Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(
                                                                          Icons
                                                                              .calendar_today,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                        Text(
                                                                          " يوم " +
                                                                              DateFormat('yyyy-MM-dd').format(_showController.movieShowModel.channels[index].showTime[i].startDate).toString() +
                                                                              " الساعة " +
                                                                              DateFormat('kk:mm').format(_showController.movieShowModel.channels[index].showTime[i].startDate).toString(),
                                                                          style:
                                                                              TextStyle(color: Colors.redAccent),
                                                                        ),
                                                                        IconButton(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.access_alarm,
                                                                              color: _showController.movieShowModel.channels[index].showTime[i].userRemind == 1 ? Colors.red : Colors.grey,
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              if (auth.isGuest) {
                                                                                SharedWidgets.mustLogin(context);
                                                                              } else {
                                                                                await _showController.remindShow(_showController.movieShowModel.channels[index].id, false, _showController.movieShowModel.channels[index].showTime[i].userRemind == 1 ? true : false, context, _showController.movieShowModel.channels[index].showTime[i].startDate).then((value) {
                                                                                  if (value != null) {
                                                                                    _showController.movieShowModel.channels[index].showTime[i].userRemind = 1;
                                                                                    refresh();
                                                                                  } else {
                                                                                    _showController.movieShowModel.channels[index].showTime[i].userRemind = 0;
                                                                                    refresh();
                                                                                  }
                                                                                  refresh();
                                                                                  Navigator.pop(context);
                                                                                });
                                                                              }
                                                                            })
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                separatorBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                  );
                                                                },
                                                              ),
                                                      );
                                                    });
//                  if (auth.isGuest) {
//                    SharedWidgets.mustLogin(context);
//                  } else {}
                                              });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                      ]))));
  }
}
