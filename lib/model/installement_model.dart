part of 'objects.dart';

@JsonSerializable()
class InstallementModel {
  late int id;
  late String inst_number;
  late double inst_amount;
  late double inst_remaining;
  late double inst_balance;
  late String inst_pay_date;
  late double inst_pay_amount;

  InstallementModel({
    required this.id,
    required this.inst_number,
    required this.inst_amount,
    required this.inst_remaining,
    required this.inst_balance,
    required this.inst_pay_date,
    required this.inst_pay_amount,
  });

  factory InstallementModel.fromJson(Map<String, dynamic> json) =>
      _$InstallementModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstallementModelToJson(this);
}
