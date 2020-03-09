import 'package:shashty_app/data/Models/HomeModel.dart';

import 'Repository.dart';

abstract class HomeRepository extends Repository {
  Future<HomeModel> getAllHomeCategory(String token);
}
