import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/ShowController.dart';
import 'package:shashty_app/sharedWidget/FavouritePopup.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/sharedWidget/ShowTextFormFieldWidget.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import '../../NoNetworkScreen.dart';
import 'MovieShowScreen.dart';
import 'ProgramAndSeriesShowScreen.dart';

class PersonShowScreen extends StatefulWidget {
  String name;
  int showID;

  PersonShowScreen(this.showID, this.name);
  @protected
  @override
  createState() => PersonShowScreenState();
}

class PersonShowScreenState extends StateMVC<PersonShowScreen> {
  PersonShowScreenState() : super(ShowController()) {
    _showController = ShowController.con;
  }
  bool isLoaded = false;
  Auth auth;
  @override
  void didChangeDependencies() async {
    auth = AppProvider.of(context).auth;
    if (isLoaded == false) {
      await _showController.getPersonShowModel(
          widget.showID, auth.userToken.toString());
      briefController.text =
          _showController.personShowModel.person.brief.trim();

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
                body: _showController.personShowModel == null
                    ? Container()
                    : Container(
                        child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                        Stack(
                          children: <Widget>[
                            FadeInImage(
                              width: screenWidth,
                              fit: BoxFit.cover,
//                          height: 110,
                              image: _showController
                                          .personShowModel.person.image !=
                                      null
                                  ? NetworkImage(ApiRoutes.public +
                                      _showController
                                          .personShowModel.person.image)
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
                                            .personShowModel.person.name,
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
//                        FadeInImage(
//                          width: screenWidth,
//                          fit: BoxFit.cover,
////                          height: 110,
//                          image: _showController.personShowModel.person.image !=
//                                  null
//                              ? NetworkImage(ApiRoutes.public +
//                                  _showController.personShowModel.person.image)
//                              : AssetImage(FixedAssets.noImage),
//                          placeholder: new AssetImage(FixedAssets.noImage),
//                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 20),
                            IconButton(
                                icon: Icon(
                                  _showController.personShowModel.person
                                              .userFavourite ==
                                          1
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _showController.personShowModel.person
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
                                                .personShowModel.person.id,
                                            _showController.personShowModel
                                                        .person.userFavourite ==
                                                    1
                                                ? true
                                                : false,
                                            false,
                                            (value) {
                                              print(value.toString() +
                                                  " valueee");
                                              _showController.personShowModel
                                                      .person.userFavourite =
                                                  value.toInt();
                                              refresh();
                                            },
                                            isPerson: true,
                                          );
                                        });
                                  }
                                  refresh();
                                }),
                            SizedBox(width: 20),
//                            Directionality(
//                              textDirection: TextDirection.rtl,
//                              child: SmoothStarRating(
//                                  allowHalfRating: false,
//                                  onRatingChanged: (v) {},
//                                  starCount: 5,
//                                  rating: _showController
//                                      .personShowModel.person.rating
//                                      .toDouble(),
//                                  size: 20.0,
//                                  color: Colors.yellowAccent,
//                                  borderColor: Colors.yellowAccent,
//                                  spacing: 1.0),
//                            ),
//                            SizedBox(width: 20)
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: ShowTextFormFieldWidget(
                              15.0, 20.0, "معلومات", briefController),
                        ),
                        _showController.personShowModel.shows.length != 0
                            ? Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "بعض الاعمال",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            : Container(child: Center(child: Text("لا يوجد اعمال.")),),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: true,
                            itemCount:
                                _showController.personShowModel.shows.length,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    if (_showController.personShowModel
                                            .shows[index].category[0].name
                                            .toString()
                                            .trim() ==
                                        "افلام") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieShowScreen(
                                                      _showController
                                                          .personShowModel
                                                          .shows[index]
                                                          .id,
                                                      "افلام")));
                                    } else if (_showController.personShowModel
                                            .shows[index].category[0].name
                                            .toString()
                                            .trim() ==
                                        "مسلسلات") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProgramAndSeriesShowScreen(
                                                    _showController
                                                        .personShowModel
                                                        .shows[index]
                                                        .id,
                                                    "مسلسلات",
                                                    false)),
                                      );
                                    } else if (_showController.personShowModel
                                            .shows[index].category[0].name
                                            .toString()
                                            .trim() ==
                                        "برامج") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProgramAndSeriesShowScreen(
                                                    _showController
                                                        .personShowModel
                                                        .shows[index]
                                                        .id,
                                                    "برامج",
                                                    true)),
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: FadeInImage(
                                          height: 110,
                                          width: 100,
                                          fit: BoxFit.fill,
                                          image: _showController.personShowModel
                                                      .shows[index].image ==
                                                  null
                                              ? AssetImage(FixedAssets.noImage)
                                              : NetworkImage(ApiRoutes.public +
                                                  _showController
                                                      .personShowModel
                                                      .shows[index]
                                                      .image),
                                          placeholder: new AssetImage(
                                              FixedAssets.noImage),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        _showController
                                            .personShowModel.shows[index].name,
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
                      ]))));
  }
}
