import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable(createFactory: false)
class SearchModel extends Equatable {
  final String? origin;
  @JsonKey(name: 'origin_lat')
  final String? originLat;
  @JsonKey(name: 'origin_lon')
  final String? originLon;
  final String? radius;
  final String destination;
  @JsonKey(includeToJson: true)
  final DateTime date;
  @JsonKey(toJson: _timeToJson, fromJson: _timeFromJson)
  final TimeOfDay time;

  //@JsonKey(includeFromJson: true, toJson: _dateTimeToJson)
  //final DateTime dateTime;

  const SearchModel({
    this.origin,
    this.originLat,
    this.originLon,
    this.radius,
    required this.destination,
    required this.date,
    required this.time,
  }); //: dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);

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
  List<Object?> get props =>
      [origin, originLat, originLon, radius, destination, date, time];
}

String _dateTimeToJson(DateTime dateTime) => dateTime.toIso8601String();

String _timeToJson(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

TimeOfDay _timeFromJson(String time) {
  final parts = time.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}
