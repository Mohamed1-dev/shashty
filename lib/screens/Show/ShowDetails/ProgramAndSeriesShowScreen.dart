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

class ProgramAndSeriesShowScreen extends StatefulWidget {
  String name;
  int programShowModelId;
  bool isProgram;

  ProgramAndSeriesShowScreen(
      this.programShowModelId, this.name, this.isProgram);
  @protected
  @override
  createState() => ProgramAndSeriesShowScreenState();
}

class ProgramAndSeriesShowScreenState
    extends StateMVC<ProgramAndSeriesShowScreen> {
  ProgramAndSeriesShowScreenState() : super(ShowController()) {
    _showController = ShowController.con;
  }
  bool isLoaded = false;
  Auth auth;
  @override
  void didChangeDependencies() async {
    auth = AppProvider.of(context).auth;
    if (isLoaded == false) {
      await _showController.getProgramAndSeriesShow(widget.programShowModelId,
          widget.isProgram, auth.userToken.toString());
      briefController.text =
          _showController.programOrSeriesShowModel.brief.trim();

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
                body: _showController.programOrSeriesShowModel == null
                    ? Container()
                    : Container(
                        child: SingleChildScrollView(
                            child: Column(children: <Widget>[

                              Container(
                                height: MediaQuery.of(context).size.height * 0.40,
                                child: Stack(
                                  children: <Widget>[
                                    FadeInImage(
                                      width: screenWidth,
                                      fit: BoxFit.cover,
//                                      height: screenHeight * 0.85,
                                image: _showController
                                            .programOrSeriesShowModel.image !=
                                        null
                                    ? NetworkImage(ApiRoutes.public +
                                        _showController
                                            .programOrSeriesShowModel.image)
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
                                          _showController
                                              .programOrSeriesShowModel.name,
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
//                        FadeInImage(
//                          width: screenWidth,
//                          fit: BoxFit.cover,
////                          height: 110,
//                          image:
//                              _showController.programOrSeriesShowModel.image !=
//                                      null
//                                  ? NetworkImage(ApiRoutes.public +
//                                      _showController
//                                          .programOrSeriesShowModel.image)
//                                  : AssetImage(FixedAssets.noImage),
//                          placeholder: new AssetImage(FixedAssets.noImage),
//                        ),
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
                                  print(_showController
                                          .programOrSeriesShowModel.userRate
                                          .toString() +
                                      " rate");
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return RatePopup(
                                            _showController
                                                .programOrSeriesShowModel.id,
                                            _showController
                                                .programOrSeriesShowModel
                                                .userRate
                                                .toDouble(),
                                            true, (value, int rateValue) {
                                          _showController
                                              .programOrSeriesShowModel
                                              .userRate = value.toInt();
                                          _showController
                                              .programOrSeriesShowModel
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
                                  _showController.programOrSeriesShowModel
                                              .userFavourite ==
                                          1
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _showController
                                              .programOrSeriesShowModel
                                              .userFavourite ==
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
                                              _showController
                                                  .programOrSeriesShowModel.id,
                                              _showController
                                                          .programOrSeriesShowModel
                                                          .userFavourite ==
                                                      1
                                                  ? true
                                                  : false,
                                              _showController
                                                          .programOrSeriesShowModel
                                                          .category[0]
                                                          .name
                                                          .trim() ==
                                                      "افلام"
                                                  ? false
                                                  : true, (value) {
                                            print(
                                                value.toString() + " valueee");
                                            _showController
                                                .programOrSeriesShowModel
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
                                rating: _showController
                                    .programOrSeriesShowModel.rating
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
                              15.0,
                              20.0,
                              widget.isProgram ? "عن البرنامح" : "قصة المسلسل",
                              briefController),
                        ),
                        _showController.programOrSeriesShowModel.shows.length !=
                                0
                            ? Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "الحلقات",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(child: Text("لا توجد حلقات.", style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),)),),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: true,
                            itemCount: _showController
                                .programOrSeriesShowModel.shows.length,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                        context: context,
                                        backgroundColor: Colors.grey[850],
                                        builder: (BuildContext context) {
                                          return FutureBuilder(
                                            future: _showController.getShowTime(
                                                _showController
                                                    .programOrSeriesShowModel
                                                    .shows[index]
                                                    .id,
                                                false,context),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError)
                                                return Center(
                                                    child:
                                                        Text("Network Error"));
                                              return snapshot.hasData
                                                  ? Container(
                                                      height: 250,
                                                      child: _showController
                                                                  .listShowTime
                                                                  .length ==
                                                              0
                                                          ? Center(
                                                              child: Text(
                                                              "لا توجد مواعيد عرض حاليا",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 25),
                                                            ))
                                                          : ListView.separated(
                                                              scrollDirection:
                                                                  Axis.vertical,
//                                                          shrinkWrap: true,
//                                                          primary: true,
                                                              itemCount:
                                                                  _showController
                                                                      .listShowTime
                                                                      .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int i) {
                                                                return Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child: Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Image.network(
                                                                          ApiRoutes.public +
                                                                              _showController.listShowTime[i].image,
                                                                          width: 50,
                                                                          height: 50),
                                                                      ConstrainedBox(
                                                                          constraints: BoxConstraints(
                                                                              maxHeight: MediaQuery.of(context).size.height /
                                                                                  10),
                                                                          child:
                                                                              ListView.separated(
                                                                            itemCount:
                                                                                _showController.listShowTime[i].showTime.length,
                                                                            separatorBuilder:
                                                                                (BuildContext context, int index) {
                                                                              return Divider(
                                                                                color: Colors.grey,
                                                                              );
                                                                            },
                                                                            itemBuilder:
                                                                                (BuildContext context, int index) {
                                                                              return Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: <Widget>[
                                                                                  Icon(
                                                                                    Icons.calendar_today,
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                  Text(
                                                                                    " يوم " + DateFormat('yyyy-MM-dd').format(_showController.listShowTime[i].showTime[index].startDate).toString() + " الساعة " + DateFormat('kk:mm').format(_showController.listShowTime[i].showTime[index].startDate).toString(),
                                                                                    style: TextStyle(color: Colors.redAccent),
                                                                                  ),
                                                                                  IconButton(
                                                                                      icon: Icon(
                                                                                        Icons.access_alarm,
                                                                                        color: _showController.listShowTime[i].showTime[index].userRemind == 1 ? Colors.red : Colors.grey,
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        if (auth.isGuest) {
                                                                                          SharedWidgets.mustLogin(context);
                                                                                        } else {
                                                                                          await _showController.remindShow(_showController.listShowTime[i].id, false, _showController.listShowTime[i].showTime[index].userRemind == 1 ? true : false, context, _showController.listShowTime[i].showTime[index].startDate).then((value) {
                                                                                            if (value != null) {
                                                                                              _showController.listShowTime[i].showTime[index].userRemind = 1;
                                                                                              refresh();
                                                                                            } else {
                                                                                              _showController.listShowTime[i].showTime[index].userRemind = 0;
                                                                                              refresh();
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
                                                    )
                                                  : Center(
                                                      child:
                                                          CircularProgressIndicator());
                                            },
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: FadeInImage(
                                          height: 110,
                                          width: 100,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(ApiRoutes.public +
                                              _showController
                                                  .programOrSeriesShowModel
                                                  .shows[index]
                                                  .image),
                                          placeholder: new AssetImage(
                                              FixedAssets.noImage),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        _showController.programOrSeriesShowModel
                                            .shows[index].name,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        _showController
                                    .programOrSeriesShowModel.persons.length !=
                                0
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
                        _showController
                                    .programOrSeriesShowModel.persons.length !=
                                0
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
                                            .programOrSeriesShowModel
                                            .persons
                                            .length,
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
                                                                        .programOrSeriesShowModel
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
                                                      image: NetworkImage(ApiRoutes
                                                              .public +
                                                          _showController
                                                              .programOrSeriesShowModel
                                                              .persons[index]
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
                                                  _showController
                                                      .programOrSeriesShowModel
                                                      .persons[index]
                                                      .name,
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
                            : Container()
                      ]))));
  }
}
