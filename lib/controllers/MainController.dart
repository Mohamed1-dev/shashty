import 'package:mvc_pattern/mvc_pattern.dart';

class MainController extends ControllerMVC {
  //to make single instance of class
  factory MainController() {
    if (_this == null) _this = MainController._();
    return _this;
  }
  static MainController _this;

  MainController._();

  static MainController get con => _this;
  int get _currentTab => currentTab;
  int currentTab = 0;
//
//  List<Widget> screens = <Widget>[
//    Scaffold(body: Center(child: Text("Home"))),
//    Scaffold(body: Center(child: Text("Search"))),
//    Scaffold(body: Center(child: Text("Shop product"))),
//    Scaffold(body: Center(child: Text("Chat 24hr "))),
//    Scaffold(body: Center(child: Text("More"))),
//    Scaffold(body: Center(child: Text("More  0  "))),
//  ];
  bool checkIsSlected(index) {
    if (index == currentTab) {
      return true;
    } else
      return false;
  }

  void setCurrentTab(int index) {
    currentTab = index;
    setState(() {
      currentTab = index;
    });
    refresh();
  }
}
