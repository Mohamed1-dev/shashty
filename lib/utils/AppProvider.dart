import 'package:flutter/material.dart';

import 'Auth.dart';

class AppProvider extends InheritedWidget {
  final BaseAuth auth;
  final bool isConnected;
  AppProvider({Key key, Widget child, this.auth, this.isConnected})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider);
  }
}
