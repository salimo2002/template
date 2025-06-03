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
  factory DebitModel.fromJson(json) {
    return DebitModel(
      debId: json['deb_id'],
      voucherNumber: json['voucher_number'],
      accId: json['acc_id'],
      accId2: json['acc_id2'],
      debAmount: json['deb_amount'],
      ty: json['ty'],
      debNote: json['deb_note'],
      curId: json['cur_id'],
      debDate: json['deb_date'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'deb_id': debId,
      'voucher_number': voucherNumber,
      'acc_id': accId,
      'acc_id2': accId2,
      'deb_amount': debAmount,
      'ty': ty,
      'deb_note': debNote,
      'cur_id': curId,
      'deb_date': debDate,
    };
  }
}
