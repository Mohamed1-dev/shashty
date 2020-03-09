 //
//     final showTimeModel = showTimeModelFromJson(jsonString);

import 'dart:convert';

List<ShowTimeModel> showTimeModelFromJson(String str) => List<ShowTimeModel>.from(json.decode(str).map((x) => ShowTimeModel.fromJson(x)));

String showTimeModelToJson(List<ShowTimeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowTimeModel {
int id;
String name;
String image;
List<ShowTime> showTime;

ShowTimeModel({
this.id,
this.name,
this.image,
this.showTime,
});

factory ShowTimeModel.fromJson(Map<String, dynamic> json) => ShowTimeModel(
id: json["id"],
name: json["name"],
image: json["image"],
showTime: List<ShowTime>.from(json["show_time"].map((x) => ShowTime.fromJson(x))),
);

Map<String, dynamic> toJson() => {
"id": id,
"name": name,
"image": image,
"show_time": List<dynamic>.from(showTime.map((x) => x.toJson())),
};
}

class ShowTime {
int id;
DateTime startDate;
DateTime endDate;
int showId;
int userRemind;
Pivot pivot;

ShowTime({
this.id,
this.startDate,
this.endDate,
this.showId,
this.userRemind,
this.pivot,
});

factory ShowTime.fromJson(Map<String, dynamic> json) => ShowTime(
id: json["id"],
startDate: DateTime.parse(json["start_date"]),
endDate: DateTime.parse(json["end_date"]),
showId: json["show_id"],
userRemind: json["userRemind"],
pivot: Pivot.fromJson(json["pivot"]),
);

Map<String, dynamic> toJson() => {
"id": id,
"start_date": startDate.toIso8601String(),
"end_date": endDate.toIso8601String(),
"show_id": showId,
"userRemind": userRemind,
"pivot": pivot.toJson(),
};
}

class Pivot {
int channelId;
int showTimeId;

Pivot({
this.channelId,
this.showTimeId,
});

factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
channelId: json["channel_id"],
showTimeId: json["show_time_id"],
);

Map<String, dynamic> toJson() => {
"channel_id": channelId,
"show_time_id": showTimeId,
};
}
