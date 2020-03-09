import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/HomeController.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import '../NoNetworkScreen.dart';
import 'ShowDetails/ChannelShowScreen.dart';
import 'ShowDetails/MovieShowScreen.dart';
import 'ShowDetails/PersonShowScreen.dart';
import 'ShowDetails/ProgramAndSeriesShowScreen.dart';

class FilterCategoryScreen extends StatefulWidget {
  String name;
  int categoryId;
  int index;
  FilterCategoryScreen(this.categoryId, this.name, this.index);

  @protected
  @override
  createState() => FilterCategoryScreenState();
}

class FilterCategoryScreenState extends StateMVC<FilterCategoryScreen> {
  FilterCategoryScreenState() : super(HomeController()) {
    _homeController = HomeController.con;
  }
//  FilterController _filterController;
  HomeController _homeController;
  bool isLoaded = false;
  Auth auth;
  @override
  Future didChangeDependencies() async {
    //imageCache.clear();

    auth = AppProvider.of(context).auth;
    if (isLoaded == false && widget.index == _homeController.currentTab) {
      _homeController.filterCategoryModel = null;
      await _homeController.initFilter(
          context, widget.categoryId, auth.userToken.toString());
      _homeController.isThereMoreChild = true;
      isLoaded = true;
      refresh();
    }
    refresh();
    super.didChangeDependencies();
  }

//  @override
//  void dispose() {
//    _homeController.filterCategoryModel = null;
////    imageCache.clear();
//    print(" backkk");
//    _homeController.dispose();
//    super.dispose();
//  }

  @override
  void initState() {
//    imageCache.clear();
    _homeController.filterCategoryModel = null;
    refresh();
    super.initState();
  }

  var screenWidth;
  var screenHeight;
  int current = 1;
  @override
  Widget build(BuildContext context) {
    print(widget.name + widget.categoryId.toString() + " wwwwwwwww");
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 3.6;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    var isConnected = AppProvider.of(context).isConnected;
    return !isConnected
        ? NoNetworkScreen()
        : _homeController.isLoadingFilter
            ? SharedWidgets.loadingWidget(context)
            : Scaffold(
//                appBar: SharedWidgets.appBarWithString(context, widget.name),
                backgroundColor: Colors.grey[850],
                body: _homeController.filterCategoryModel == null ||
                        _homeController.filterCategoryModel.data == null ||
                        _homeController.filterCategoryModel.data.length == 0
                    ? Container()
                    : LazyLoadScrollView(
                        isLoading: true,
                        onEndOfPage: () => loadMore(),
                        child: GridView.count(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: true,
                          physics: ScrollPhysics(),
                          crossAxisCount: 3,
                          mainAxisSpacing: 8.0,
                          padding: EdgeInsets.all(10),
                          crossAxisSpacing: 8.0,
                          childAspectRatio: cardWidth / cardHeight,
                          children: List.generate(
                              _homeController.filterCategoryModel.data.length,
                              (index) {
                            return GestureDetector(
                              onTap: () {
                                if (widget.name.trim() == "مسلسلات" ||
                                    widget.name.trim() == "برامج") {
                                  print(_homeController
                                      .filterCategoryModel.data[index].id
                                      .toString());
                                  print(widget.name);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProgramAndSeriesShowScreen(
                                                _homeController
                                                    .filterCategoryModel
                                                    .data[index]
                                                    .id,
                                                widget.name.trim(),
                                                widget.name.trim() == "برامج"
                                                    ? true
                                                    : false)),
                                  );
                                } else if (widget.name.trim() == "افلام") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MovieShowScreen(
                                              _homeController
                                                  .filterCategoryModel
                                                  .data[index]
                                                  .id,
                                              widget.name.trim())));
                                } else if (widget.name.trim() == "مشاهير") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PersonShowScreen(
                                                  _homeController
                                                      .filterCategoryModel
                                                      .data[index]
                                                      .id,
                                                  widget.name.trim())));
                                } else if (widget.name.trim() == "قنوات") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChannelShowScreen(_homeController
                                                  .filterCategoryModel
                                                  .data[index]
                                                  .id,
                                                  _homeController
                                                      .filterCategoryModel
                                                      .data[index]
                                                      .name
                                              )));
                                }
                              },
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: FadeInImage(
                                    height: 250,
                                    width: 150,
                                    fit: BoxFit.fill,
                                    image: NetworkImage(ApiRoutes.public +
                                        _homeController.filterCategoryModel
                                            .data[index].image),
                                    placeholder:
                                        AssetImage(FixedAssets.noImage),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ));
  }

  loadMore() async {
    if (_homeController.isThereMoreChild) {
      current++;
      await _homeController.getAllNextPage(
          widget.categoryId, current, auth.userToken.toString());
    }
    refresh();
  }
}
