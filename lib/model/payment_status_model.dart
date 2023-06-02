part of 'objects.dart';

@JsonSerializable()
class PaymentStatusModel {
  late int id;
  late String ps_type;

  PaymentStatusModel({
    required this.id,
    required this.ps_type,
  });

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentStatusModelToJson(this);
}
