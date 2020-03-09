import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/data/Models/NotificationModel.dart';
import 'package:shashty_app/data/services/NotificationService.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';

class NotificationController extends ControllerMVC {
  factory NotificationController() {
    if (_this == null) _this = NotificationController._();
    return _this;
  }
  static NotificationController _this;
  NotificationController._();

  NotificationService notificationService = NotificationService();
  NotificationModel notificationModel;
  bool isLoading = false;
  Future init(BuildContext context, String token) async {
    notificationModel = null;
    isLoading = true;
    refresh();
    await getAllNotification(token);
    isLoading = false;
    refresh();
  }

  Future getAllNotification(String token) async {
    notificationModel = await notificationService.getAllNotifications(token);
    isLoading = false;
    refresh();
  }

  Future<bool> removeNotification(String token, context, bool isAll,
      {int notificationID = 0}) async {
    SharedWidgets.loading(context);
    bool res;
    if (isAll) {
      res = await notificationService.removeNotifications(token, isAll);
    } else {
      res = await notificationService.removeNotifications(token, isAll,
          notificationID: notificationID);
    }
    Navigator.pop(context);
    return res;
  }

  Future<bool> readNotification(String token, context, bool isAll,
      {int notificationID = 0}) async {
    SharedWidgets.loading(context);
    bool res;
    if (isAll) {
      res = await notificationService.readNotifications(token, isAll);
    } else {
      res = await notificationService.readNotifications(token, isAll,
          notificationID: notificationID);
    }
    Navigator.pop(context);
    return res;
  }

  static NotificationController get con => _this;
}
