class MaterialModel {
  final int materialId;
  final String materialNumber;
  final String materialName;
  final String materialCode;
  final double materialPrice1;
  final double materialPrice3;
  final String materialUnit;
  final String materialUnit2;
  final double materialUnit2Number;
  final double materialUnit2Price3;
  final int materialKind;
  final int materialUnitDefault;
  final String materialImage;
  final int parentId;

  MaterialModel({
    required this.materialId,
    required this.materialNumber,
    required this.materialName,
    required this.materialCode,
    required this.materialPrice1,
    required this.materialPrice3,
    required this.materialUnit,
    required this.materialUnit2,
    required this.materialUnit2Number,
    required this.materialUnit2Price3,
    required this.materialKind,
    required this.materialUnitDefault,
    required this.materialImage,
    required this.parentId,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      materialId: int.parse(json['mat_id']),
      materialNumber: json['mat_number'],
      materialName: json['mat_name'],
      materialCode: json['mat_code'],
      materialPrice1: double.parse(json['mat_price1']),
      materialPrice3: double.parse(json['mat_price3']),
      materialUnit: json['mat_unit'],
      materialUnit2: json['mat_unit2'],
      materialUnit2Number: double.parse(json['mat_unit2_num']),
      materialUnit2Price3: double.parse(json['mat_unit2_price3']),
      materialKind: int.parse(json['mat_kind']),
      materialUnitDefault: int.parse(json['mat_unit_default']),
      materialImage: json['mat_image'],
      parentId: int.parse(json['parent_id']),
    );
  }
  Map<String, String> toMap() {
    return {
      'database_name': 'itechsy_test',
      'MAT_NUMBER': materialNumber,
      'MAT_NAME': materialName,
      'MAT_CODE': materialCode,
      'MAT_PRICE1': materialPrice1.toString(),
      'MAT_PRICE3': materialPrice3.toString(),
      'MAT_UNIT': materialUnit,
      'MAT_UNIT2': materialUnit2,
      'MAT_UNIT2_NUM': materialUnit2Number.toString(),
      'MAT_UNIT2_PRICE3': materialUnit2Price3.toString(),
      'MAT_KIND': materialKind.toString(),
      'mat_unit_default': materialUnitDefault.toString(),
      'mat_image': materialImage,
      'PARENT_ID': parentId.toString(),
    };
  }
}
