import 'package:shashty_app/data/Models/ChannelOrPersonModel.dart';
import 'package:shashty_app/data/Models/ChannelShowModel.dart';
import 'package:shashty_app/data/Models/MactchesModel.dart';
import 'package:shashty_app/data/Models/MovieShowModel.dart';
import 'package:shashty_app/data/Models/OtherShowModel.dart';
import 'package:shashty_app/data/Models/PersonShowModel.dart';
import 'package:shashty_app/data/Models/ProgramOrSeriesShowModel.dart';

import 'Repository.dart';

abstract class ShowRepository extends Repository {
  Future<ChannelOrPersonModel> getAllChannelsOrPersons(
      String token, bool isChannel);
  Future<List<OtherShowModel>> getOtherShow(int showValue, String token);
  Future<ProgramOrSeriesShowModel> getProgramOrSeriesShowModel(
      int programOrSeriesShowModelId, bool isProgram, String token);

  Future<MovieShowModel> getMovieShowModel(int showID, String token);
  Future<PersonShowModel> getPersonShowModel(int showID, String token);
  Future<ChannelShowModel> getChannelShowModel(int showID, String token,String  dateDay);
//  Future<List<MatchesModel>> getTeamShowModel(int showID, String token,String  dateDay ,int teamId);
}
