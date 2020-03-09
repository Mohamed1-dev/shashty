import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import '../controllers/UserController.dart';
import '../utils/Auth.dart';
import 'NoNetworkScreen.dart';

class SplashScreen extends StatefulWidget {
  @protected
  @override
  createState() => SplashView();
}

class SplashView extends StateMVC<SplashScreen> {
  SplashView() : super(UserController()) {
    _userController = UserController.con;
  }
  Auth auth;
  UserController _userController;
  String imagePath = FixedAssets.splashScreen;
  Future setTimer(context) async {
    auth = AppProvider.of(context).auth;
     Timer(Duration(seconds: 2), () {
      _userController.getCurrentUser(context).then((isLogged) async{
        await auth.getUserToSharedPreferences();
         if (auth.userToken == null || auth.userToken == "") {
          print(auth.userToken.toString());
       //   Navigator.pushReplacementNamed(context, "/MainFavouriteScreen");
          Navigator.pushReplacementNamed(context, "/Login");


         }else
        Navigator.pushReplacementNamed(context, "/Home");
      });
    });
  }

  bool isTrue = true;
  @override
  void didChangeDependencies() {
    if (isTrue) {
      setTimer(context);
      isTrue = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var isConnected = AppProvider.of(context).isConnected;
    return !isConnected
        ? NoNetworkScreen()
        : Scaffold(
            body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              imagePath,
              fit: BoxFit.fill,
            ),
          ));
  }
}
