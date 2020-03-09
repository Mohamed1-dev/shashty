import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shashty_app/data/Models/ShowRemindModel.dart';
import 'package:shashty_app/data/repositories/ReminderRepository.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';

class ReminderService extends ReminderRepository {
  @override
  Future<List<ShowRemindModel>> getAllReminder(String token) async {
    return await http.get(ApiRoutes.reminder, headers: {
      "Authorization": token,
    }).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print(jsonValue.toString());
        return List<ShowRemindModel>.from(
            json.decode(response.body).map((x) => ShowRemindModel.fromJson(x)));
      } else {
        return List<ShowRemindModel>();
      }
    });
  }

  @override
  Future<bool> removeReminder(int showId, String userToken, bool isParentShow,
      DateTime startDate) async {
    String remindType;
    if(isParentShow==null){
      remindType = "team";

    }else {
        remindType = "shows";
    }
    print(ApiRoutes.reminder +
        "/" +
        showId.toString() +
        "?kind=$remindType&start_date=" +
        startDate.year.toString() +
        "/" +
        startDate.month.toString() +
        "/" +
        startDate.day.toString() +
        " " +
        startDate.hour.toString() +
        ":" +
        startDate.minute.toString() +
        ":" +
        startDate.second.toString());

    print(userToken);

    return await http.delete(
        ApiRoutes.reminder +
            "/" +
            showId.toString() +
            "?kind=$remindType&start_date=" +
            startDate.year.toString() +
            "/" +
            startDate.month.toString() +
            "/" +
            startDate.day.toString() +
            " " +
            startDate.hour.toString() +
            ":" +
            startDate.minute.toString() +
            ":" +
            startDate.second.toString(),
        headers: {"Authorization": userToken}).then((response) {
      if (response.statusCode == 200) {
        var jsonValue = json.decode(response.body);
        print("reminder removed ");

        return true;
      } else {
        return false;
      }
    });
  }
}
