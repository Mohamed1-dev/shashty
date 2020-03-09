import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shashty_app/data/Models/FirebaseUser.dart';
import 'package:shashty_app/data/Models/UserModel.dart';
import 'package:shashty_app/data/Models/UserModelWithToken.dart';

abstract class BaseAuth {
  String userToken,
      fireBaseToken;
  UserModel userModel;
}

class Auth implements BaseAuth {
  List<FirebaseUser> listFirebaseUsers = List<FirebaseUser>();
  FirebaseUser currentFirebaseUser;
  SharedPreferences prefs;
  UserModel userModel;
  UserModelWithToken userModelWithToken;
  bool isGuest = true;
  String userToken = "",
      fireBaseToken;

  void saveUserToSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("userToken", this.userModelWithToken.accessToken);
  }

  getFirebaseUser(VoidCallback callback) {
    FirebaseDatabase.instance.reference().child("users").onValue.listen((v) {
      listFirebaseUsers.clear();
      currentFirebaseUser = null;
      Map<dynamic, dynamic> map = v.snapshot.value;
      map.forEach((x, z) {
        FirebaseUser user = FirebaseUser();
        user.userId = x.toString();
      //  print(user.userId );

       // Map<dynamic, dynamic> map2 = z;
        z.forEach((x2, z2) {
          if (x2.toString() == "reminder") {
            user.reminder = z2.toString();
          } else {
            user.notification = z2.toString();
          }
//          print(x2.toString() + " " + z2.toString() + " alalal222");
        });
        listFirebaseUsers.add(user);
      });
      if (isGuest == false) {
        currentFirebaseUser = null;
        for (int i = 0; i < listFirebaseUsers.length; i++) {
          if (userModel.id.toString() == listFirebaseUsers[i].userId) {
            currentFirebaseUser = listFirebaseUsers[i];
//            print(v.snapshot.value.toString() + " qeqeq");
            callback();
          }
        }
      }
      callback();
    });
  }

  void removeUserFromSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.clear().then((isRemoved) {
      userModel = null;
      userModelWithToken = null;
      userToken = null;
      fireBaseToken = null;
      isGuest = true;
      print("done");
    });
  }

  Future<String> getUserToSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString("userToken");
    print(userToken.toString());
    currentFirebaseUser = null;
    return userToken.toString();
  }
}
