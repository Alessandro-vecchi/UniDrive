import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  final String name;
  final String surname;
  @JsonKey(name: 'timestamp')
  final DateTime date;
  final double rating;
  @JsonKey(name: 'body')
  final String reviewBody;

  const Review({
    required this.name,
    required this.surname,
    required this.date,
    required this.rating,
    required this.reviewBody,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
