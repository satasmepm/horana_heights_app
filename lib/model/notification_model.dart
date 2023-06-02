part of 'objects.dart';

@JsonSerializable()
class NotificationModel {
  late int id;
  late String title;
  late String description;
  late String type;
  late String status;
  late String created_at;
  late String updated_at;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
