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
      comId: json['COM_ID'],
      comName: json['COM_NAME'],
      comSerial: json['COM_SERIAL'],
      comCount: json['COM_COUNT'],
    );
  }
}
