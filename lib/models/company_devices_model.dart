class CompanyDevicesModel {
  final int comDevId;
  final int comId;
  final String devImei;

  CompanyDevicesModel({
    required this.comDevId,
    required this.comId,
    required this.devImei,
  });
  factory CompanyDevicesModel.fromJson(json) {
    return CompanyDevicesModel(
      comDevId: json['com_dev_id'],
      comId: json['com_id'],
      devImei: json['dev_imei'],
    );
  }
  Map<String, dynamic> toMap() {
    return {'com_dev_id': comDevId, 'com_id': comId, 'dev_imei': devImei};
  }
}
