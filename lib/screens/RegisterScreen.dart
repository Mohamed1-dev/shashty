import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/UserController.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/sharedWidget/TextFormFieldWidget.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import 'NoNetworkScreen.dart';

class RegisterScreen extends StatefulWidget {
  String favouriteCategoryType;
  List <int> favouriteCategoryIds;
  RegisterScreen({@required this.favouriteCategoryIds,@required this.favouriteCategoryType});
  @protected
  @override
  createState() => RegisterScreenState();
}

class RegisterScreenState extends StateMVC<RegisterScreen> {
  RegisterScreenState() : super(UserController()) {
    _userController = UserController.con;
  }

  UserController _userController;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> regFormKey = GlobalKey<FormState>();
  var screenWidth;
  var screenHeight;
  FocusNode focusUserNameField = new FocusNode();
  FocusNode focusEmailField = new FocusNode();
  FocusNode focusPhoneField = new FocusNode();
  FocusNode focusRegPasswordField = new FocusNode();
  FocusNode focusRetypePasswordField = new FocusNode();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    var isConnected = AppProvider.of(context).isConnected;
    _userController.registerUserModel.favouriteType=widget.favouriteCategoryType;
    _userController.registerUserModel.favouritesIds=widget.favouriteCategoryIds;
    return !isConnected
        ? NoNetworkScreen()
        : Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                       Form(
                        key: regFormKey,
                        child: Column(
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
                                  "الاسم",
                                  userNameController,
                                  null,
                                  false,
                                  TextInputType.text,
                                  _userController,
                                  false,
                                  focusUserNameField,
                                  focusEmailField,
                                  regFormKey,
                                  false,
                                  context,
                                  _userController
                                      .registerUserModel.validateUserName,
                                  _userController.registerUserModel.name,
                                  Icons.person,
                                  1),
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
                                  false,
                                  focusEmailField,
                                  focusPhoneField,
                                  regFormKey,
                                  false,
                                  context,
                                  _userController
                                      .registerUserModel.validateEmail,
                                  _userController.registerUserModel.email,
                                  Icons.email,
                                  2),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 30.0),
                              child: TextFormFieldWidget(
                                  12.0,
                                  16.0,
                                  Colors.white,
                                  Colors.white,
                                  "رقم الهاتف",
                                  phoneController,
                                  null,
                                  false,
                                  TextInputType.phone,
                                  _userController,
                                  false,
                                  focusPhoneField,
                                  focusRegPasswordField,
                                  regFormKey,
                                  false,
                                  context,
                                  _userController
                                      .registerUserModel.validatePhone,
                                  _userController.registerUserModel.phone,
                                  Icons.phone,
                                  3),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 30.0),
                              child: TextFormFieldWidget(
                                  12.0,
                                  16.0,
                                  Colors.white,
                                  Colors.white,
                                  "كلمة السر",
                                  passwordController,
                                  null,
                                  false,
                                  TextInputType.text,
                                  _userController,
                                  false,
                                  focusRegPasswordField,
                                  focusRetypePasswordField,
                                  regFormKey,
                                  true,
                                  context,
                                  _userController
                                      .registerUserModel.validatePassword,
                                  _userController.registerUserModel.password,
                                  Icons.lock,
                                  4),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 30.0),
                              child: TextFormFieldWidget(
                                  12.0,
                                  16.0,
                                  Colors.white,
                                  Colors.white,
                                  "تأكيد كلمة السر",
                                  confirmPasswordController,
                                  passwordController,
                                  true,
                                  TextInputType.text,
                                  _userController,
                                  true,
                                  focusRetypePasswordField,
                                  null,
                                  regFormKey,
                                  true,
                                  context,
                                  _userController.registerUserModel
                                      .validateConfirmPassword,
                                  _userController.registerUserModel.password,
                                  Icons.lock,
                                  4),
                            ),
                            Container(
//                        width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    padding: EdgeInsets.only(
                                        top: 12.0,
                                        bottom: 12.0,
                                        right: 40.0,
                                        left: 40.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Text(
                                      "أنشاء حساب",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.red,
                                    onPressed: () {
                                      _userController.regNewUser(
                                          context, regFormKey);
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
                                    _userController.socialSignUp(
                                        context, "facebook",widget.favouriteCategoryType,widget.favouriteCategoryIds);
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
                                    _userController.socialSignUp(context, "google",widget.favouriteCategoryType,widget.favouriteCategoryIds);
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
