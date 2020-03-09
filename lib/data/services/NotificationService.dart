import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shashty_app/data/Models/NotificationModel.dart';
import 'package:shashty_app/data/repositories/NotificationRepository.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';

class NotificationService extends NotificationRepository {
  @override
  Future<NotificationModel> getAllNotifications(String token) async {
    return await http.get(
      ApiRoutes.notification,
      headers: {"Authorization": token.toString()},
    ).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        return NotificationModel.fromJson(jsonValue);
      } else
        return NotificationModel();
    });
  }

  Future<bool> removeNotifications(String token, bool isAll,
      {int notificationID = 0}) async {
    return await http
        .post(
      ApiRoutes.removeNotification,
      headers: {"Authorization": token.toString()},
      body: isAll ? {} : {"notification_id": notificationID.toString()},
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        return true;
      } else
        return false;
    });
  }

  Future<bool> readNotifications(String token, bool isAll,
      {int notificationID = 0}) async {
    return await http
        .post(
      ApiRoutes.readNotification,
      headers: {"Authorization": token.toString()},
      body: isAll ? {} : {"notification_id": notificationID.toString()},
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);

        return true;
      } else
        return false;
    });
  }
}
