import 'package:shashty_app/data/Models/FilterCategoryModel.dart';

import 'Repository.dart';

abstract class FiltterRepository extends Repository {
  Future<FilterCategoryModel> getFilterCategory(int id, String token);
  Future<FilterCategoryModel> getFilterCategoryNextPage(
      int id, int page, String token);
}
