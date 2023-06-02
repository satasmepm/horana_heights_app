part of 'objects.dart';

@JsonSerializable()
class AsignHomeModel {
  late int id;
  late String ah_reserve_date;
  late String ah_agreement;
  late String ah_reserve_recipt;
  late String ah_remark;
  late PaymentStatusModel types;
  late String ah_down_payment;
  late String status;
  late TowerModel tower;
  late FloorModel floor;
  late HomeModel home;
  late CustomerModel customer;
  late String created_at;
  late String updated_at;

  AsignHomeModel({
    required this.id,
    required this.ah_reserve_date,
    required this.ah_agreement,
    required this.ah_reserve_recipt,
    required this.ah_remark,
    required this.types,
    required this.ah_down_payment,
    required this.status,
    required this.tower,
    required this.floor,
    required this.home,
    required this.customer,
    required this.created_at,
    required this.updated_at,
  });

  factory AsignHomeModel.fromJson(Map<String, dynamic> json) =>
      _$AsignHomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AsignHomeModelToJson(this);
}
