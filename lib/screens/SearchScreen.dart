import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/SearchController.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';

import 'NoNetworkScreen.dart';
import 'Show/SearchChannelsResultScreen.dart';
import 'Show/SearchMovieResultScreen.dart';
import 'Show/SearchPersonsResultScreen.dart';
import 'Show/SearchProgramResultScreen.dart';
import 'Show/SearchSeriesResultScreen.dart';

class SearchScreen extends StatefulWidget {
  var searchIdValue;

  SearchScreen({this.searchIdValue});

  @protected
  @override
  createState() => SearchScreenState();
}

class SearchScreenState extends StateMVC<SearchScreen>
    with SingleTickerProviderStateMixin {
  SearchScreenState() : super(SearchController()) {
    _searchController = SearchController.con;
  }

  SearchController _searchController;
  TextEditingController searchWordController = TextEditingController();
  TextEditingController searchDateController = TextEditingController();

  var format = new DateFormat('dd/MM/yyyy');
  DateTime selectedDate;
  var selectedTime = "";
  DateTime date;
  TimeOfDay time2;
  String workDays = "";
  String workTime = "";

  final List<Tab> tabs = <Tab>[];
  var screenWidth;
  var screenHeight;

  TabController _tabController;
  bool isLoaded = false;
  Auth auth;
  @override
  Future didChangeDependencies() async {
    auth = AppProvider.of(context).auth;
    if (isLoaded == false) {
      await _searchController.init(auth.userToken.toString());

      _tabController = new TabController(
          vsync: this,
          length: _searchController.categoriesSearchModel.categories.length);
      for (int i = 0;
          i < _searchController.categoriesSearchModel.categories.length;
          i++) {
        tabs.add(Tab(
            text: _searchController.categoriesSearchModel.categories[i].name));

        if (widget.searchIdValue != null) {
          if (widget.searchIdValue ==
              _searchController.categoriesSearchModel.categories[i].id) {
            _tabController.animateTo(i);
          }
        }
      }
//      _tabController.animateTo(2);
//      if (widget.searchIdValue)
      isLoaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int valueOfCat;

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 10;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    var isConnected = AppProvider.of(context).isConnected;
    return !isConnected
        ? NoNetworkScreen()
        : _searchController.isLoading
            ? SharedWidgets.loadingWidget(context)
            : Scaffold(
                appBar: AppBar(
                  leading: Container(),
                  actions: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 60,
                        child: Container(
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(25.7))),
                            child: TextField(
                              controller: searchWordController,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  hintText: "البحث",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ))),
                            ))),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ],
                  backgroundColor: Colors.black,
                  bottom: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: new BubbleTabIndicator(
                      indicatorHeight: 25.0,
                      indicatorColor: Colors.redAccent,
                      tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    ),
                    tabs: tabs,
                    controller: _tabController,
                  ),
                ),
                backgroundColor: Colors.black,
                body: TabBarView(
                  controller: _tabController,
                  children: _searchController.categoriesSearchModel.categories
                      .map((v) {
                    return ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Divider(
                              color: Colors.white,
                            ),
                            v.name.trim() != "مشاهير" &&
                                    v.name.trim() != "قنوات"
                                ? Container(
                                    child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 30,
                                        bottom: 30,
                                        left: 10,
                                        right: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "وقت العرض",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          child: Card(
                                            color: Color(0xffF1F2F3),
                                            elevation: 1.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  top: 0.0,
                                                  bottom: 0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        print("aaaaa");
                                                        _selectDate(context);
                                                      },
                                                      child: AbsorbPointer(
                                                        child: TextField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          enabled: false,
                                                          controller:
                                                              searchDateController,
                                                          decoration: InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "وقت العرض",
                                                              suffixIcon: Icon(Icons
                                                                  .insert_invitation)),
                                                          //enabled: false,

                                                          // onChanged: (value) => _coponController.searchCopons(value),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                : Container(),
                            v.name.trim() != "مشاهير" &&
                                    v.name.trim() != "قنوات"
                                ? Divider(
                                    color: Colors.white,
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: GridView.count(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: true,
                                physics: ScrollPhysics(),
                                crossAxisCount: 3,
                                mainAxisSpacing: 1.0,
                                crossAxisSpacing: 1.0,
                                childAspectRatio: cardWidth / cardHeight,
                                children: List.generate(v.subCategories.length,
                                    (index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Theme(
                                        child: new Radio(
                                          value: index,
                                          activeColor: Colors.redAccent,
                                          groupValue: valueOfCat,
                                          onChanged: (v) {
                                            valueOfCat = v;
                                            setState() => valueOfCat = v;
                                            setState();

                                            refresh();
                                          },
                                        ),
                                        data: new ThemeData(
                                            unselectedWidgetColor:
                                                Colors.white),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          valueOfCat = index;

                                          refresh();
                                        },
                                        child: Text(
                                          v.subCategories[index].name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: RaisedButton(
                                padding: EdgeInsets.only(
                                    top: 6.0,
                                    bottom: 6.0,
                                    right: 20.0,
                                    left: 20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "مسح النتائج",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  valueOfCat = null;
                                  searchDateController.clear();
                                  searchWordController.clear();
                                  refresh();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: RaisedButton(
                                padding: EdgeInsets.only(
                                    top: 6.0,
                                    bottom: 6.0,
                                    right: 20.0,
                                    left: 20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Text(
                                  "بحث",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  print(v.name.toString());
                                  if (v.name.trim() == "افلام") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => valueOfCat !=
                                                    null
                                                ? SearchMovieResultScreen(
                                                    selectedDate,
                                                    searchWordController.text
                                                        .toString(),
                                                    subCatId: v
                                                        .subCategories[
                                                            valueOfCat]
                                                        .id)
                                                : SearchMovieResultScreen(
                                                    selectedDate,
                                                    searchWordController.text
                                                        .toString())));
                                  } else if (v.name.trim() == "برامج") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => valueOfCat !=
                                                    null
                                                ? SearchProgramResultScreen(
                                                    selectedDate,
                                                    searchWordController.text
                                                        .toString(),
                                                    subCatId: v
                                                        .subCategories[
                                                            valueOfCat]
                                                        .id)
                                                : SearchProgramResultScreen(
                                                    selectedDate,
                                                    searchWordController.text
                                                        .toString())));
                                  } else if (v.name.trim() == "مسلسلات") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => valueOfCat !=
                                                    null
                                                ? SearchSeriesResultScreen(
                                                    selectedDate,
                                                    searchWordController.text
                                                        .toString(),
                                                    subCatId: v
                                                        .subCategories[
                                                            valueOfCat]
                                                        .id)
                                                : SearchSeriesResultScreen(
                                                    selectedDate,
                                                    searchWordController.text
                                                        .toString())));
                                  } else if (v.name.trim() == "مشاهير") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => valueOfCat !=
                                                    null
                                                ? SearchPersonsResultScreen(
                                                    selectedDate,
                                                    searchWordController.text
                                                        .toString(),
                                                    subCatId: v
                                                        .subCategories[
                                                            valueOfCat]
                                                        .id)
                                                : SearchPersonsResultScreen(
                                                    selectedDate,
                                                    searchWordController.text
                                                        .toString())));
                                  } else if (v.name.trim() == "قنوات") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => valueOfCat !=
                                                    null
                                                ? SearchChannelsResultScreen(
                                                    selectedDate,
                                                    searchWordController.text
                                                        .toString(),
                                                    subCatId: v
                                                        .subCategories[
                                                            valueOfCat]
                                                        .id)
                                                : SearchChannelsResultScreen(
                                                    selectedDate,
                                                    searchWordController.text
                                                        .toString())));
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(Duration(days: -1)),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget child) {
        return Material(
          child: Container(
              width: MediaQuery.of(context).size.width - 100, child: child),
        );
      },
    );
    if (picked != null && picked != DateTime.now())
      setState(() {
        date = picked;
        selectedDate = picked; // format.format(picked);
        searchDateController.text = picked.day.toString() +
            "/" +
            picked.month.toString() +
            "/" +
            picked.year.toString();
      });
  }
}
