class PaymentModel {
  late int id;
  late String pd_inst_number;
  late String pd_collection_date;
  late String pd_amount;
  late String pd_recipt;

  late String tower_id;
  late String floor_id;
  late String home_id;
  late String cus_id;
  late String status;
  late String created_at;
  late String updated_at;

  PaymentModel(
    this.id,
    this.pd_inst_number,
    this.pd_collection_date,
    this.pd_amount,
    this.pd_recipt,
    this.tower_id,
    this.floor_id,
    this.home_id,
    this.cus_id,
    this.status,
    this.created_at,
    this.updated_at,
  );

  PaymentModel.fromJson(map) {
    id = map['id'];
    pd_inst_number = map['pd_inst_number'];
    pd_collection_date = map['pd_collection_date'];
    pd_amount = map['pd_amount'];
    pd_recipt = map['pd_recipt'];

    tower_id = map['tower_id'];
    floor_id = map['floor_id'];
    home_id = map['home_id'];
    cus_id = map['cus_id'];
    status = map['status'];
    created_at = map['created_at'];
    updated_at = map['updated_at'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pr_date': pd_inst_number,
      'pd_collection_date': pd_collection_date,
      'pd_amount': pd_amount,
      'pd_recipt': pd_recipt,
      'tower_id': tower_id,
      'floor_id': floor_id,
      'home_id': home_id,
      'cus_id': cus_id,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}
