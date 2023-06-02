// GENERATED CODE - DO NOT MODIFY BY HAND

part of objects;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AsignHomeModel _$AsignHomeModelFromJson(Map<String, dynamic> json) =>
    AsignHomeModel(
      id: json['id'] as int,
      ah_reserve_date: json['ah_reserve_date'] as String,
      ah_agreement: json['ah_agreement'] as String,
      ah_reserve_recipt: json['ah_reserve_recipt'] as String,
      ah_remark: json['ah_remark'] as String,
      types: PaymentStatusModel.fromJson(json['types'] as Map<String, dynamic>),
      ah_down_payment: json['ah_down_payment'] as String,
      status: json['status'] as String,
      tower: TowerModel.fromJson(json['tower'] as Map<String, dynamic>),
      floor: FloorModel.fromJson(json['floor'] as Map<String, dynamic>),
      home: HomeModel.fromJson(json['home'] as Map<String, dynamic>),
      customer:
          CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$AsignHomeModelToJson(AsignHomeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ah_reserve_date': instance.ah_reserve_date,
      'ah_agreement': instance.ah_agreement,
      'ah_reserve_recipt': instance.ah_reserve_recipt,
      'ah_remark': instance.ah_remark,
      'types': instance.types,
      'ah_down_payment': instance.ah_down_payment,
      'status': instance.status,
      'tower': instance.tower,
      'floor': instance.floor,
      'home': instance.home,
      'customer': instance.customer,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

TowerModel _$TowerModelFromJson(Map<String, dynamic> json) => TowerModel(
      id: json['id'] as int,
      tower_name: json['tower_name'] as String,
      tower_location: json['tower_location'] as String,
      tower_image: json['tower_image'] as String,
      status: json['status'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$TowerModelToJson(TowerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tower_name': instance.tower_name,
      'tower_location': instance.tower_location,
      'tower_image': instance.tower_image,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

FloorModel _$FloorModelFromJson(Map<String, dynamic> json) => FloorModel(
      id: json['id'] as int,
      tower_id: json['tower_id'] as String,
      floor_number: json['floor_number'] as String,
      status: json['status'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$FloorModelToJson(FloorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tower_id': instance.tower_id,
      'floor_number': instance.floor_number,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      id: json['id'] as int,
      tower_id: json['tower_id'] as String,
      floor_id: json['floor_id'] as String,
      home_number: json['home_number'] as String,
      status: json['status'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'id': instance.id,
      'tower_id': instance.tower_id,
      'floor_id': instance.floor_id,
      'home_number': instance.home_number,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

InstallementModel _$InstallementModelFromJson(Map<String, dynamic> json) =>
    InstallementModel(
      id: json['id'] as int,
      inst_number: json['inst_number'] as String,
      inst_amount: (json['inst_amount'] as num).toDouble(),
      inst_remaining: (json['inst_remaining'] as num).toDouble(),
      inst_balance: (json['inst_balance'] as num).toDouble(),
      inst_pay_date: json['inst_pay_date'] as String,
      inst_pay_amount: (json['inst_pay_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$InstallementModelToJson(InstallementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inst_number': instance.inst_number,
      'inst_amount': instance.inst_amount,
      'inst_remaining': instance.inst_remaining,
      'inst_balance': instance.inst_balance,
      'inst_pay_date': instance.inst_pay_date,
      'inst_pay_amount': instance.inst_pay_amount,
    };

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

PaymentStatusModel _$PaymentStatusModelFromJson(Map<String, dynamic> json) =>
    PaymentStatusModel(
      id: json['id'] as int,
      ps_type: json['ps_type'] as String,
    );

Map<String, dynamic> _$PaymentStatusModelToJson(PaymentStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ps_type': instance.ps_type,
    };

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      id: json['id'] as int,
      cus_name: json['cus_name'] as String,
      cus_nic: json['cus_nic'] as String,
      cus_address: json['cus_address'] as String,
      cus_phone: json['cus_phone'] as String,
      cus_email: json['cus_email'] as String,
      cus_password: json['cus_password'] as String,
      cus_image: json['cus_image'] as String,
      cus_auth_token: json['cus_auth_token'] as String,
      cus_token: json['cus_token'] as String,
      role_id: json['role_id'] as String,
      status: json['status'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cus_name': instance.cus_name,
      'cus_nic': instance.cus_nic,
      'cus_address': instance.cus_address,
      'cus_phone': instance.cus_phone,
      'cus_email': instance.cus_email,
      'cus_password': instance.cus_password,
      'cus_image': instance.cus_image,
      'cus_auth_token': instance.cus_auth_token,
      'cus_token': instance.cus_token,
      'role_id': instance.role_id,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

SelectedCustomerModel _$SelectedCustomerModelFromJson(
        Map<String, dynamic> json) =>
    SelectedCustomerModel(
      id: json['id'] as int,
      cus_name: json['cus_name'] as String,
      cus_nic: json['cus_nic'] as String,
      cus_address: json['cus_address'] as String,
      cus_phone: json['cus_phone'] as String,
      cus_email: json['cus_email'] as String,
      cus_password: json['cus_password'] as String,
      cus_image: json['cus_image'] as String,
      cus_auth_token: json['cus_auth_token'] as String,
      cus_token: json['cus_token'] as String,
      role_id: json['role_id'] as String,
      status: json['status'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$SelectedCustomerModelToJson(
        SelectedCustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cus_name': instance.cus_name,
      'cus_nic': instance.cus_nic,
      'cus_address': instance.cus_address,
      'cus_phone': instance.cus_phone,
      'cus_email': instance.cus_email,
      'cus_password': instance.cus_password,
      'cus_image': instance.cus_image,
      'cus_auth_token': instance.cus_auth_token,
      'cus_token': instance.cus_token,
      'role_id': instance.role_id,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
