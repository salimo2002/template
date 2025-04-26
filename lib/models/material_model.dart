class MaterialModel {
  final int materialId;
  final String materialNumber;
  final String materialName;
  final String materialCode;
  final double materialPrice1;
  final double materialPrice3;
  final String materialUnit2;
  final double materialUnit2Number;
  final double materialUnit2Price3;
  final int materialKind;
  final int materialUnitDefault;
  final String maerialImage;
  final int parentId;

  MaterialModel({
    required this.materialId,
    required this.materialNumber,
    required this.materialName,
    required this.materialCode,
    required this.materialPrice1,
    required this.materialPrice3,
    required this.materialUnit2,
    required this.materialUnit2Number,
    required this.materialUnit2Price3,
    required this.materialKind,
    required this.materialUnitDefault,
    required this.maerialImage,
    required this.parentId,
  });
  factory MaterialModel.fromJson(json) {
    return MaterialModel(
      materialId: json['MAT_ID'],
      materialNumber: json['MAT_NUMBER'],
      materialName: json['MAT_NAME'],
      materialCode: json['MAT_CODE'],
      materialPrice1: json['MAT_PRICE1'],
      materialPrice3: json['MAT_PRICE3'],
      materialUnit2: json['MAT_UNIT2'],
      materialUnit2Number: json['MAT_UNIT2_NUM'],
      materialUnit2Price3: json['MAT_UNIT2_PRICE3'],
      materialKind: json['MAT_KIND'],
      materialUnitDefault: json['mat_unit_default'],
      maerialImage: json['mat_image'],
      parentId: json['PARENT_ID'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'MAT_ID': materialId,
      'MAT_NUMBER': materialNumber,
      'MAT_NAME': materialName,
      'MAT_CODE': materialCode,
      'MAT_PRICE1': materialPrice1,
      'MAT_PRICE3': materialPrice3,
      'MAT_UNIT2': materialUnit2,
      'MAT_UNIT2_NUM': materialUnit2Number,
      'MAT_UNIT2_PRICE3': materialUnit2Price3,
      'MAT_KIND': materialKind,
      'mat_unit_default': materialUnitDefault,
      'mat_image': maerialImage,
      'PARENT_ID': parentId,
    };
  }
}
