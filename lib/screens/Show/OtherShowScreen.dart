import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/ShowController.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import '../NoNetworkScreen.dart';
import 'ShowDetails/MovieShowScreen.dart';
import 'ShowDetails/ProgramAndSeriesShowScreen.dart';

class OtherShowScreen extends StatefulWidget {
  String name;
  int showValue;
  OtherShowScreen(this.showValue, this.name);

  @protected
  @override
  createState() => OtherShowScreenState();
}

class OtherShowScreenState extends StateMVC<OtherShowScreen> {
  OtherShowScreenState() : super(ShowController()) {
    _showController = ShowController.con;
  }
  ShowController _showController;

  bool isLoaded = false;
  Auth auth;
  @override
  Future didChangeDependencies() async {
    auth = AppProvider.of(context).auth;
    if (isLoaded == false) {
      await _showController.getOtherShow(
          widget.showValue, auth.userToken.toString());
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
                appBar: SharedWidgets.appBarWithString(context, widget.name),
                backgroundColor: Colors.grey[850],
                body: _showController.listOtherShowModel.length == 0
                    ? Container()
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
                                _showController.listOtherShowModel.length,
                                (index) {
                              return Center(
                                child: GestureDetector(
                                  onTap: () {

                                    if (_showController
                                            .listOtherShowModel[index]
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
                                                          .listOtherShowModel[
                                                              index]
                                                          .id,
                                                      "افلام")));
                                    } else if (_showController
                                            .listOtherShowModel[index]
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
                                                        .listOtherShowModel[
                                                            index]
                                                        .id,
                                                    "مسلسلات",
                                                    false)),
                                      );
                                    } else if (_showController
                                            .listOtherShowModel[index]
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
                                                        .listOtherShowModel[
                                                            index]
                                                        .id,
                                                    "برامج",
                                                    true)),
                                      );
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: FadeInImage(
                                      height: 250,
                                      width: 150,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(ApiRoutes.public +
                                          _showController
                                              .listOtherShowModel[index].image),
                                      placeholder:
                                          new AssetImage(FixedAssets.noImage),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ]))));
  }
}
