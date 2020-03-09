import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/HomeController.dart';
import 'package:shashty_app/controllers/UserController.dart';
import 'package:shashty_app/screens/FavouriteScreen.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import 'SharedWidgets.dart';

class DrawerView extends StatefulWidget {
//  var contextView;

//  DrawerView(this.contextView);
  HomeController homeController;
  DrawerView({this.homeController});
  @override
  createState() => _DrawerView();
}

class _DrawerView extends StateMVC<DrawerView> {
  _DrawerView() : super(UserController()) {
    _userController = UserController.con;
  }

  callBack() {
    refresh();
  }

  UserController _userController;
  Auth auth;
  @override
  Widget build(BuildContext context) {
    auth = AppProvider.of(context).auth;
    auth.getFirebaseUser(callBack);

    return Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors.black.withOpacity(
              .5), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: Drawer(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.redAccent, width: 3.4),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: auth.userModel == null ||
                                      auth.userModel.image == null ||
                                      auth.userModel.image.trim() == ""
                                      ? AssetImage(FixedAssets.noImage)
                                      : NetworkImage(ApiRoutes.public +
                                      auth.userModel.image)))),
                    ],
                  )),
              auth.userModel != null
                  ? Container(
                width: 200.0,
                height: MediaQuery.of(context).size.height *0.08,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {

                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/EditProfile");
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.edit,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            auth.userModel.name.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      auth.userModel.email.toString(),
                      style:
                      TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ],
                ),
              )
                  : Container(),
              auth.userModel == null
                  ? GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/Login");
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23.0,
                            color: Colors.white),
                      ),
                    ],
                  ))
                  : Container(),
              auth.isGuest == false
                  ? Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5, 0.0, 0.0),
                child: new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,  MaterialPageRoute(
                        builder: (context) =>FavouriteScreen(homeController: widget.homeController,)));
                  },
                  color: Colors.transparent,
                  textColor: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: Text("المفضله لدي",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              )
                  : Container(),
              auth.isGuest
                  ? Container()
                  : Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5, 0.0, 0.0),
                child: new FlatButton(
                  onPressed: () {
                    if (auth.isGuest) {
                      SharedWidgets.mustLogin(context);
                    } else {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, "/NotificationScreen");
                    }
                  },
                  color: Colors.transparent,
                  textColor: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: Text("الاشعارات",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            )),
                      ),
                      auth.isGuest ||
                          auth.currentFirebaseUser == null ||
                          auth.currentFirebaseUser.notification == "0"
                          ? Container()
                          : CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          child: new Text(
                              auth.currentFirebaseUser.notification
                                  .toString(),
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0)))
                    ],
                  ),
                ),
              ),
              auth.isGuest
                  ? Container()
                  : Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5, 0.0, 0.0),
                child: new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/ReminderScreen");
                  },
                  color: Colors.transparent,
                  textColor: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: Text("التذكير",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            )),
                      ),
                      auth.isGuest ||
                          auth.currentFirebaseUser == null ||
                          auth.currentFirebaseUser.reminder == "0"
                          ? Container()
                          : CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          child: new Text(
                              auth.currentFirebaseUser.reminder
                                  .toString(),
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0)))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5, 0.0, 0.0),
                child: new FlatButton(
                  onPressed: () {},
                  color: Colors.transparent,
                  textColor: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.help_outline,
                        color: Colors.white,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: Text("المساعدة",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5, 0.0, 0.0),
                child: new FlatButton(
                  onPressed: () {},
                  color: Colors.transparent,
                  textColor: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.headset_mic,
                        color: Colors.white,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: Text("اتصل بنا",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5, 0.0, 0.0),
                child: new FlatButton(
                  onPressed: () {},
                  color: Colors.transparent,
                  textColor: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: Text("حقوق الملكية",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5, 0.0, 0.0),
                child: new FlatButton(
                  onPressed: () {},
                  color: Colors.transparent,
                  textColor: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.pan_tool,
                        color: Colors.white,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: Text("الشروط و الاحكام",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              auth.userModel != null
                  ? Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                child: new FlatButton(
                  onPressed: () async {
                    await _userController.logout(context);
                  },
                  color: Colors.transparent,
                  textColor: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      new Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: Text("تسجيل الخروج",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              )
                  : Container(),
            ],
          ),
        ));
  }
}