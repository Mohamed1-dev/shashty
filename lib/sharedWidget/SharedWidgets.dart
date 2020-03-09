import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

class SharedWidgets {
  static loading(context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  static loadingWidget(context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          FixedAssets.splashScreen,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  static mustLogin(context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return showDialog(
        context: context,
//        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
                left: 10, right: 10, top: height / 3, bottom: height / 3),
            child: Card(
              shape: OutlineInputBorder(
                  borderRadius:
                      new BorderRadius.all(new Radius.elliptical(10.0, 10.0))),
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "قم بتسجيل الدخول اولا او انشاء حساب للحصول\n على الصلحيات",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 52,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          padding: EdgeInsets.only(
                              top: 6.0, bottom: 6.0, right: 20.0, left: 20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Text(
                            "تسجيل الدخول",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pushNamed(context, "/Login");
                          },
                        ),
                        RaisedButton(
                          padding: EdgeInsets.only(
                              top: 6.0, bottom: 6.0, right: 20.0, left: 20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Text(
                            "إنشاء حساب جديد",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pushNamed(context, "/Register");
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  static backButtonArrow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }

  static appBarWithString(context, String name) {
    return AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ]);
  }

  static void showSnackBar(GlobalKey<ScaffoldState> key, message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
    key.currentState.showSnackBar(snackBar);
  }

  static void showToastMsg(message, isRed) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 3,
        backgroundColor: isRed == true ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    // key.currentState.showSnackBar(snackBar);
  }
}
