class DebDetailsModel {
  final int debId;
  final int accId;
  final int accId2;
  final double detMaduin;
  final double detLoaner;
  final int curId;

  DebDetailsModel({
    required this.debId,
    required this.accId,
    required this.accId2,
    required this.detMaduin,
    required this.detLoaner,
    required this.curId,
  });
  factory DebDetailsModel.fromJson(json) {
    return DebDetailsModel(
      debId: json['deb_id'],
      accId: json['acc_id'],
      accId2: json['acc_id2'],
      detMaduin: json['det_maduin'],
      detLoaner: json['det_loaner'],
      curId: json['cur_id'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'deb_id': debId,
      'acc_id': accId,
      'acc_id2': accId2,
      'det_maduin': detMaduin,
      'det_loaner': detLoaner,
      'cur_id': curId,
    };
  }
}
