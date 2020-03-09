import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DioResponse;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shashty_app/data/Models/EditProfileModel.dart';
import 'package:shashty_app/data/Models/LoginUserModel.dart';
import 'package:shashty_app/data/Models/RegisterUserModel.dart';
import 'package:shashty_app/data/repositories/UserRepository.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';

class UserService extends UserRepository {
  @override
  Future<http.Response> signInWithEmailAndPassword(
      LoginUserModel loginUserModel) async {
    return await http
        .post(ApiRoutes.login,
            headers: {
              "Content-Type": "application/json",
            },
            body: json.encode({
              "email": loginUserModel.email,
              "password": loginUserModel.password
            }))
        .then((response) {
      Map<String, Object> body = json.decode(response.body);

      return response;
    });
  }

  @override
  Future<bool> signInWithFacebook( ) async {
//    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//    try {
    bool returnValue;
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin
        .logInWithReadPermissions(['email', 'public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          FacebookAccessToken myToken = result.accessToken;

          print(result.accessToken.toMap().toString() + " map");

//            AuthCredential credential =
//                FacebookAuthProvider.getCredential(accessToken: myToken.token);

          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${myToken.token}');
          final profile = json.decode(graphResponse.body);
          print(profile.toString() + " profile");
          print(profile['picture']['data']['url'].toString() + 'url');
          print(myToken.token);
          print(myToken.userId + " user id");
          print(myToken.toMap().toString());
          Map body = {
            "name": profile['name'],
            "email": profile['email'],
            "provider": "facebook",
            "provider_id": myToken.userId.toString(),
            "image": profile['picture']['data']['url']
          };

          print(body.toString());
//            FirebaseUser user =
//                await _firebaseAuth.signInWithCredential(credential);

//            print(user.uid + " uid");
           await http
              .post(
                ApiRoutes.socialLogin,
                body:  body
              )
              .timeout(Duration(seconds: 10))
              .then((response) {
            print(response.statusCode.toString() + " code");

            print(response.body.toString() + "body");
            if (response.statusCode == 200) {
//              SharedPreference.savedUserToken(response.body);
//              TextFieldController.token = json.decode(response.body)["token"];
//              // var jsonValue = json.encode(user);
//              TextFieldController.userMemberModel =
//                  UserMemberModel.fromJson(json.decode(response.body));
//              print(json.decode(response.body)["member"].toString().trim() +
//                  " phone123");
//              print(json
//                      .decode(response.body)["member"]['telephone']
//                      .toString()
//                      .trim() +
//                  " phone");
//              TextFieldController.phone = json
//                  .decode(response.body)["member"]['telephone']
//                  .toString()
//                  .trim();
//              print(TextFieldController.phone.toString() + " phone tttt");
//              UserModel user = UserModel();
//              print("test 1");
//              user.userName = json.decode(response.body)["member"]['email'];
//              print("test 2");
//              SharedPreference.saveUser(user);
//              print("test 3");
//              TextFieldController.userModel = user;
//              print("test 4");
//              MemberInfoService().getAllMemberInfo();
//              print("test 5");
//              print(response.body);
//              print("test 6");
              returnValue = true;
            } else
              returnValue = false;
          });
        } catch (e) {
          returnValue = false;
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("no");
        returnValue = false;
        break;
      case FacebookLoginStatus.error:
        print("error");
        returnValue = false;
        break;
    }
    return returnValue;
    //return false;
//    } catch (e) {
//      print(e);
//      print("error");
//      return null;
//    }
//    return null;
  }

  @override
  Future<bool> signInWithGoogle( ) async {
    //FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    print(" test");
    bool returnValue;
    //try {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
//    print(" so lgo123");

//    await _googleSignIn.signIn();

//    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//      print(" so lgo");
//      print(account.email + account.toString() + " aaa");
//      _currentUser = account;
//      _handleGetContact();
//    });
//    print(" so lgo122133");
//      AuthCredential credential;
//      FirebaseUser user;
//      String tokenUser;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    googleUser.authentication.then((googleAuth) async {
      print(googleAuth.toString() + " qwe");
    });
    print(googleUser.toString() + " dddd");
//        credential = GoogleAuthProvider.getCredential(
//            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
//        user = await _firebaseAuth.signInWithCredential(credential);
////        user.getIdToken().then((token) {
////          print(user.uid + " uid");
////          tokenUser = token;
////          print(" uid2 " + token);
////
////          print("laskdjakl");
////        });
//      });
//
    Map body = {
      "name": googleUser.displayName,
      "email": googleUser.email,
      "provider": "google",
      "image": googleUser.photoUrl.toString(),
      "provider_id": googleUser.id
    };
    print(body.toString() + "model");

//    return false;
    var response = await http
        .post(
          ApiRoutes.socialLogin,
          body: body
        )
        .timeout(Duration(seconds: 10))
        .then((response) {
      print(response.statusCode.toString() + " code");

      print(response.body.toString() + "body");
      if (response.statusCode == 200) {
//        SharedPreference.savedUserToken(response.body);
//        TextFieldController.token = json.decode(response.body)["token"];
//        // var jsonValue = json.encode(user);
//        TextFieldController.userMemberModel =
//            UserMemberModel.fromJson(json.decode(response.body));
//        print(json.decode(response.body)["member"].toString().trim() +
//            " phone123");
//        print(json
//                .decode(response.body)["member"]['telephone']
//                .toString()
//                .trim() +
//            " phone");
//        TextFieldController.phone =
//            json.decode(response.body)["member"]['telephone'].toString().trim();
//        print(TextFieldController.phone.toString() + " phone tttt");
//        UserModel user = UserModel();
//        print("test 1");
//        user.userName = json.decode(response.body)["member"]['email'];
//        print("test 2");
//        SharedPreference.saveUser(user);
//        print("test 3");
//        TextFieldController.userModel = user;
//        print("test 4");
//        MemberInfoService().getAllMemberInfo();
//        print("test 5");
//        print(response.body);
//        print("test 6");
        returnValue = true;
      } else
        returnValue = false;
    });

