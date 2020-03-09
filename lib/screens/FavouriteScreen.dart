import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/HomeController.dart';
import 'package:shashty_app/controllers/ShowController.dart';
import 'package:shashty_app/screens/NoNetworkScreen.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import 'Show/ShowDetails/MovieShowScreen.dart';
import 'Show/ShowDetails/PersonShowScreen.dart';
import 'Show/ShowDetails/ProgramAndSeriesShowScreen.dart';
import 'Show/ShowDetails/TeamShowScreen.dart';

class FavouriteScreen extends StatefulWidget {
  HomeController homeController;

  FavouriteScreen({this.homeController});

  @protected
  @override
  createState() => FavouriteScreenState();
}

class FavouriteScreenState extends StateMVC<FavouriteScreen> {
  FavouriteScreenState() : super(ShowController()) {
    _showController = ShowController.con;
  }

  ShowController _showController;

  bool isLoaded = false;
  Auth auth;

  @override
  Future didChangeDependencies() async {
    auth = AppProvider.of(context).auth;
    if (isLoaded == false) {
      await _showController.getFav(auth.userToken.toString()).then((value) {});
      isLoaded = true;
      refresh();
    }
    super.didChangeDependencies();
  }

  var screenWidth;
  var screenHeight;

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
      appBar: SharedWidgets.appBarWithString(context, "المفضلة"),
      backgroundColor: Colors.grey[850],
      body: _showController.listFavourite.length == 0
          ? Center(
          child: Text(
            "لا توجد مفضلات",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ))
          : Container(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.count(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: true,
                physics: ScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: cardWidth / cardHeight,
                children: List.generate(
                    _showController.listFavourite.length,
                        (index) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            if (_showController
                                .listFavourite[index].kind
                                ==
                                "team") {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TeamShowScreen(
                                          teamID: _showController
                                              .listFavourite[index].id,
                                          token: auth.userToken.toString(),
                                          homeController:
                                          widget.homeController,
                                          title: _showController
                                              .listFavourite[index].name,
                                          imageTeam: _showController
                                              .listFavourite[index].image,
                                        ),
                                  ));
                            } else if (_showController
                                .listFavourite[index]
                                .category[0]
                                .name
                                .toString()
                                .trim() ==
                                "افلام") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MovieShowScreen(
                                              _showController
                                                  .listFavourite[
                                              index]
                                                  .id,
                                              "افلام")));
                            } else if (_showController
                                .listFavourite[index]
                                .category[0]
                                .name
                                .toString()
                                .trim() ==
                                "مسلسلات") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProgramAndSeriesShowScreen(
                                            _showController
                                                .listFavourite[
                                            index]
                                                .id,
                                            "مسلسلات",
                                            false)),
                              );
                            } else if (_showController
                                .listFavourite[index]
                                .category[0]
                                .name
                                .toString()
                                .trim() ==
                                "برامج") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProgramAndSeriesShowScreen(
                                            _showController
                                                .listFavourite[
                                            index]
                                                .id,
                                            "برامج",
                                            true)),
                              );
                            } else if (_showController
                                .listFavourite[index]
                                .category[0]
                                .name
                                .toString()
                                .trim() ==
                                "مشاهير") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PersonShowScreen(
                                            _showController
                                                .listFavourite[
                                            index]
                                                .id,
                                            _showController
                                                .listFavourite[
                                            index]
                                                .name)),
                              );
                            }
                          },
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(5),
                                child: FadeInImage(
                                  height: 200,
                                  width: 150,
                                  fit: BoxFit.fill,
                                  image: _showController
                                      .listFavourite[index]
                                      .kind ==
                                      "team"
                                      ? NetworkImage(
                                      "http://koramania.cloudapp.net/FBMSImages/" +
                                          _showController
                                              .listFavourite[
                                          index]
                                              .image)
                                      : NetworkImage(ApiRoutes
                                      .public +
                                      _showController
                                          .listFavourite[index]
                                          .image),
                                  placeholder: new AssetImage(
                                      FixedAssets.noImage),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomCenter,
//                                          top: 140,
//                                          right: 50,
                                  child: Container(
                                    color:
                                    Colors.red.withOpacity(.5),
                                    child: Row(
                                      mainAxisSize:
                                      MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(3),
                                            child: AutoSizeText(
                                              _showController
                                                  .listFavourite[
                                              index]
                                                  .name,
                                              maxLines: 2,
                                              textAlign:
                                              TextAlign.center,
                                              style: TextStyle(
//                                                        fontSize: 15,
                                                  color:
                                                  Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
          ]),
        ),
      ),
    );
  }
}