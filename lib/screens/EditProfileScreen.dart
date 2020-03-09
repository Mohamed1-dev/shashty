import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/UserController.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/sharedWidget/TextFormFieldWidget.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

import 'NoNetworkScreen.dart';

class EditProfileScreen extends StatefulWidget {
  @protected
  @override
  createState() => _EditProfileScreen();
}

class _EditProfileScreen extends StateMVC<EditProfileScreen> {
  _EditProfileScreen() : super(UserController()) {
    _userController = UserController.con;
  }

  UserController _userController;

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  var screenWidth;
  var screenHeight;
  bool isLoaded = false;
  Auth auth;

  @override
  void dispose() {
    _userController.image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    auth = AppProvider.of(context).auth;
    if (isLoaded == false) {
      userNameController.text = auth.userModel.name;
      emailController.text = auth.userModel.email;
      phoneController.text = auth.userModel.phone;

      _userController.editProfileModel.name = auth.userModel.name;
      _userController.editProfileModel.phone = auth.userModel.phone;

      isLoaded = true;
    }
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
                SharedWidgets.backButtonArrow(context),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Form(
                    key: editProfileFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Stack(
                            alignment: const Alignment(2.0, 1.5),
                            fit: StackFit.passthrough,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.redAccent,
//                          backgroundImage: AssetImage(FixedAssets.noImage),
                                  radius: 65,
                                  child: Center(
                                      child: Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: BoxDecoration(
                                              image: _userController.image ==
                                                      null
                                                  ? DecorationImage(
                                                      image: auth.userModel ==
                                                                  null ||
                                                              auth.userModel
                                                                      .image ==
                                                                  null ||
                                                              auth.userModel
                                                                      .image
                                                                      .trim() ==
                                                                  ""
                                                          ? AssetImage(
                                                              FixedAssets
                                                                  .noImage)
                                                          : NetworkImage(
                                                              ApiRoutes
                                                                      .public +
                                                                  auth.userModel
                                                                      .image),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : DecorationImage(
                                                      image: FileImage(
                                                          _userController
                                                              .image),
                                                      fit: BoxFit.cover,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(80.0),
                                              border: Border.all(
                                                color: Colors.redAccent,
                                                width: 5.0,
                                              ))))),
                              Container(
                                child: RaisedButton(
                                  color: Colors.redAccent,
                                  shape: CircleBorder(
                                      side:
                                          BorderSide(color: Colors.redAccent)),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _userController.getImage().then((value){
                                      refresh();
                                    });

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                              null,
                              null,
                              editProfileFormKey,
                              false,
                              context,
                              _userController
                                  .registerUserModel.validateUserName,
                              _userController.editProfileModel.name,
                              Icons.person,
                              9),
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
                              null,
                              null,
                              editProfileFormKey,
                              false,
                              context,
                              _userController.registerUserModel.validatePhone,
                              _userController.editProfileModel.phone,
                              Icons.phone,
                              10),
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
                            null,
                            null,
                            editProfileFormKey,
                            false,
                            context,
                            _userController.loginUserModel.validateEmail,
                            _userController.loginUserModel.email,
                            Icons.email,
                            6,
                            isEnabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: RaisedButton(
                            padding: EdgeInsets.only(
                                top: 6.0, bottom: 6.0, right: 20.0, left: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              "حفظ",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.red,
                            onPressed: () {
                              _userController.editProfileModel.name =
                                  userNameController.text;
                              _userController.editProfileModel.phone =
                                  phoneController.text;
                              print(_userController.editProfileModel.name +
                                  "  " +
                                  _userController.editProfileModel.phone);

                              _userController.editProfile(
                                  context, editProfileFormKey);
                            },
                          ),
                        ),
                        Center(
                          child: RaisedButton(
                            padding: EdgeInsets.only(
                                top: 6.0, bottom: 6.0, right: 20.0, left: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              "تغير كلمة السر",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.red,
                            onPressed: () {
//                              _userController.signInWithEmailAndPassword(
//                                  context, loginFormKey);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}