    return returnValue;
  }


  @override
  Future<bool> signUpWithFacebook({List<int> favouritesIds,String favouriteType}) async {
//    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//    try {
    bool returnValue;
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin
        .logInWithReadPermissions(['email', 'public_profile']);
    print("facebook result ${result.errorMessage}");
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          FacebookAccessToken myToken = result.accessToken;

          print(result.accessToken.toMap().toString() + " map");

//            AuthCredential credential =
//                FacebookAuthProvider.getCredential(accessToken: myToken.token);

          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${myToken.token}');
          final profile = json.decode(graphResponse.body);
          print(profile.toString() + " profile");
          print(profile['picture']['data']['url'].toString() + 'url');
          print(myToken.token);
          print(myToken.userId + " user id");
          print(myToken.toMap().toString());
          Map body = {
            "name": profile['name'],
            "email": profile['email'],
            "provider": "facebook",
            "provider_id": myToken.userId.toString(),
            "image": profile['picture']['data']['url']
          };
          for(int i=0;i<favouritesIds.length;i++){
            body.putIfAbsent("input[favourite_type][$i]", ()=> favouriteType);
            body.putIfAbsent("input[favourite_id][$i]", ()=> "${favouritesIds[i]}");

          }
          print(body.toString());
//            FirebaseUser user =
//                await _firebaseAuth.signInWithCredential(credential);

//            print(user.uid + " uid");
          await http
              .post(
              ApiRoutes.socialLogin,
              body:  body
          )
              .timeout(Duration(seconds: 10))
              .then((response) {
            print(response.statusCode.toString() + " code");

            print(response.body.toString() + "body");
            if (response.statusCode == 200) {
//              SharedPreference.savedUserToken(response.body);
//              TextFieldController.token = json.decode(response.body)["token"];
//              // var jsonValue = json.encode(user);
//              TextFieldController.userMemberModel =
//                  UserMemberModel.fromJson(json.decode(response.body));
//              print(json.decode(response.body)["member"].toString().trim() +
//                  " phone123");
//              print(json
//                      .decode(response.body)["member"]['telephone']
//                      .toString()
//                      .trim() +
//                  " phone");
//              TextFieldController.phone = json
//                  .decode(response.body)["member"]['telephone']
//                  .toString()
//                  .trim();
//              print(TextFieldController.phone.toString() + " phone tttt");
//              UserModel user = UserModel();
//              print("test 1");
//              user.userName = json.decode(response.body)["member"]['email'];
//              print("test 2");
//              SharedPreference.saveUser(user);
//              print("test 3");
//              TextFieldController.userModel = user;
//              print("test 4");
//              MemberInfoService().getAllMemberInfo();
//              print("test 5");
//              print(response.body);
//              print("test 6");
              returnValue = true;
            } else
              returnValue = false;
          });
        } catch (e) {
          returnValue = false;
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("no");
        returnValue = false;
        break;
      case FacebookLoginStatus.error:
        print("facebook error ${FacebookLoginStatus.error.index}");
        returnValue = false;
        break;
    }
    return returnValue;
    //return false;
