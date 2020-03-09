import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/data/Models/ShowRemindModel.dart';
import 'package:shashty_app/data/services/ReminderService.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';

class ReminderController extends ControllerMVC {
  factory ReminderController() {
    if (_this == null) _this = ReminderController._();
    return _this;
  }
  static ReminderController _this;
  ReminderController._();
  static ReminderController get con => _this;

  ReminderService reminderService = ReminderService();
  List<ShowRemindModel> listShowRemindModel;
  bool isLoading = false;
  Future init(BuildContext context, String token) async {
    listShowRemindModel = null;
    isLoading = true;
    refresh();
    await getAllReminder(token);
    isLoading = false;
    refresh();
  }

  Future getAllReminder(String token) async {
    isLoading = true;
    refresh();
    listShowRemindModel = await reminderService.getAllReminder(token);

    isLoading = false;
    refresh();
  }

  Future<bool> removeReminder(int showId, String userToken, bool isParentShow,
      DateTime startDate, context) async {
    SharedWidgets.loading(context);
    bool res = await reminderService.removeReminder(
        showId, userToken, isParentShow, startDate);
    Navigator.pop(context);
    print(res.toString() + " aw value");

    return res;
  }
}
