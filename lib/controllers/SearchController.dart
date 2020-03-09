import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/data/Models/CategoriesSearchModel.dart';
import 'package:shashty_app/data/Models/OtherShowModel.dart';
import 'package:shashty_app/data/services/SearchService.dart';

class SearchController extends ControllerMVC {
  factory SearchController() {
    if (_this == null) _this = SearchController._();
    return _this;
  }
  static SearchController _this;
  SearchController._();

  SearchService searchService = SearchService();
  CategoriesSearchModel categoriesSearchModel;
  bool isLoading = false;
  List<OtherShowModel> listOtherShowModel;

  Future init(String token) async {
    isLoading = true;
    refresh();
    await getAllResult(token);
    isLoading = false;
    refresh();
  }

  Future getAllResult(String token) async {
    categoriesSearchModel = await searchService.getAllCategories(token);
    isLoading = false;
    refresh();
  }

  Future getAllMovieResult(
      word, DateTime date, int subCatId, String token) async {
    isLoading = true;
    refresh();
    listOtherShowModel =
        await searchService.getAllMovieResult(word, date, subCatId, token);
    isLoading = false;
    refresh();
    isLoading = false;
    refresh();
  }

  Future getAllProgramsResult(
      word, DateTime date, int subCatId, String token) async {
    isLoading = true;
    refresh();
    listOtherShowModel =
        await searchService.getAllProgramsResult(word, date, subCatId, token);
    isLoading = false;
    refresh();
    isLoading = false;
    refresh();
  }

  Future getAllSeriesResult(
      word, DateTime date, int subCatId, String token) async {
    isLoading = true;
    refresh();
    listOtherShowModel =
        await searchService.getAllSeriesResult(word, date, subCatId, token);
    isLoading = false;
    refresh();
    isLoading = false;
    refresh();
  }

  Future getAllPersonsResult(word, int subCatId, String token) async {
    isLoading = true;
    refresh();
    listOtherShowModel =
        await searchService.getAllPersonsResult(word, subCatId, token);
    isLoading = false;
    refresh();
    isLoading = false;
    refresh();
  }

  Future getAllChannelsResult(word, int subCatId, String token) async {
    isLoading = true;
    refresh();
    listOtherShowModel =
        await searchService.getAllChannelsResult(word, subCatId, token);
    isLoading = false;
    refresh();
    isLoading = false;
    refresh();
  }

  static SearchController get con => _this;
}
