import 'package:shashty_app/data/Models/ShowRemindModel.dart';

import 'Repository.dart';

abstract class ReminderRepository extends Repository {
  Future<List<ShowRemindModel>> getAllReminder(String token);

  Future<bool> removeReminder(
      int showId, String userToken, bool isParentShow, DateTime startDate);
}
