class AccountModel {
  final int accNumber;
  final int? accID;
  final String accName;
  final String? accPhone;
  final String? accMobile;
  final String? accEmail;
  final String? accAddress;
  final int parentId;
  final int accKind;
  final int accRefrence;
  final int accSecurity;
  final dynamic catImage;
  final dynamic accTaxNo;
  final int curId;
  final dynamic pthId;
  final dynamic catId;

  AccountModel({
    this.accID,
    required this.accNumber,
    required this.accName,
    this.accPhone,
    this.accMobile,
    this.accEmail,
    this.accAddress,
    required this.parentId,
    required this.accKind,
    required this.accRefrence,
    this.accSecurity = 0,
    this.catImage,
    this.accTaxNo,
    this.curId = 0,
    this.pthId,
    this.catId,
  });
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      accID: int.parse(json['ACC_ID']),
      accNumber: int.tryParse(json['ACC_NUMBER']?.toString() ?? '0') ?? 0,
      accName: json['ACC_NAME'] ?? '',
      accPhone: json['ACC_PHONE'],
      accMobile: json['ACC_MOBILE'],
      accEmail: json['ACC_EMAIL'],
      accAddress: json['ACC_ADDRESS'],
      parentId: int.tryParse(json['PARENT_ID']?.toString() ?? '0') ?? 0,
      accKind: int.tryParse(json['ACC_KIND']?.toString() ?? '0') ?? 0,
      accRefrence: int.tryParse(json['ACC_REFRENCE']?.toString() ?? '0') ?? 0,
      accSecurity: int.tryParse(json['ACC_SECURITY']?.toString() ?? '0') ?? 0,
      catImage: json['CAT_IMAGE'],
      accTaxNo: json['ACC_TAX_NO'],
      curId: int.tryParse(json['cur_id']?.toString() ?? '0') ?? 0,
      pthId: json['pth_id'],
      catId: json['cat_ids'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'database_name': 'itechsy_test',
      'ACC_ID': accID.toString(),
      'ACC_NUMBER': accNumber.toString(),
      'ACC_NAME': accName,
      'ACC_PHONE': accPhone ?? '',
      'ACC_MOBILE': accMobile ?? '',
      'ACC_EMAIL': accEmail ?? '',
      'ACC_ADDRESS': accAddress ?? '',
      'PARENT_ID': parentId.toString(),
      'ACC_KIND': accKind.toString(),
      'ACC_REFRENCE': accRefrence.toString(),
      'ACC_SECURITY': accSecurity.toString(),
      'CAT_IMAGE': catImage?.toString() ?? '',
      'ACC_TAX_NO': accTaxNo?.toString() ?? '',
      'cur_id': curId.toString(),
      'cat_ids': catId?.toString() ?? '',
    };
  }
}
