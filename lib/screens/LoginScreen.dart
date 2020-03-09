import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/UserController.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/sharedWidget/TextFormFieldWidget.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import 'NoNetworkScreen.dart';

class LoginScreen extends StatefulWidget {
  @protected
  @override
  createState() => LoginScreenState();
}

class LoginScreenState extends StateMVC<LoginScreen> {
  LoginScreenState() : super(UserController()) {
    _userController = UserController.con;
  }
  UserController _userController;

  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var screenWidth;
  var screenHeight;

  FocusNode focusEmailField = new FocusNode();

  FocusNode focusLoginPasswordField = new FocusNode();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    var isConnected = AppProvider.of(context).isConnected;
    return !isConnected
        ? NoNetworkScreen()
        : Scaffold(
            backgroundColor: Colors.black,
            // key: TextFieldController.loginScaffoldkey,
            body: ListView(
              children: <Widget>[
                 Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              FixedAssets.logoIcon,
                              width: screenWidth - 50,
                              height: screenHeight * 0.12,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 30.0),
                          child: TextFormFieldWidget(
                              12.0,
                              16.0,
                              Colors.white,
                              Colors.white,
                              "البريد االاكتروني",
                              emailController,
                              null,
                              false,
                              TextInputType.emailAddress,
                              _userController,
                              false,
                              focusEmailField,
                              focusLoginPasswordField,
                              loginFormKey,
                              false,
                              context,
                              _userController.loginUserModel.validateEmail,
                              _userController.loginUserModel.email,
                              Icons.email,
                              6),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 30.0),
                          child: TextFormFieldWidget(
                              10.0,
                              16.0,
                              Colors.white,
                              Colors.white,
                              "كلمه االمرور",
                              passwordController,
                              null,
                              false,
                              TextInputType.text,
                              _userController,
                              true,
                              focusLoginPasswordField,
                              null,
                              loginFormKey,
                              true,
                              context,
                              _userController.loginUserModel.validatePassword,
                              _userController.loginUserModel.password,
                              Icons.lock,
                              7),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                "هل نسيت كلمه السر؟",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/ForgetPassword");
                              },
                            )
                          ],
                        ),
                        Container(
//                        width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                  "تسجيل الدخول",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.red,
                                onPressed: () {
//                                Navigator.pushNamed(context, "/Home");

                                  _userController.signInWithEmailAndPassword(
                                      context, loginFormKey);
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "او",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: Card(
                                color: Color(0xff4267b2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
//                                Navigator.pushNamed(context, "/ForgetPassword");
                                _userController.socialLogin(
                                    context, "facebook");
                              },
                            ),
                            FlatButton(
                              child: Card(
                                color: Color(0xffDC4E41),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                _userController.socialLogin(context, "google");
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "ليس لديك حساب؟",
                              style: TextStyle(color: Colors.white),
                            ),
                            FlatButton(
                              child: Text(
                                "انشاء حساب",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                               // Navigator.pushNamed(context, "/Register");
                                Navigator.pushNamed(context, "/MainFavouriteScreen");
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}
