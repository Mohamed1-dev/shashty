import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/ShowController.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import '../NoNetworkScreen.dart';
import 'ShowDetails/ChannelShowScreen.dart';
import 'ShowDetails/PersonShowScreen.dart';

class ChannelsOrPersonsScreen extends StatefulWidget {
  bool isChannel;
  String name;

  ChannelsOrPersonsScreen(this.isChannel, this.name);

  @protected
  @override
  createState() => ChannelsOrPersonsScreenState();
}

class ChannelsOrPersonsScreenState extends StateMVC<ChannelsOrPersonsScreen> {
  ChannelsOrPersonsScreenState() : super(ShowController()) {
    _showController = ShowController.con;
  }
  ShowController _showController;
  Auth auth;

  bool isLoaded = false;
  @override
  void didChangeDependencies() async {
    if (isLoaded == false) {
      auth = AppProvider.of(context).auth;
      await _showController.getAllChannelsOrPersons(
          auth.userToken, widget.isChannel);
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
                body: _showController.channelOrPersonModel.data.length == 0
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
//                          crossAxisCount: 4,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: cardWidth / cardHeight,

                            children: List.generate(
                                _showController
                                    .channelOrPersonModel.data.length, (index) {
                              return Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => widget
                                                        .isChannel ==
                                                    false
                                                ? PersonShowScreen(
                                                    _showController
                                                        .channelOrPersonModel
                                                        .data[index]
                                                        .id,
                                                    "مشاهير")
                                                : ChannelShowScreen(
                                                    _showController
                                                        .channelOrPersonModel
                                                        .data[index]
                                                        .id ,

                                                _showController
                                                    .channelOrPersonModel
                                                    .data[index].name)));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: FadeInImage(
                                      height: 250,
                                      width: 150,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(ApiRoutes.public +
                                          _showController.channelOrPersonModel
                                              .data[index].image),
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
