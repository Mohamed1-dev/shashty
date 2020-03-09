import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/ReminderController.dart';
import 'package:shashty_app/data/Models/ShowRemindModel.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import 'NoNetworkScreen.dart';

class ReminderScreen extends StatefulWidget {
  @protected
  @override
  createState() => ReminderScreenState();
}

class ReminderScreenState extends StateMVC<ReminderScreen> {
  ReminderScreenState() : super(ReminderController()) {
    _reminderController = ReminderController.con;
  }

  ReminderController _reminderController;
  Auth auth;
  bool isLoaded = false;

  int apiMonth;

  //bool isLoaded;
  int apiYear;
  String userToken;
  String authorizationValue;
  var httpResponse;
  bool changedDate = false;
  bool changeList = false;
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = '';
  List<ShowRemindModel> selectedShowRemindModel = List<ShowRemindModel>();
  showSelectedDate(DateTime dateTime) {
    selectedShowRemindModel.clear();
    for (int i = 0; i < _reminderController.listShowRemindModel.length; i++) {
      if (_reminderController.listShowRemindModel[i].startDate.year ==
          dateTime.year &&
          _reminderController.listShowRemindModel[i].startDate.month ==
              dateTime.month &&
          _reminderController.listShowRemindModel[i].startDate.day ==
              dateTime.day) {
        selectedShowRemindModel.add(_reminderController.listShowRemindModel[i]);
      }
    }
    refresh();
  }

  remindCard(ShowRemindModel showRemindModel) {
    return Container(
      color: Colors.black45,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: showRemindModel.kind=="shows"?
        Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: FadeInImage(
                    width: 70,
                    height: 70,
                    image: showRemindModel != null
                        ? NetworkImage(ApiRoutes.public + showRemindModel.shows.image)
                        : AssetImage(FixedAssets.noImage,),
                    placeholder: AssetImage(FixedAssets.noImage),
                    fit: BoxFit.fill,
                  ),
                )),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: AutoSizeText(
                        showRemindModel.shows.name,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    AutoSizeText(
                      "  من  " +
//                          showRemindModel.startDate.hour.toString() +
//                          ":" +
//                          showRemindModel.startDate.minute.toString() +
                          DateFormat.jm()
                              .format(showRemindModel.startDate)
                              .toString() +
                          "\n" +
                          "  الى  " +
                          DateFormat.jm()
                              .format(showRemindModel.startDate
                              .add(Duration(hours: 3)))
                              .toString(),

                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.white,
                      onPressed: () async {
                        await _reminderController
                            .removeReminder(
                            showRemindModel.shows.id,
                            auth.userToken,
                            true,
                            showRemindModel.startDate,
                            context)
                            .then((value) async {
                              if(value)
                            selectedShowRemindModel.remove(showRemindModel);

                          await _reminderController
                              .getAllReminder(auth.userToken).then((value){
//                                refresh();
                          });
                        });
                      },
                    ),
                  ],
                )),
          ],
        ):
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Expanded(
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        image: NetworkImage(
                          "http://koramania.cloudapp.net/FBMSImages/${showRemindModel.shows.HOME_TEAM_LOGO}",
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius:
                      new BorderRadius.all(Radius.circular(70)),
                    ),
                    child: InkWell(
                      onTap: () {},
                    ),
                  ),
                  Text(
                    "${showRemindModel.shows.Home_TeamName}",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),

                ],
            ),
             ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      showRemindModel.shows.LeagueName.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${showRemindModel.startDate.minute} : ${showRemindModel.startDate.hour} ",
                      style: TextStyle(color: Colors.white, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        image: NetworkImage(
                          "http://koramania.cloudapp.net/FBMSImages/${showRemindModel.shows.AWAY_TEAM_LOGO}",
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius:
                      new BorderRadius.all(Radius.circular(70)),
                    ),
                    child: InkWell(
                      onTap: () {},
                    ),
                  ),
                  Text(
                    "${showRemindModel.shows.Away_TeamName}",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
             IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              onPressed: () async {
                print("football match id" + showRemindModel.reminderable_id.toString());
                await _reminderController
                    .removeReminder(
                    showRemindModel.reminderable_id,
                    auth.userToken,
                    null,
                    showRemindModel.startDate,
                    context)
                    .then((value) async {
                  selectedShowRemindModel.remove(showRemindModel);
                  await _reminderController
                      .getAllReminder(auth.userToken).then((value){
//                        refresh();
                  });
                });
              },
            ),
           ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    if (isLoaded == false) {
      print(" initialize reminder screen ");

      auth = AppProvider.of(context).auth;
      print("reminder screen ${auth.userToken}");

      await _reminderController.init(context, auth.userToken);
      for (int i = 0; i < _reminderController.listShowRemindModel.length; i++) {
        print(i.toString() + " awawfk");
//        print(_reminderController.listShowRemindModel[i].shows.toString() +
//            " awawfk");
        _markedDateMap.add(
            DateTime(
                _reminderController.listShowRemindModel[i].startDate.year,
                _reminderController.listShowRemindModel[i].startDate.month,
                _reminderController.listShowRemindModel[i].startDate.day),
            new Event(
              date: _reminderController.listShowRemindModel[i].startDate,
              title: 'Event 5',
              icon: _eventIconFunc(
                  _reminderController.listShowRemindModel[i].startDate.day),
            ));
      }
      isLoaded = true;
      refresh();
    }
    super.didChangeDependencies();
  }

  EventList<Event> _markedDateMap = new EventList<Event>();
  CalendarCarousel _calendarCarouselNoHeader;

  static Widget _eventIconFunc(num) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(1000000)),
      ),
      //  border: Border.all(color: Colors.blue, width: 2.0)),
      child: Center(
        child: new Text(
          num.toString(),
          style: TextStyle(color: Colors.white, fontFamily: ""),
        ),
      ),
    );
  }

  var screenWidth;
  var screenHeight;

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    apiYear = currentTime.year;
    apiMonth = currentTime.month;
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        _currentDate2 = date;
        //print("123" + events.toString());
        showSelectedDate(date);
        refresh();
        events.forEach(
                (event) => print(event.title + "...." + event.date.toString()));
        refresh();
      },

      weekFormat: false,
      headerTitleTouchable: false,
      staticSixWeekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 310,
      selectedDateTime: _currentDate2,
      todayBorderColor: Colors.transparent,
      selectedDayButtonColor: Colors.blue[900],
      iconColor: Colors.lightBlue,
      weekendTextStyle: TextStyle(color: Colors.red),
      selectedDayBorderColor: Colors.orange,
      inactiveDaysTextStyle: TextStyle(color: Colors.white),
      prevDaysTextStyle: TextStyle(color: Colors.white),
      daysHaveCircularBorder: true,
      thisMonthDayBorderColor: Colors.transparent,
      headerTextStyle: TextStyle(color: Colors.red),
      daysTextStyle: TextStyle(color: Colors.red),
      inactiveWeekendTextStyle: TextStyle(color: Colors.white),
      weekdayTextStyle: TextStyle(color: Colors.red),
      selectedDayTextStyle: TextStyle(color: Colors.white),
      isScrollable: false,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
