import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/ShowController.dart';
import 'package:shashty_app/data/Models/ChannelShowModel.dart';
import 'package:shashty_app/sharedWidget/FavouritePopup.dart';
import 'package:shashty_app/sharedWidget/RatePopup.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../NoNetworkScreen.dart';
import 'MovieShowScreen.dart';
import 'ProgramAndSeriesShowScreen.dart';

class ChannelShowScreen extends StatefulWidget {
  int showID;
  String name;
  ChannelShowScreen(this.showID,this.name);

  @protected
  @override
  createState() => ChannelShowScreenState();
}

class ChannelShowScreenState extends StateMVC<ChannelShowScreen> {
  ChannelShowScreenState() : super(ShowController()) {
    _showController = ShowController.con;
  }

  bool isLoaded = false;
  Auth auth;

//    var  dateNow;

//  var dateDay = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int selectedIndex = 0;
  bool isSelected =false;



//  DateTime _pickedTime = DateTime.now();

  List<DateTime> _pickedDate = [
    DateTime.now(),
    DateTime.now().add(Duration(days: 1)),
    DateTime.now().add(Duration(days: 2)),
    DateTime.now().add(Duration(days: 3)),
    DateTime.now().add(Duration(days: 4)),
    DateTime.now().add(Duration(days: 5)),
  ];



//  List<Show> startDate = [];

//  startDate.sort((a,b) => a.compareTo(b));



