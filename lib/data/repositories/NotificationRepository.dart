import 'package:shashty_app/data/Models/NotificationModel.dart';

import 'Repository.dart';

abstract class NotificationRepository extends Repository {
  Future<NotificationModel> getAllNotifications(String token);
}
