class BillDetailModel {
  final int detId;
  final int bilId;
  final int matId;
  final double detQuantity;
  final double detSinglePrice;
  final double detPrice;
  final int strId;

  BillDetailModel({
    required this.detId,
    required this.bilId,
    required this.matId,
    required this.detQuantity,
    required this.detSinglePrice,
    required this.detPrice,
    required this.strId,
  });

  factory BillDetailModel.fromJson(Map<String, dynamic> json) {
    return BillDetailModel(
      detId: int.parse(json['det_id'].toString()),
      bilId: int.parse(json['bil_id'].toString()),
      matId: int.parse(json['mat_id'].toString()),
      detQuantity: double.parse(json['det_quntity'].toString()),
      detSinglePrice: double.parse(json['det_single_price'].toString()),
      detPrice: double.parse(json['det_price'].toString()),
      strId: int.parse(json['str_id'].toString()),
    );
  }

  Map<String, String> toMap() {
    return {
      'det_id': detId.toString(),
      'bil_id': bilId.toString(),
      'mat_id': matId.toString(),
      'det_quntity': detQuantity.toString(),
      'det_single_price': detSinglePrice.toString(),
      'det_price': detPrice.toString(),
      'str_id': strId.toString(),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'det_id': detId,
      'bil_id': bilId,
      'mat_id': matId,
      'det_quntity': detQuantity,
      'det_single_price': detSinglePrice,
      'det_price': detPrice,
      'str_id': strId, 
    };
  }
}
