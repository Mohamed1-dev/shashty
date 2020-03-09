// To parse this JSON data, do
//
//     final matchesModel = matchesModelFromJson(jsonString);

import 'dart:convert';

List<MatchesModel> matchesModelFromJson(String str) => List<MatchesModel>.from(json.decode(str).map((x) => MatchesModel.fromJson(x)));

String matchesModelToJson(List<MatchesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchesModel {
  int leagueId;
  bool isPenalties;
  dynamic leagueOrder;
  String leagueLogoInactive;
  String leagueLogoActive;
  int homePenalties;
  int awayPenalties;
  String leagueName;
  int matchId;
  int week;
  String weekName;
  DateTime matchDate;
  DateTime matchDateDay;
  int matchLevelId;
   MatchLevelName matchLevelName;
  dynamic stadiumId;
  dynamic stadiumName;
  dynamic leagueGroupId;
  dynamic leagueParentGroupId;
  dynamic leagueGroupName;
  int matchStatusId;
  MatchStatusName matchStatusName;
  int homeTeamId;
  String homeTeamName;
  String homeTeamLogo;
  String homeTeamSmallLogo;
  int awayTeamId;
  String awayTeamName;
  String awayTeamLogo;
  String awayTeamSmallLogo;
  int homeGoals;
  int awayGoals;
  int winningTeamId;
  WinningTeamShortCode winningTeamShortCode;
  int liveMinute;
  bool broadcastingChannelInfoAvailable;
  int numberOfMatchesForLeague;
  int userRemind;

  MatchesModel({
    this.leagueId,
    this.isPenalties,
    this.leagueOrder,
    this.leagueLogoInactive,
    this.leagueLogoActive,
    this.homePenalties,
    this.awayPenalties,
    this.leagueName,
    this.matchId,
    this.week,
    this.weekName,
    this.matchDate,
    this.matchDateDay,
    this.matchLevelId,
    this.matchLevelName,
    this.stadiumId,
    this.stadiumName,
    this.leagueGroupId,
    this.leagueParentGroupId,
    this.leagueGroupName,
    this.matchStatusId,
    this.matchStatusName,
    this.homeTeamId,
    this.homeTeamName,
    this.homeTeamLogo,
    this.homeTeamSmallLogo,
    this.awayTeamId,
    this.awayTeamName,
    this.awayTeamLogo,
    this.awayTeamSmallLogo,
    this.homeGoals,
    this.awayGoals,
    this.winningTeamId,
    this.winningTeamShortCode,
    this.liveMinute,
    this.broadcastingChannelInfoAvailable,
    this.numberOfMatchesForLeague,
    this.userRemind,
  });

  factory MatchesModel.fromJson(Map<String, dynamic> json) => MatchesModel(
    leagueId: json["LeagueId"],
    isPenalties: json["IsPenalties"] == null ? null : json["IsPenalties"],
    leagueOrder: json["LeagueOrder"],
    leagueLogoInactive: json["LeagueLogo_Inactive"],
    leagueLogoActive: json["LeagueLogo_Active"],
    homePenalties: json["HomePenalties"] == null ? null : json["HomePenalties"],
    awayPenalties: json["AwayPenalties"] == null ? null : json["AwayPenalties"],
    leagueName: json["LeagueName"],
    matchId: json["MatchId"],
    week: json["Week"],
    weekName: json["WeekName"],
    matchDate: DateTime.parse(json["MatchDate"]),
    matchDateDay: DateTime.parse(json["MatchDateDay"]),
    matchLevelId: json["MatchLevelId"],
    matchLevelName: matchLevelNameValues.map[json["MatchLevelName"]],
    stadiumId: json["StadiumId"],
    stadiumName: json["StadiumName"],
    leagueGroupId: json["LeagueGroupId"],
    leagueParentGroupId: json["LeagueParentGroupId"],
    leagueGroupName: json["LeagueGroupName"],
    matchStatusId: json["MatchStatusId"],
    matchStatusName: matchStatusNameValues.map[json["MatchStatusName"]],
    homeTeamId: json["HomeTeamId"],
    homeTeamName: json["HomeTeamName"],
    homeTeamLogo: json["HomeTeamLogo"],
    homeTeamSmallLogo: json["HomeTeamSmallLogo"],
    awayTeamId: json["AwayTeamId"],
    awayTeamName: json["AwayTeamName"],
    awayTeamLogo: json["AwayTeamLogo"],
    awayTeamSmallLogo: json["AwayTeamSmallLogo"],
    homeGoals: json["HomeGoals"],
    awayGoals: json["AwayGoals"],
    winningTeamId: json["WinningTeamId"],
    winningTeamShortCode: winningTeamShortCodeValues.map[json["WinningTeamShortCode"]],
    liveMinute: json["LiveMinute"],
    broadcastingChannelInfoAvailable: json["BroadcastingChannelInfoAvailable"],
    numberOfMatchesForLeague: json["NumberOfMatchesForLeague"],
    userRemind: json["userRemind"],
  );

  Map<String, dynamic> toJson() => {
    "LeagueId": leagueId,
    "IsPenalties": isPenalties == null ? null : isPenalties,
    "LeagueOrder": leagueOrder,
    "LeagueLogo_Inactive": leagueLogoInactive,
    "LeagueLogo_Active": leagueLogoActive,
    "HomePenalties": homePenalties == null ? null : homePenalties,
    "AwayPenalties": awayPenalties == null ? null : awayPenalties,
    "LeagueName": leagueName,
    "MatchId": matchId,
    "Week": week,
    "WeekName": weekName,
    "MatchDate": matchDate.toIso8601String(),
    "MatchDateDay": "${matchDateDay.year.toString().padLeft(4, '0')}-${matchDateDay.month.toString().padLeft(2, '0')}-${matchDateDay.day.toString().padLeft(2, '0')}",
    "MatchLevelId": matchLevelId,
    "MatchLevelName": matchLevelNameValues.reverse[matchLevelName],
    "StadiumId": stadiumId,
    "StadiumName": stadiumName,
    "LeagueGroupId": leagueGroupId,
    "LeagueParentGroupId": leagueParentGroupId,
    "LeagueGroupName": leagueGroupName,
    "MatchStatusId": matchStatusId,
    "MatchStatusName": matchStatusNameValues.reverse[matchStatusName],
    "HomeTeamId": homeTeamId,
    "HomeTeamName": homeTeamName,
    "HomeTeamLogo": homeTeamLogo,
    "HomeTeamSmallLogo": homeTeamSmallLogo,
    "AwayTeamId": awayTeamId,
    "AwayTeamName": awayTeamName,
    "AwayTeamLogo": awayTeamLogo,
    "AwayTeamSmallLogo": awayTeamSmallLogo,
    "HomeGoals": homeGoals,
    "AwayGoals": awayGoals,
    "WinningTeamId": winningTeamId,
    "WinningTeamShortCode": winningTeamShortCodeValues.reverse[winningTeamShortCode],
    "LiveMinute": liveMinute,
    "BroadcastingChannelInfoAvailable": broadcastingChannelInfoAvailable,
    "NumberOfMatchesForLeague": numberOfMatchesForLeague,
    "userRemind": userRemind,
  };
}

enum MatchLevelName { EMPTY, THE_16, THE_32 }

final matchLevelNameValues = EnumValues({
  "الدور الأول\u000d\n": MatchLevelName.EMPTY,
  "دور الـ 16": MatchLevelName.THE_16,
  "دور ال 32": MatchLevelName.THE_32
});

enum MatchStatusName { EMPTY }

final matchStatusNameValues = EnumValues({
  "انتهت": MatchStatusName.EMPTY
});

enum WinningTeamShortCode { D, H, A }

final winningTeamShortCodeValues = EnumValues({
  "A": WinningTeamShortCode.A,
  "D": WinningTeamShortCode.D,
  "H": WinningTeamShortCode.H
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