//    } catch (e) {
//      print(e);
//      print("error");
//      return null;
//    }
//    return null;
  }

  @override
  Future<bool> signUpWithGoogle( {List<int> favouritesIds,String favouriteType}) async {
    //FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    print(" test");
    bool returnValue;
    //try {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
//    print(" so lgo123");

//    await _googleSignIn.signIn();

//    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//      print(" so lgo");
//      print(account.email + account.toString() + " aaa");
//      _currentUser = account;
//      _handleGetContact();
//    });
//    print(" so lgo122133");
//      AuthCredential credential;
//      FirebaseUser user;
//      String tokenUser;
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    googleUser.authentication.then((googleAuth) async {
      print(googleAuth.toString() + " qwe");
    });
    print(googleUser.toString() + " dddd");
//        credential = GoogleAuthProvider.getCredential(
//            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
//        user = await _firebaseAuth.signInWithCredential(credential);
////        user.getIdToken().then((token) {
////          print(user.uid + " uid");
////          tokenUser = token;
////          print(" uid2 " + token);
////
////          print("laskdjakl");
////        });
//      });
//
    Map body = {
      "name": googleUser.displayName,
      "email": googleUser.email,
      "provider": "google",
      "image": googleUser.photoUrl.toString(),
      "provider_id": googleUser.id
    };
    print(body.toString() + "model");
    for(int i=0;i<favouritesIds.length;i++){
      body.putIfAbsent("input[favourite_type][$i]", ()=> favouriteType);
      body.putIfAbsent("input[favourite_id][$i]", ()=> "${favouritesIds[i]}");

    }
//    return false;
    var response = await http
        .post(
        ApiRoutes.socialLogin,
        body: body
    )
        .timeout(Duration(seconds: 10))
        .then((response) {
      print(response.statusCode.toString() + " code");

      print(response.body.toString() + "body");
      if (response.statusCode == 200) {
//        SharedPreference.savedUserToken(response.body);
//        TextFieldController.token = json.decode(response.body)["token"];
//        // var jsonValue = json.encode(user);
//        TextFieldController.userMemberModel =
//            UserMemberModel.fromJson(json.decode(response.body));
//        print(json.decode(response.body)["member"].toString().trim() +
//            " phone123");
//        print(json
//                .decode(response.body)["member"]['telephone']
//                .toString()
//                .trim() +
//            " phone");
//        TextFieldController.phone =
//            json.decode(response.body)["member"]['telephone'].toString().trim();
//        print(TextFieldController.phone.toString() + " phone tttt");
//        UserModel user = UserModel();
//        print("test 1");
//        user.userName = json.decode(response.body)["member"]['email'];
//        print("test 2");
//        SharedPreference.saveUser(user);
//        print("test 3");
//        TextFieldController.userModel = user;
//        print("test 4");
//        MemberInfoService().getAllMemberInfo();
//        print("test 5");
//        print(response.body);
//        print("test 6");
        returnValue = true;
      } else
        returnValue = false;
    });

    return returnValue;
  }



  @override
  Future<http.Response> regNewUser(RegisterUserModel registerUserModel) async {
    var model = {
      "email": registerUserModel.email.trim(),
      "name": registerUserModel.name.trim(),
      "password": registerUserModel.password,
      "phone": registerUserModel.phone.trim(),
      "token_id": registerUserModel.password,
    };
    for(int i=0;i<registerUserModel.favouritesIds.length;i++){
      model.putIfAbsent("input[favourite_type][$i]", ()=> registerUserModel.favouriteType);
      model.putIfAbsent("input[favourite_id][$i]", ()=> "${registerUserModel.favouritesIds[i]}");

    }
    print(ApiRoutes.register);
    print(model.toString());
    try {
      return await http
          .post(ApiRoutes.register,
          body: model)
          .then((response) {
        print("sataus code reister: " + response.statusCode.toString());

        print("sataus body reister: " + response.body.toString());
        Map<String, Object> body = json.decode(response.body);
        return response;
      });
    }catch(e){
      print("catch register error ${e.toString()}");
    }
  }

  @override
  Future<http.Response> getCurrentUser(String token) async {
    var model = {
      "token": token,
    };
    print(ApiRoutes.checkToken);
    print(model.toString());
    return await http.post(
      ApiRoutes.checkToken,
      headers: {
        "Authorization": token,
//        "Content-Type": "application/json",
      },
    ).then((response) {
      print("status code check token " + response.statusCode.toString());
      Map<String, Object> body = json.decode(response.body);
      print("body " + body.toString());
      return response;
    });
  }

  @override
  Future<bool> logOut(String token, String fireBaseToken) async {
    var model = {
      "FirebaseToken": fireBaseToken,
    };
    print(ApiRoutes.checkToken);
    print(model.toString());
    return await http.post(
      ApiRoutes.logout, //+ "/$fireBaseToken",
      headers: {
        "Authorization": token,
//        "Content-Type": "application/json",
      },
//            body: json.encode(model)
    ).then((response) {
      return true;
    });
  }

  @override
  Future<http.Response> resetPassword(String email) async {
    return await http
        .post(ApiRoutes.sendCodeResetPassword, //+ "/$fireBaseToken",
            headers: {
//              "Content-Type": "application/json",
        }, body: {
      "email": email
    }).then((response) {
      try {
        Map<String, Object> body = json.decode(response.body);
        print("body rest Password" + body.toString());
        return response;
      } catch (Exception) {
        return null;
      }
    });
  }

  @override
  Future<DioResponse.Response<dynamic>> editProfile(
      EditProfileModel editProfileModel, token) async {
    print(editProfileModel.phone.toString());
    print(editProfileModel.name.toString());
    Dio dio = new Dio();
    FormData aa;
    if (editProfileModel.image != null) {
      aa = FormData.from({
        "image": new UploadFileInfo(editProfileModel.image, "upload1.jpg"),
        "phone": editProfileModel.phone,
        "name": editProfileModel.name
      });
    } else {
      aa = FormData.from(
          {"phone": editProfileModel.phone, "name": editProfileModel.name});
    }

    return await dio
        .post(ApiRoutes.editProfile,
            data: aa,
            options: Options(
              headers: {"Authorization": token},
            ))
        .catchError((s) {})
        .then((response) {
      print("code edit profile" + response.statusCode.toString());
      print("data edit profile" + response.data.toString());
      try {
//        Map<String, Object> body = json.decode(response.data);
//        print("body edit profile" + body.toString());
        return response;
      } catch (Exception) {
        print("error");
        return null;
      }
    });
  }
}
