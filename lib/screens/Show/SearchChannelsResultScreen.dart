import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/SearchController.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import '../NoNetworkScreen.dart';
import 'ShowDetails/ChannelShowScreen.dart';

class SearchChannelsResultScreen extends StatefulWidget {
  var dateTime;
  var subCatId;
  var searchWord;
  SearchChannelsResultScreen(this.dateTime, this.searchWord,
      {this.subCatId = 0});

  @protected
  @override
  createState() => SearchChannelsResultScreenState();
}

class SearchChannelsResultScreenState
    extends StateMVC<SearchChannelsResultScreen> {
  SearchChannelsResultScreenState() : super(SearchController()) {
    _searchController = SearchController.con;
  }
  bool isLoaded = false;
  Auth auth;
  @override
  Future didChangeDependencies() async {
    auth = AppProvider.of(context).auth;
    if (isLoaded == false) {
      await _searchController.getAllChannelsResult(
          widget.searchWord, widget.subCatId, auth.userToken.toString());
      isLoaded = true;
    }
    super.didChangeDependencies();
  }

  SearchController _searchController;
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
        : _searchController.isLoading
            ? SharedWidgets.loadingWidget(context)
            : Scaffold(
                appBar: SharedWidgets.appBarWithString(context, ""),
                backgroundColor: Colors.grey[850],
                body: _searchController.listOtherShowModel.length == 0
                    ? Center(
                        child: Text(
                        "لا يوجد نتائج",
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
                                _searchController.listOtherShowModel.length,
                                (index) {
                              return Center(
                                child: GestureDetector(
                                  onTap: () {
                                    print(_searchController
                                            .listOtherShowModel.length
                                            .toString() +
                                        " awawa/");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChannelShowScreen(
                                                    _searchController
                                                        .listOtherShowModel[
                                                            index]
                                                        .id ,
                                                  _searchController
                                                      .listOtherShowModel[
                                                  index]
                                                      .name , )));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: FadeInImage(
                                      height: 250,
                                      width: 150,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(ApiRoutes.public +
                                          _searchController
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
