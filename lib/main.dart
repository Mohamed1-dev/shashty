import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shashty_app/screens/MainFavouriteScreen.dart';
import 'package:shashty_app/screens/Show/ShowDetails/TeamShowScreen.dart';

import 'screens/EditProfileScreen.dart';
import 'screens/FavouriteScreen.dart';
import 'screens/LoginScreen.dart';
import 'screens/MainScreen.dart';
import 'screens/NotificationScreen.dart';
import 'screens/RegisterScreen.dart';
import 'screens/ReminderScreen.dart'; 
import 'screens/ResetPasswordScreen.dart'; 
import 'screens/SideMenuScreen.dart';
import 'screens/SplashScreen.dart';
import 'utils/AppProvider.dart';
import 'utils/Auth.dart';
import 'utils/FixedAssets.dart';

void main() {
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());}

class MyApp extends StatefulWidget {
  @override
  createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Auth auth;
  String _debugLabelString = "";
  String _emailAddress;
  String _externalUserId;
  bool _enableConsentButton = false;

  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
  bool _requireConsent = true;

  var _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool isConnectedToInternet = true;

  @override
  void initState() {
    auth = new Auth();
    initConnectivity();
    initPlatformState();

    this._connectivitySubscription = this
        ._connectivity
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      this._connectionStatus = result.toString();
      print(_connectionStatus);
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        print(this._connectionStatus);
        setState(() {
          _connectionStatus = result.toString();
          this.isConnectedToInternet = true;
          print(this.isConnectedToInternet);
        });
      } else {
        setState(() {
          _connectionStatus = result.toString();
          this.isConnectedToInternet = false;
          print(this.isConnectedToInternet);
        });
      }
    });

    super.initState();
  }

  Future<Null> initConnectivity() async {
    String connectionStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }


    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = connectionStatus;
    });
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);

    var settings = {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      this.setState(() {
        _debugLabelString =
            "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      this.setState(() {
        _debugLabelString =
            "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      this.setState(() {
        _debugLabelString =
            "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges changes) {
      print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared
        .init("72c5e245-ba56-4da3-a85c-a3acaacf0f90", iOSSettings: settings);
    await OneSignal.shared.consentGranted(true);
    await OneSignal.shared.setSubscription(true);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

    this.setState(() {
      _enableConsentButton = requiresConsent;
    });

    // Some examples of how to use In App Messaging public methods with OneSignal SDK
   // oneSignalInAppMessagingTriggerExamples();
  }


  handleRequestSignal() async {
    print("before");
    await OneSignal.shared.setRequiresUserPrivacyConsent(true);
    print("after");
    await OneSignal.shared.sendTag("userId", "015");
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
        auth: auth,
        isConnected: this.isConnectedToInternet,
        child: MaterialApp(
            title: 'Shashty',
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            routes: <String, WidgetBuilder>{
              "/Splash": (context) => SplashScreen(),
              "/ForgetPassword": (context) => ForgetPasswordScreen(),
              "/Login": (context) => LoginScreen(),
              "/Register": (context) => RegisterScreen(),
              "/Home": (context) => MainScreen(),
              "/MainFavouriteScreen": (context) => MainFavouriteScreen(),

              "/SideMenu": (context) => SideMenuScreen(),
              "/EditProfile": (context) => EditProfileScreen(),
              "/NotificationScreen": (context) => NotificationScreen(),
              "/FavouriteScreen": (context) => FavouriteScreen(),
              "/ReminderScreen": (context) => ReminderScreen(),
            },
            theme: ThemeData(fontFamily: FixedAssets.mainFont),
            builder: (BuildContext context, Widget child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Builder(
                  builder: (BuildContext context) {
                    return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: child);
                  },
                ),
              );
            }));
  }
}
