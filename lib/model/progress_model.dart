class ProgressModel {
  late int id;
  late String pr_date;
  late String pr_image;
  late String pr_remark;

  late String tower_id;
  late String floor_id;
  late String home_id;
  late String status;
  late String created_at;
  late String updated_at;

  ProgressModel(
    this.id,
    this.pr_date,
    this.pr_image,
    this.pr_remark,
    this.tower_id,
    this.floor_id,
    this.home_id,
    this.status,
    this.created_at,
    this.updated_at,
  );

  ProgressModel.fromJson(map) {
    id = map['id'];
    pr_date = map['pr_date'];
    pr_image = map['pr_image'];
    pr_remark = map['pr_remark'];

    tower_id = map['tower_id'];
    floor_id = map['floor_id'];
    home_id = map['home_id'];
    status = map['status'];
    created_at = map['created_at'];
    updated_at = map['updated_at'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pr_date': pr_date,
      'pr_image': pr_image,
      'pr_remark': pr_remark,
      'tower_id': tower_id,
      'floor_id': floor_id,
      'home_id': home_id,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}
