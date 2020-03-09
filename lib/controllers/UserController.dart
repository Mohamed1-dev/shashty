import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shashty_app/data/Models/EditProfileModel.dart';
import 'package:shashty_app/data/Models/LoginUserModel.dart';
import 'package:shashty_app/data/Models/RegisterUserModel.dart';
import 'package:shashty_app/data/Models/UserModel.dart';
import 'package:shashty_app/data/Models/UserModelWithToken.dart';
import 'package:shashty_app/data/services/UserService.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';

class UserController extends ControllerMVC {
  //to make single instance of class
  factory UserController() {
    if (_this == null) _this = UserController._();
    return _this;
  }

  static UserController _this;

  UserController._();

  static UserController get con => _this;

  UserService userService = UserService();
  String resetPasswordValue;
  Auth auth;
  RegisterUserModel registerUserModel = RegisterUserModel();
  LoginUserModel loginUserModel = LoginUserModel();
  EditProfileModel editProfileModel = EditProfileModel();

  bool isEditingProfile = false;
  File image;

  Future getImage() async {
    var _pickedImage = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 600, maxWidth: 600);

    //setState(() {
      if (_pickedImage != null) {
        editProfileModel.image = _pickedImage;
        image = _pickedImage;
      }
      refresh();
    //});
  }

  Future editProfile(context, key) async {
    auth = AppProvider.of(context).auth;
    SharedWidgets.loading(context);
    await userService
        .editProfile(editProfileModel, auth.userToken.toString())
        .then((response) async {
      print("code edit profile 2" + response.statusCode.toString());
      print("data edit profile 2" + response.data.toString());
      if (response.statusCode == 200) {
        auth.userModel = UserModel.fromJson(response.data);
        SharedWidgets.showToastMsg("تم التغير بنجاح", false);
        Navigator.pop(context);

//        TextFieldController.userPicture = response.data[0];

//        return response;
//        print(response.data[0]);
//        SharedWidget.showSnackBar(key, "تم الحفظ");
      } else {
        SharedWidgets.showToastMsg("حدث خطاء", true);
        return null;
//        print(response.statusCode.toString() + "status code profile iamge");
//        SharedWidget.showSnackBar(key, "خطأ فى تحميل الصوره");
      }
      return null;
    }).catchError((error) {
//      SharedWidget.showSnackBar(key, "خطأ فى تحميل الصوره");
//      print(error.toString() + "  errore    ");
    });

    Navigator.pop(context);
    refresh();
  }

  Future signInWithEmailAndPassword(
      BuildContext context, GlobalKey<FormState> loginFormKey) async {
    final form = loginFormKey.currentState;
    auth = AppProvider.of(context).auth;
    if (form.validate()) {
      form.save();
      SharedWidgets.loading(context);
      await userService
          .signInWithEmailAndPassword(loginUserModel)
          .then((response) async {
        Map<String, Object> body = json.decode(response.body);

        print("login body " + body.toString());
        if (response.statusCode == 200) {
          auth.userModelWithToken = UserModelWithToken.fromJson(body);
          auth.userModel = UserModel.fromJson(body['user']);
          auth.userToken = auth.userModelWithToken.accessToken;
          auth.saveUserToSharedPreferences();
          auth.isGuest = false;
           OneSignal.shared.setRequiresUserPrivacyConsent(true);
           OneSignal.shared.sendTag("userId", auth.userModel.id);
          Navigator.pop(context);

          Navigator.pushNamedAndRemoveUntil(
              context, "/Home", (Route<dynamic> route) => false);
        } else {
          Navigator.pop(context);

          SharedWidgets.showToastMsg(
              "البريد الالكتروني او كلمه المرور غير صحيحة", true);
        }
      });
    }
    refresh();
  }

  Future logout(BuildContext context) async {
    SharedWidgets.loading(context);

    auth = AppProvider.of(context).auth;
    await auth.getUserToSharedPreferences();
    await userService
        .logOut(auth.userToken.toString(), "")
        .then((response) async {
//      if (response == true) {
      auth.removeUserFromSharedPreferences();
       OneSignal.shared.deleteTag("userId");
      Navigator.pop(context);

      Navigator.pushNamedAndRemoveUntil(
          context, "/Login", (Route<dynamic> route) => true);
//      } else {
//        SharedWidgets.showToastMsg("تاكد من الانترنت", true);
//      }
    });

    refresh();
  }

  Future resetPassword(
      BuildContext context, GlobalKey<FormState> resetPasswordFormKey) async {
    final form = resetPasswordFormKey.currentState;

    if (form.validate()) {
      form.save();
      SharedWidgets.loading(context);
      await userService.resetPassword(resetPasswordValue).then((response) {
        Navigator.pop(context);
        if (response == null) {
          SharedWidgets.showToastMsg("تحقق من الانترنت", true);
        } else {
          if (response.statusCode == 200) {
            Navigator.pop(context);
            SharedWidgets.showToastMsg("تحقق من البريد الالكتروني", false);
          } else {
            SharedWidgets.showToastMsg("االبريد الاكتروني غير صحيح", true);
          }
        }
      });
    }
    refresh();
  }

  Future regNewUser(
      BuildContext context, GlobalKey<FormState> regFormKey) async {
    auth = AppProvider.of(context).auth;
    final form = regFormKey.currentState;

    if (form.validate()) {
      form.save();
      SharedWidgets.loading(context);
      await userService.regNewUser(registerUserModel).then((response) async {
        print("register response $response");
        Map<String, Object> body = json.decode(response.body);

        if (response.statusCode == 200) {
          auth.userModelWithToken = UserModelWithToken.fromJson(body);
          auth.userModel = UserModel.fromJson(body['user']);
          auth.userToken = auth.userModelWithToken.accessToken;
          auth.saveUserToSharedPreferences();
          auth.isGuest = false;
            OneSignal.shared.setRequiresUserPrivacyConsent(true);
            OneSignal.shared.sendTag("userId", auth.userModel.id);
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, "/Home", (Route<dynamic> route) => false);
        } else {
          Map error = body['error'];
          print(error.values.first.toString() + " value");

          SharedWidgets.showToastMsg(
              error.values.toList()[0][0].toString(), true);
          Navigator.pop(context);
        }
      });
    }
    refresh();
  }

  Future<bool> getCurrentUser(context) async {
    auth = AppProvider.of(context).auth;
    await auth.getUserToSharedPreferences();
    print("check token " + auth.userToken.toString());
    if (auth.userToken == null || auth.userToken == "") {
      print(auth.userToken.toString());
      return false;
    } else {
      return await userService.getCurrentUser(auth.userToken).then((response) {
        Map<String, Object> body = json.decode(response.body);

        if (body == null) {
          return false;
        } else {
          if (response.statusCode == 200) {
//            auth.userModelWithToken = UserModelWithToken.fromJson(body);
            auth.userModel = UserModel.fromJson(body);
            auth.isGuest = false;
//            auth.saveUserToSharedPreferences();
            return true;
          } else {
            return false;
          }
        }
      });
    }

    refresh();
  }

  Future socialLogin(BuildContext context, String typeSocialLogin) async {
//    SharedWidgets.loading(context);
    //SocialModel socialModel;

//    final form = TextFieldController.regformKey.currentState;
//    TextFieldController.regAutoValid = true;
//    if (form.validate()) {
//      form.save();
//      SharedWidget.onLoading(context);

    switch (typeSocialLogin) {
      case "facebook":
        {
          bool res = await userService.signInWithFacebook( );
//          completeSocial(context, res);
        }
        break;
      case "google":
        {
          print(typeSocialLogin + " so lgo");
          bool res = await userService.signInWithGoogle();
//          completeSocial(context, res);
        }
        break;
    }
  }
  Future socialSignUp(BuildContext context, String typeSocialLogin, String favouriteType, List<int> favouriteIds) async {
//    SharedWidgets.loading(context);
    //SocialModel socialModel;

//    final form = TextFieldController.regformKey.currentState;
//    TextFieldController.regAutoValid = true;
//    if (form.validate()) {
//      form.save();
//      SharedWidget.onLoading(context);

    switch (typeSocialLogin) {
      case "facebook":
        {
          bool res = await userService.signUpWithFacebook(favouriteType:favouriteType,favouritesIds: favouriteIds);
//          completeSocial(context, res);
        }
        break;
      case "google":
        {
          print(typeSocialLogin + " so lgo");
          bool res = await userService.signUpWithGoogle(favouriteType:favouriteType,favouritesIds: favouriteIds);
//          completeSocial(context, res);
        }
        break;
    }
  }

}
