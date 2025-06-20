class DebitModel {
  final int debId;
  final int voucherNumber;
  final int accId;
  final int accId2;
  final double debAmount;
  final int ty;
  final String debNote;
  final int curId;
  final DateTime debDate;

  DebitModel({
    required this.debId,
    required this.voucherNumber,
    required this.accId,
    required this.accId2,
    required this.debAmount,
    required this.ty,
    required this.debNote,
    required this.curId,
    required this.debDate,
  });

  factory DebitModel.fromJson(Map<String, dynamic> json) {
    return DebitModel(
      debId: int.tryParse(json['deb_id']?.toString() ?? '0') ?? 0,
      voucherNumber: int.tryParse(json['voucher_number']?.toString() ?? '0') ?? 0,
      accId: int.tryParse(json['acc_id']?.toString() ?? '0') ?? 0,
      accId2: int.tryParse(json['acc_id2']?.toString() ?? '0') ?? 0,
      debAmount: double.tryParse(json['deb_amount']?.toString() ?? '0.0') ?? 0.0,
      ty: int.tryParse(json['ty']?.toString() ?? '0') ?? 0,
      debNote: json['deb_note']?.toString() ?? '',
      curId: int.tryParse(json['cur_id']?.toString() ?? '0') ?? 0,
      debDate: DateTime.parse(json['deb_date']?.toString() ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'debId': debId,  // لا ترسله عند الإضافة لأنه تلقائي في DB
      'voucher_number': voucherNumber,
      'acc_id': accId,
      'acc_id2': accId2,
      'deb_amount': debAmount,
      'ty': ty,
      'deb_note': debNote,
      'cur_id': curId,
      'deb_date': debDate.toIso8601String().split('T')[0],  // "YYYY-MM-DD"
    };
  }
}