  @override
  void didChangeDependencies() async {
    await initializeDateFormatting("ar_SA", null);
    auth = AppProvider.of(context).auth;
    if (isLoaded == false) {
      isLoaded = true;
      refresh();
      _showController.isLoading=true;
      await _showController.getChannelShowModel(
          widget.showID, auth.userToken.toString(),
          DateFormat("yyyy-MM-dd").format(_pickedDate[selectedIndex]).toString()
      ).then((value){
        _showController.isLoading=false;
        refresh();
      });
      print('********* dddddd  *************  ${DateFormat("yyyy-MM-dd").format(_pickedDate[selectedIndex]).toString()}');
      print('********* dddddd  *************  ${auth.userToken.toString()}');
      refresh();
      isLoaded = true;
      refresh();
    }
    super.didChangeDependencies();
  }

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
    if (!isConnected) {
      return NoNetworkScreen();
    } else {
      return _showController.isLoading
          ? SharedWidgets.loadingWidget(context)
          : Scaffold(
        appBar: SharedWidgets.appBarWithString(
            context, widget.name),
        backgroundColor: Colors.grey[850],
        body: _showController.channelShowModel == null
            ? Container()
            : Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    FadeInImage(
                      width: screenWidth,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height/4,

                      image: _showController.channelShowModel
                          .channel.image !=
                          null
                          ? NetworkImage(ApiRoutes.public +
                          _showController
                              .channelShowModel.channel.image)
                          : AssetImage(FixedAssets.noImage),
                      placeholder:
                      new AssetImage(FixedAssets.noImage),
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
                                _showController.channelShowModel
                                    .channel.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily:
                                    FixedAssets.ruqaFont,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0,),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(


                              children: List.generate(
                                  _pickedDate.length, (index) {
//                                                  for(int i ; i <= DateTime.now().add(Duration(days: 6))

                                return InkWell(
                                  onTap: () async{
                                    print(
                                        'date Time Tapped *** ${DateFormat("yyyy-MM-dd").format(_pickedDate[index])}');

//                                              isSelected = index;
                                    selectedIndex = index;
//                                              isLoaded = false;
//                                              didChangeDependencies();
//                                              CircularProgressIndicator();
                                    await _showController.getChannelShowModel(
                                        widget.showID, auth.userToken.toString(),
                                        DateFormat("yyyy-MM-dd").format(_pickedDate[selectedIndex]).toString()
                                    ).then((value){
//                                                Navigator.of(context).pop();
                                      refresh();
                                    });
                                  },
                                  child: Card(
                                    color:
//                                              isSelected
                                    Colors.black26
//                                                  : Colors.blueAccent
                                    ,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5.0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.0,
                                          vertical: 5.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            '${DateFormat.EEEE('ar_SA').format(_pickedDate[index]).toString()}',
                                            style: TextStyle(
                                                color:
                                                index  == selectedIndex ?
                                                Colors.white  :
                                                Colors.red,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          Text(
                                            '${DateFormat.MMMMd('ar_SA').format(_pickedDate[index]).toString()}',
                                            style: TextStyle(
                                                color: index  == selectedIndex ?
                                                Colors.white  :
                                                Colors.red,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
//      *************************************** second Card ***********************************

                      _showController
                          .channelShowModel.shows.length  ==
                          0
                          ? Container(

                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: screenHeight * 0.20,
                                ),
                                Center(
                                    child: Text(
                                      "لا توجد مواعيد عرض حاليا",
                                      style: TextStyle(
                                          color: Colors
                                              .white,
                                          fontSize:
                                          25),
                                    )),
                              ],
                            ),
                          )
                          :
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius:
                              BorderRadius.circular(10),
                              shape: BoxShape.rectangle),
                          padding: EdgeInsets.symmetric(
//                                          horizontal: 8.0,
                              vertical: 2.0),
                          width: MediaQuery.of(context).size.width -
                              30,
                          height:
                          MediaQuery.of(context).size.height /2,
                          child:ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(color: Colors.grey);
                            },
                            shrinkWrap: true,
                            primary: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: _showController
                                .channelShowModel.shows.length,
                            itemBuilder: (context, i) {

                              _showController
                                  .channelShowModel.shows.sort((a,b) => a.startDate.compareTo(b.startDate));
                              return Container(
//                                                margin:EdgeInsets.symmetric(horizontal: 10.0),
                                width: MediaQuery.of(context)
                                    .size
                                    .width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
//                                              crossAxisAlignment:
//                                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.only(
                                          topLeft:
                                          Radius.circular(8.0),
                                          topRight:
                                          Radius.circular(8.0),
                                        ),
                                        child: FadeInImage(
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              ApiRoutes.public +
                                                  _showController
                                                      .channelShowModel
                                                      .shows[i]
                                                      .shows
                                                      .image),
                                          placeholder:
                                          new AssetImage(
                                              FixedAssets
                                                  .noImage),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          _showController
                                              .channelShowModel
                                              .shows[i]
                                              .showId ==
                                              null
                                              ? null
                                              : _showController
                                              .channelShowModel
                                              .shows[i]
                                              .showId ==
                                              _showController
                                                  .channelShowModel
                                                  .shows[i]
                                                  .shows
                                                  .id
                                              ? '${_showController.channelShowModel.shows[i].shows.name}'
                                              : '',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 0,
                                      child: Text(
                                        _showController
                                            .channelShowModel
                                            .shows[i]
                                            .showId ==
                                            null
                                            ? null
                                            : _showController
                                            .channelShowModel
                                            .shows[i]
                                            .showId ==
                                            _showController
                                                .channelShowModel
                                                .shows[i]
                                                .shows
                                                .id
                                            ? '${DateFormat.jm('ar_SA').format(_showController.channelShowModel.shows[i].startDate)
                                        }'
                                            : 'no time yet',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.red),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        _showController
                                            .channelShowModel
                                            .shows[i]
                                            .showId ==
                                            null
                                            ? null
                                            : _showController
                                            .channelShowModel
                                            .shows[i]
                                            .showId ==
                                            _showController
                                                .channelShowModel
                                                .shows[i]
                                                .shows
                                                .id
                                            ? '${DateFormat.jm('ar_SA').format(_showController.channelShowModel.shows[i].endDate)}'
                                            : 'no time',
                                        style: TextStyle(
                                            color: Colors.white,
//                                                        fontSize: 20,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 0,
                                      child: Text(
                                        _showController
                                            .channelShowModel
                                            .shows[i]
                                            .shows
                                            .category
                                            .length >
                                            0
                                            ? _showController
                                            .channelShowModel
                                            .shows[i]
                                            .shows
                                            .category[0]
                                            .name
                                            .toString()
                                            : 'افلاام',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
//                                                    padding: EdgeInsets.symmetric(horizontal: 5.0),
//                                                    width: 50.0,
                                      child: Row(
//                                                      mainAxisAlignment:
//                                                          MainAxisAlignment
//                                                              .spaceBetween,
//                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
//                                                          width: 20.0,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.access_time,
//                                                            Icons.access_time,
                                                color: _showController
                                                    .channelShowModel
                                                    .shows[i]
                                                    .shows
                                                    .userRemind == 1 ? Colors.red : Colors.white,
                                                size: 15,
//                                                            Colors.white,
//                                                            size: 15.0,  size: 15,
                                              ),
                                              onPressed: () async {
                                                print('reminder time tapped');
                                                   await _showController
                                                      .remindShow(_showController.channelShowModel.shows[i].shows.id,
                                                      false,
                                                       _showController.channelShowModel.shows[i].shows.userRemind == 1 ? true : false,
                                                      context,
                                                      _showController
                                                          .channelShowModel
                                                          .shows[i]
                                                          .startDate)
                                                      .then(
                                                          (value) {
                                                        if (value==null) {
                                                          _showController.channelShowModel.shows[i].shows.userRemind = 0;
                                                          print("chnnel reminder icon red");
                                                        } else if(value) {
                                                          print("chnnel reminder icon white");
                                                          _showController
                                                              .channelShowModel
                                                              .shows[i]
                                                              .shows
                                                              .userRemind = 1;
                                                        }
                                                        refresh();

                                                          });

                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              icon: Icon(
                                                _showController
                                                    .channelShowModel
                                                    .shows[
                                                i]
                                                    .shows
                                                    .userFavourite ==
                                                    1
                                                    ? Icons.favorite
                                                    : Icons
                                                    .favorite_border,
//
                                                color: _showController
                                                    .channelShowModel
                                                    .shows[i]
                                                    .shows
                                                    .userFavourite ==
                                                    1
                                                    ? Colors.red
                                                    : Colors.white,
                                                size: 15,
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context:
                                                    context,
                                                    builder:
                                                        (BuildContext
                                                    context) {
                                                      return FavouritePopup(


                                                          _showController
                                                              .channelShowModel
                                                              .shows[
                                                          i]
                                                              .shows
                                                              .id,
                                                          _showController.channelShowModel.shows[i].shows.userFavourite ==
                                                              1
                                                              ? true
                                                              : false,
                                                          false
                                                          ,
                                                              (value) {
                                                            print(value
                                                                .toString() +
                                                                " valueee");
//                                                                          () {
                                                            _showController
                                                                .channelShowModel
                                                                .shows[i]
                                                                .shows
                                                                .userFavourite = value.toInt();
                                                            refresh();
                                                          });
                                                    });
                                                refresh();

                                                print(
                                                    '${_showController.channelShowModel.shows[i].shows.userFavourite} ****** userFavourite ');
                                                print(
                                                    '${_showController.channelShowModel.shows[i].shows.category[i].name} ******  category name ');
                                                print(
                                                    'Favourite time tapped');
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              icon: Icon(
                                                _showController
                                                    .channelShowModel
                                                    .shows[
                                                i]
                                                    .shows
                                                    .rating  !=
                                                    1
                                                    ? Icons.star
                                                    : Icons
                                                    .star_border,
                                                color: _showController
                                                    .channelShowModel
                                                    .shows[i]
                                                    .shows
                                                    .userRate !=
                                                    0
                                                    ? Colors.red
                                                    : Colors.white,
                                                size: 15,
                                              ),
                                              onPressed: () async {
                                                if (auth.isGuest) {
                                                  SharedWidgets
                                                      .mustLogin(
                                                      context);
                                                } else {
                                                  print(_showController
                                                      .channelShowModel
                                                      .shows[i]
                                                      .shows
                                                      .rating
                                                      .toString() +
                                                      " rating");
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                          (BuildContext
                                                      context) {
                                                        return RatePopup(
                                                            _showController
                                                                .channelShowModel
                                                                .shows[i]
                                                                .shows
                                                                .id,
                                                            _showController
                                                                .channelShowModel
                                                                .shows[i]
                                                                .shows
                                                                .rating
                                                                .toDouble(),
                                                            false,
                                                                (value,
                                                                int rateValue) {
                                                              _showController
                                                                  .channelShowModel
                                                                  .shows[i]
                                                                  .shows
                                                                  .rating = value.toInt();

                                                              print(
                                                                  '****  rating ${_showController.channelShowModel.shows[i].shows.rating}');
                                                              _showController
                                                                  .channelShowModel
                                                                  .shows[
                                                              i]
                                                                  .shows
                                                                  .userRate = rateValue;
                                                              print(
                                                                  '**** user rate ${_showController.channelShowModel.shows[i].shows.userRate}');

                                                              refresh();
                                                            });
                                                      });
                                                }
                                                refresh();


                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                      )




                    ],
                  ),
                ),
              )


            ]),
          ),
        ),
      );
    }
  }
}