//      customGridViewPhysics: ScrollPhysics(),
//      width: MediaQuery.of(context).size.width,
      markedDateShowIcon: true,
      todayButtonColor: Colors.red, //Color(0xffe9c5ba),
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: false,
      showHeader: false,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      minSelectedDate: _currentDate.subtract(Duration(days: 1)),
      onCalendarChanged: (DateTime date) {
        setState(() {
          if (_currentDate2.month != date.month ||
              _currentDate2.year != date.year) {
            _currentDate2 = date;
            changedDate = true;
            showSelectedDate(date);
            changeList = true;
            refresh();
          }
        });
        _currentMonth = DateFormat.yMMM().format(date);
        setState(() {
          changeList = true;
          refresh();
        });
      },
    );

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    var isConnected = AppProvider.of(context).isConnected;
    return !isConnected
        ? NoNetworkScreen()
        : _reminderController.isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : Scaffold(
        appBar: SharedWidgets.appBarWithString(context, "التذكير"),
        backgroundColor: Colors.grey[850],
        body: _reminderController.listShowRemindModel.length == 0
            ? Center(
            child: Text(
              "لا يوجد تذكير",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ))
            : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 30.0,
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                            _currentMonth,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "",
                                fontSize: 24.0,
                                color: Colors.red),
                          )),
                      _currentDate2.month != apiMonth
                          ? GestureDetector(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: 40,
                          color: Colors.red,
                        ),
                        onTap: () {
                          _currentDate2 = _currentDate2
                              .subtract(Duration(days: 31));
                          showSelectedDate(_currentDate2);
                          _currentMonth = DateFormat.yMMM()
                              .format(_currentDate2);
//                                    changedDate = true;
//                                    changeList = true;
                          refresh();
                        },
                      )
                          : Container(),
                      GestureDetector(
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          size: 40,
                          color: Colors.red,
                        ),
                        onTap: () {
                          _currentDate2 =
                              _currentDate2.add(Duration(days: 31));

                          _currentMonth =
                              DateFormat.yMMM().format(_currentDate2);
//                              changedDate = true;
//                              changeList = true;
                          showSelectedDate(_currentDate2);
                          refresh();
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarouselNoHeader,
                ),
//                    Expanded(
//                      child:
                ListView.separated(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: true,
                  separatorBuilder:
                      (BuildContext context, int index) {
                    return Divider();
                  },
                  itemCount: selectedShowRemindModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return remindCard(selectedShowRemindModel[index]);
                  },
                ),
//                    )
              ],
            )));
  }
}
