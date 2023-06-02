part of 'objects.dart';

@JsonSerializable()
class TowerModel {
  late int id;
  late String tower_name;
  late String tower_location;
  late String tower_image;
  late String status;
  late String created_at;
  late String updated_at;

  TowerModel({
    required this.id,
    required this.tower_name,
    required this.tower_location,
    required this.tower_image,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory TowerModel.fromJson(Map<String, dynamic> json) =>
      _$TowerModelFromJson(json);

  Map<String, dynamic> toJson() => _$TowerModelToJson(this);
}
