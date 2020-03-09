import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/NotificationController.dart';
import 'package:shashty_app/data/Models/NotificationModel.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import 'NoNetworkScreen.dart';

class NotificationScreen extends StatefulWidget {
  @protected
  @override
  createState() => NotificationScreenState();
}

class NotificationScreenState extends StateMVC<NotificationScreen> {
  NotificationScreenState() : super(NotificationController()) {
    _notificationController = NotificationController.con;
  }

  NotificationController _notificationController;
  Auth auth;
  bool isLoaded = false;

  @override
  void didChangeDependencies() async {
    if (isLoaded == false) {
      auth = AppProvider.of(context).auth;
      await _notificationController.init(context, auth.userToken);
      isLoaded = true;
      refresh();
    }
    super.didChangeDependencies();
  }

  var screenWidth;
  var screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    var isConnected = AppProvider.of(context).isConnected;
    return !isConnected
        ? NoNetworkScreen()
        : _notificationController.isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : Scaffold(
        appBar: SharedWidgets.appBarWithString(context, "الاشعارات"),
        backgroundColor: Colors.grey[850],
        body: _notificationController
            .notificationModel.data.data.length ==
            0
            ? Center(
            child: Text(
              "لا توجد اشعارات",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ))
            : Column(
          children: <Widget>[
            _notificationController
                .notificationModel.data.data.length !=
                0
                ? Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.only(
                        top: 6.0,
                        bottom: 6.0,
                        right: 20.0,
                        left: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0))),
                    child: Text(
                      "اجعل الكل مقروء",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: () async {
                      await _notificationController
                          .readNotification(
                          auth.userToken, context, true)
                          .then((res) async {
                        if (res) {
                          await _notificationController
                              .getAllNotification(
                              auth.userToken);
                        }
                      });
                    },
                  ),
                  RaisedButton(
                    padding: EdgeInsets.only(
                        top: 6.0,
                        bottom: 6.0,
                        right: 20.0,
                        left: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0))),
                    child: Text(
                      "مسح الكل",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: () async {
                      await _notificationController
                          .removeNotification(
                          auth.userToken, context, true)
                          .then((res) async {
                        if (res) {
                          await _notificationController
                              .getAllNotification(
                              auth.userToken);
                        }
                      });
                    },
                  ),
                ],
              ),
            )
                : Container(),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: _notificationController
                    .notificationModel.data.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: _notificationController
                        .notificationModel
                        .data
                        .data[index]
                        .reading ==
                        0
                        ? Colors.black54
                        : Colors.black12,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(20),
                                child: FadeInImage(
                                  width: 80,
                                  height: 120,
                                  image: _notificationController
                                      .notificationModel
                                      .data
                                      .data[index]
                                      .image !=
                                      null
                                      ? NetworkImage(ApiRoutes
                                      .public +
                                      _notificationController
                                          .notificationModel
                                          .data
                                          .data[index]
                                          .image)
                                      : AssetImage(
                                    FixedAssets.noImage,
                                  ),
                                  placeholder: AssetImage(
                                      FixedAssets.noImage),
                                  fit: BoxFit.fill,
                                ),
                              )),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AutoSizeText(
                                _notificationController
                                    .notificationModel
                                    .data
                                    .data[index]
                                    .text,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: TextStyle(
                                    color: Colors.white),
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
                                      await _notificationController
                                          .removeNotification(
                                          auth.userToken,
                                          context,
                                          false,
                                          notificationID:
                                          _notificationController
                                              .notificationModel
                                              .data
                                              .data[index]
                                              .id)
                                          .then((res) async {
                                        if (res) {
                                          await _notificationController
                                              .getAllNotification(
                                              auth.userToken);
                                        }
                                      });
//                                              _notificationController
//                                                  .notificationModel.data.data
//                                                  .remove(
//                                                      _notificationController
//                                                          .notificationModel
//                                                          .data
//                                                          .data[index]);
//                                              refresh();
                                    },
                                  ),
                                  _notificationController
                                      .notificationModel
                                      .data
                                      .data[index]
                                      .reading ==
                                      0
                                      ? IconButton(
                                    icon:
                                    Icon(Icons.adjust),
                                    color: Colors.white,
                                    onPressed: () async {
                                      await _notificationController
                                          .readNotification(
                                          auth
                                              .userToken,
                                          context,
                                          false,
                                          notificationID:
                                          _notificationController
                                              .notificationModel
                                              .data
                                              .data[
                                          index]
                                              .id)
                                          .then(
                                              (res) async {
                                            if (res) {
                                              await _notificationController
                                                  .getAllNotification(
                                                  auth.userToken);
                                            }
                                          });
//                                                    if (_notificationController
//                                                            .notificationModel
//                                                            .data
//                                                            .data[index]
//                                                            .reading ==
//                                                        "0") {
//                                                      _notificationController
//                                                          .notificationModel
//                                                          .data
//                                                          .data[index]
//                                                          .reading = "1";
//                                                    } else {
//                                                      _notificationController
//                                                          .notificationModel
//                                                          .data
//                                                          .data[index]
//                                                          .reading = "0";
//                                                    }
//                                                    refresh();
                                    },
                                  )
                                      : Container(),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
//                    return notificationModelView(_notificationController
//                        .notificationModel.data.data[index]);
                },
                separatorBuilder:
                    (BuildContext context, int index) {
                  return Divider(
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ],
        ));
  }

  Widget notificationModelView(DataModel dataModel) {
    return Container(
      color: dataModel.reading ==0 ? Colors.black54 : Colors.black12,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    width: 80,
                    height: 120,
                    image: dataModel.image != null
                        ? NetworkImage(ApiRoutes.public + dataModel.image)
                        : AssetImage(
                      FixedAssets.noImage,
                    ),
                    placeholder: AssetImage(FixedAssets.noImage),
                    fit: BoxFit.fill,
                  ),
                )),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: AutoSizeText(
                  dataModel.text,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: TextStyle(color: Colors.white),
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
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.adjust),
                      color: Colors.white,
                      onPressed: () {
                        if (dataModel.reading==0) {
                          dataModel.reading = 1;
                        } else {
                          dataModel.reading = 1;
                        }
                        refresh();
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
    return ListTile(
//    isThreeLine: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          width: 70,
          height: 350,
          image: dataModel.image != null
              ? NetworkImage(ApiRoutes.public + dataModel.image)
              : AssetImage(
            FixedAssets.noImage,
          ),
          placeholder: AssetImage(FixedAssets.noImage),
          fit: BoxFit.fill,
        ),
      ),
//    title: Text('Test Title'),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AutoSizeText(
          dataModel.text,
          maxLines: 2,
          style: TextStyle(color: Colors.white),
        )
      ]),
    );
  }
}