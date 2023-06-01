import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable(createFactory: false)
class SearchModel {
  final String? origin;
  @JsonKey(name: 'origin_lat')
  final String? originLat;
  @JsonKey(name: 'origin_lon')
  final String? originLon;
  final String destination;
  @JsonKey(includeToJson: false)
  final DateTime date;
  @JsonKey(includeToJson: false, fromJson: _timeFromJson)
  final TimeOfDay time;
  @JsonKey(includeFromJson: true, toJson: _dateTimeToJson)
  final DateTime dateTime;


  SearchModel({
    this.origin,
    this.originLat,
    this.originLon,
    required this.destination,
    required this.date,
    required this.time,
  }): dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);

  factory SearchModel.fromForm(Map<String, dynamic> json) => SearchModel(
    origin: json['origin'] as String?,
    originLat: json['origin_lat'] as String?,
    originLon: json['origin_lon'] as String?,
    destination: json['destination'] as String,
    date: json['date'] as DateTime,
    time: json['time'] as TimeOfDay,
  );

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchModel &&
          runtimeType == other.runtimeType &&
          origin == other.origin &&
          originLat == other.originLat &&
          originLon == other.originLon &&
          destination == other.destination &&
          date == other.date &&
          time == other.time &&
          dateTime == other.dateTime;

  @override
  int get hashCode =>
      origin.hashCode ^
      originLat.hashCode ^
      originLon.hashCode ^
      destination.hashCode ^
      date.hashCode ^
      time.hashCode ^
      dateTime.hashCode;
}

String _dateTimeToJson(DateTime dateTime) => dateTime.toIso8601String();

TimeOfDay _timeFromJson(String time) {
  final parts = time.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}
