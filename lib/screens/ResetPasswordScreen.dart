import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/UserController.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/sharedWidget/TextFormFieldWidget.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import 'NoNetworkScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @protected
  @override
  createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends StateMVC<ForgetPasswordScreen> {
  ForgetPasswordScreenState() : super(UserController()) {
    _userController = UserController.con;
  }

  UserController _userController;
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  FocusNode focusEmailField = new FocusNode();

  var screenWidth;
  var screenHeight;

  @override
  void dispose() {
    _userController.resetPasswordValue = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    var isConnected = AppProvider.of(context).isConnected;
    return !isConnected
        ? NoNetworkScreen()
        : Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SharedWidgets.backButtonArrow(context),
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Form(
                          key: resetPasswordFormKey,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    FixedAssets.logoIcon,
                                    width: screenWidth - 50,
                                    height: screenHeight * 0.12,
//                      height: 80,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 30.0),
                                child: TextFormFieldWidget(
                                    12.0,
                                    16.0,
                                    Colors.white,
                                    Colors.white,
                                    "البريد الالكتروني",
                                    emailController,
                                    null,
                                    false,
                                    TextInputType.emailAddress,
                                    _userController,
                                    true,
                                    focusEmailField,
                                    null,
                                    resetPasswordFormKey,
                                    false,
                                    context,
                                    _userController
                                        .loginUserModel.validateEmail,
                                    _userController.resetPasswordValue,
                                    Icons.lock,
                                    5),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, top: 0.0, left: 30, right: 30),
                                child: Container(
                                  child: RaisedButton(
                                    padding: EdgeInsets.only(
                                        top: 6.0,
                                        bottom: 6.0,
                                        right: 20.0,
                                        left: 20.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Text(
                                      "ارسال",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.red,
                                    onPressed: () {
                                      _userController.resetPassword(
                                          context, resetPasswordFormKey);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
