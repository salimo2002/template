class CompanyModel {
  final int comId;
  final String comName;
  final String comSerial;
  final int comCount;

  CompanyModel({
    required this.comId,
    required this.comName,
    required this.comSerial,
    required this.comCount,
  });
  factory CompanyModel.fromJson(json) {
    return CompanyModel(
      comId: json['com_id'],
      comName: json['com_name'],
      comSerial: json['com_serial'],
      comCount: json['com_count'],
    );
  }
}
