part of 'objects.dart';

@JsonSerializable()
class CustomerModel {
  late int id;
  late String cus_name;
  late String cus_nic;
  late String cus_address;
  late String cus_phone;
  late String cus_email;
  late String cus_password;
  late String cus_image;
  late String cus_auth_token;
  late String cus_token;
  late String role_id;
  late String status;
  late String created_at;
  late String updated_at;

  CustomerModel({
    required this.id,
    required this.cus_name,
    required this.cus_nic,
    required this.cus_address,
    required this.cus_phone,
    required this.cus_email,
    required this.cus_password,
    required this.cus_image,
    required this.cus_auth_token,
    required this.cus_token,
    required this.role_id,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
