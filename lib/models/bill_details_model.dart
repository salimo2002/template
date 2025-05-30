class BillDetailsModel {
  final int? detId;
  final int? bilId;
  final int? matId;
  final double? detQuantity;
  final double? detSinglePrice;
  final double? detPrice;
  final int strId;
  final double? detBouns; 

  BillDetailsModel({
    required this.detId,
    required this.bilId,
    required this.matId,
    required this.detQuantity,
    required this.detSinglePrice,
    required this.detPrice,
    required this.strId,
    required this.detBouns, 
  });

  factory BillDetailsModel.fromJson(Map<String, dynamic> json) {
    return BillDetailsModel(
      detId: int.tryParse(json['det_id'].toString()),
      bilId: int.tryParse(json['bil_id'].toString()),
      matId: int.tryParse(json['mat_id'].toString()),
      detQuantity: double.tryParse(json['det_quntity'].toString()),
      detSinglePrice: double.tryParse(json['det_single_price'].toString()),
      detPrice: double.tryParse(json['det_price'].toString()),
      strId: int.parse(json['str_id'].toString()),
      detBouns: double.tryParse(json['det_bouns'].toString()),
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
      'det_bouns': detBouns.toString(), 
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
      'det_bouns': detBouns, 
    };
  }
}
