part of 'objects.dart';

@JsonSerializable()
class FloorModel {
  late int id;
  late String tower_id;
  late String floor_number;
  late String status;
  late String created_at;
  late String updated_at;

  FloorModel({
    required this.id,
    required this.tower_id,
    required this.floor_number,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) =>
      _$FloorModelFromJson(json);

  Map<String, dynamic> toJson() => _$FloorModelToJson(this);
}
