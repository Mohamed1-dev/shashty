import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/HomeController.dart';
import 'package:shashty_app/screens/Show/ShowDetails/TeamsShowScreen.dart';
import 'package:shashty_app/sharedWidget/Drawer.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import 'HomeScreen.dart';
import 'NoNetworkScreen.dart';
import 'SearchScreen.dart';
import 'Show/FilterCategoryScreen.dart';

class MainScreen extends StatefulWidget {
  @protected
  @override
  createState() => _MainScreen();
}

class _MainScreen extends StateMVC<MainScreen>
    with SingleTickerProviderStateMixin {
//  BottomNavigationItem bottomNavigationItem = BottomNavigationItem();
  _MainScreen() : super(HomeController()) {
    _homeController = HomeController.con;
  }
  Auth auth;
  HomeController _homeController;
  var screenWidth;
  var screenHeight;
//  TabController tabController;
//  List<Tab> listTabs = List<Tab>();
//  List<Widget> listTabsWidgets = List<Widget>();

  bool isLoaded = false;
  @override
  void didChangeDependencies() async {

    auth = AppProvider.of(context).auth;
    auth.getFirebaseUser(callBack);
//    await _homeController.init(context);
//    refresh();
    if (isLoaded == false) {
      await _homeController.init(auth.userToken.toString());
      refresh();
    }
    if (isLoaded == false && _homeController.isLoading == false) {
      _homeController.listTabsWidgets.clear();
      _homeController.listTabs.clear();
      await _homeController.init(auth.userToken.toString());
      refresh();

      _homeController.listTabsWidgets.add(HomeScreen());
      for (int i = 0; i < _homeController.homeModel.categories.length; i++) {
        _homeController.listTabsWidgets.add(FilterCategoryScreen(
            _homeController.homeModel.categories[i].id,
            _homeController.homeModel.categories[i].name,
            i + 1));
      }
      _homeController.listTabsWidgets.add(TeamsShowScreen(auth: auth,homeController: _homeController,));
      _homeController.listTabs.add(Tab(
        text: "الرئيسية",
      ));
      for (int i = 0; i < _homeController.homeModel.categories.length; i++) {
        _homeController.listTabs.add(Tab(
          text: _homeController.homeModel.categories[i].name,
        ));
      }

      _homeController.listTabs.add(Tab(
        text: "الاندية",
      ));


      _homeController.tabController = new TabController(
          vsync: this,
          length: (_homeController.homeModel.categories.length +2));
      _homeController.tabController.notifyListeners();
      isLoaded = true;
    }
    _homeController.tabController.notifyListeners();
    _homeController.tabController.addListener(handleTabs);
    // initState();
    super.didChangeDependencies();
  }

  void handleTabs() {
//    print(_homeController.tabController.index.toString() + " aa");
//    _homeController.selectedView =
//        _homeController.listTabsWidgets[_homeController.tabController.index];
    refresh();
  }

//  @override
//  initState() {
//    if (isLoaded == false && _homeController.isLoading == false) {
//      listTabsWidgets.add(HomeScreen());
//      for (int i = 0; i < _homeController.homeModel.categories.length; i++) {
//        listTabsWidgets.add(FilterCategoryScreen(
//            _homeController.homeModel.categories[i].id,
//            _homeController.homeModel.categories[i].name));
//      }
//      listTabs.add(Tab(
//        text: "الرئيسية",
//      ));
//      for (int i = 0; i < _homeController.homeModel.categories.length; i++) {
//        listTabs.add(Tab(
//          text: _homeController.homeModel.categories[i].name,
//        ));
//      }
//      isLoaded = true;
//
//      tabController = new TabController(
//          vsync: this,
//          length: (_homeController.homeModel.categories.length + 1));
//
//    }
//    super.initState();
//  }

  TabBar tabBar;
  @override
  void dispose() {
    _homeController.tabController.dispose();
    print("dispose main view");
    super.dispose();
  }

  callBack() {
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
//    auth.getFirebaseUser(callBack);
//    auth = AppProvider.of(context).auth;
//    print('*********** ${_homeController.homeModel.categories.length }   ****   _homeController.homeModel.categories.length ');
//for(int i =0 ; i<= _homeController.homeModel.categories.length ; i++){
//  print('************* ${_homeController.homeModel.categories[i].name} ******** _homeController.homeModel.categories[$i].name');
//}


    var isConnected = AppProvider.of(context).isConnected;
    return !isConnected
        ? NoNetworkScreen()
        : _homeController.isLoading
        ? SharedWidgets.loadingWidget(context)
        : DefaultTabController(
        length:_homeController.homeModel.categories == null? 7 :  _homeController.homeModel.categories.length ,
        child: Scaffold(
            drawer: DrawerView(homeController: _homeController,),
            appBar: AppBar(
                centerTitle: true,
                leading: new Builder(builder: (context) {
                  return IconButton(
                      icon: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.dehaze)),
                          Align(
                              alignment: Alignment.topLeft,
                              child: auth.isGuest ||
                                  auth.currentFirebaseUser ==
                                      null ||
                                  auth.currentFirebaseUser
                                      .notification ==
                                      "0"
                                  ? Container()
                                  : CircleAvatar(
                                  radius: 8.0,
                                  backgroundColor: Colors.red,
                                  child: new Text(
                                      auth.currentFirebaseUser
                                          .notification
                                          .toString(),
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0))))
                        ],
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      });
                }),
                title: Image.asset(FixedAssets.logoIcon),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ));
                      }),
                  SizedBox(width: 15)
                ],
                backgroundColor: Colors.black,
                bottom: TabBar(
                  controller: _homeController.tabController,
                  isScrollable: true,
                  tabs: _homeController.listTabs,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.red,
                  labelColor: Colors.white,
                  onTap: (value) async {
                    _homeController.currentTab = value;
//                          print(_homeController
//                                  .homeModel.categories[value - 1].id
//                                  .toString() +
//                              _homeController
//                                  .homeModel.categories[value - 1].name
//                                  .toString() +
//                              "value");
//                            print(value.toString() + " value home");
//                            print(
//                                _homeController.tabController.index.toString() +
//                                    " value home0000");
//                            _homeController.tabController.index = value;
//                            print(_homeController.tabController.toString() +
//                                " xxx");
//                            _homeController.tabController.animateTo(value);
//                            _homeController.tabController.animateTo(value);
//
//                            await _homeController.tabController
//                                .notifyListeners();
//                            _homeController.refresh();

                    refresh();
                  },
                )),
            body:
            //_homeController.selectedView
//                    _homeController
//                        .listTabsWidgets[_homeController.tabController.index]

            TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _homeController.tabController ,
              children: _homeController.listTabsWidgets ,
            )));
  }
}