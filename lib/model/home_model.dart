part of 'objects.dart';

@JsonSerializable()
class HomeModel {
  late int id;
  late String tower_id;
  late String floor_id;
  late String home_number;
  late String status;
  late String created_at;
  late String updated_at;

  HomeModel({
    required this.id,
    required this.tower_id,
    required this.floor_id,
    required this.home_number,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}
