import 'package:shashty_app/data/Models/CategoriesSearchModel.dart';
import 'package:shashty_app/data/Models/OtherShowModel.dart';

import 'Repository.dart';

abstract class SearchRepository extends Repository {
  Future<CategoriesSearchModel> getAllCategories(String token);
  Future<List<OtherShowModel>> getAllMovieResult(
      String word, DateTime date, int subCatId, String token);

  Future<List<OtherShowModel>> getAllProgramsResult(
      String word, DateTime date, int subCatId, String token);
}
