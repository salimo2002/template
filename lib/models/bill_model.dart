class BillModel {
  final int? bilId;
  final int? accId;
  final String? bilNumber;
  final double? bilTotal;
  final double? bilDiscount;
  final double? bilExtra;
  final String? bilKind;
  final double? bilPayment;
  final double? bilNet;
  final int? payType;
  final DateTime? bilDate;
  final String? bilNote;

  BillModel({
    required this.bilId,
    required this.accId,
    required this.bilNumber,
    required this.bilTotal,
    required this.bilDiscount,
    required this.bilExtra,
    required this.bilKind,
    required this.bilPayment,
    required this.bilNet,
    required this.payType,
    required this.bilDate,
    required this.bilNote,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      bilId: int.parse(json['bil_id'].toString()),
      accId: int.parse(json['acc_id']),
      bilNumber: json['bil_number'],
      bilTotal: double.parse(json['bil_total']),
      bilDiscount: double.parse(json['bil_discount']),
      bilExtra: double.parse(json['bil_extra']),
      bilKind: json['bil_kind'],
      bilPayment: double.parse(json['bil_payment']),
      bilNet: double.parse(json['bil_net']),
      payType: int.parse(json['pay_type']),
      bilDate: DateTime.parse(json['BIL_DATE']),
      bilNote: json['BIL_NOTE'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'database_name': 'itechsy_test',
      'bil_id': bilId.toString(),
      'acc_id': accId.toString(),
      'bil_number': bilNumber!,
      'bil_total': bilTotal.toString(),
      'bil_discount': bilDiscount.toString(),
      'bil_extra': bilExtra.toString(),
      'bil_kind': bilKind!,
      'bil_payment': bilPayment.toString(),
      'bil_net': bilNet.toString(),
      'pay_type': payType.toString(),
      'BIL_DATE':
          bilDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'BIL_NOTE': bilNote ?? '',
    };
  }
}
