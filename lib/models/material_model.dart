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
  final String materialImage;
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
    required this.materialImage,
    required this.parentId,
  });

  /// ينشئ نسخة من JSON
  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      materialId: (json['MAT_ID'] as num).toInt(),
      materialNumber: json['MAT_NUMBER'] as String,
      materialName: json['MAT_NAME'] as String,
      materialCode: json['MAT_CODE'] as String,
      materialPrice1: (json['MAT_PRICE1'] as num).toDouble(),
      materialPrice3: (json['MAT_PRICE3'] as num).toDouble(),
      materialUnit2: json['MAT_UNIT2'] as String,
      materialUnit2Number: (json['MAT_UNIT2_NUM'] as num).toDouble(),
      materialUnit2Price3: (json['MAT_UNIT2_PRICE3'] as num).toDouble(),
      materialKind: (json['MAT_KIND'] as num).toInt(),
      materialUnitDefault: (json['mat_unit_default'] as num).toInt(),
      materialImage: json['mat_image'] as String,
      parentId: (json['PARENT_ID'] as num).toInt(),
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
      'MAT_UNIT2': materialUnit2,
      'MAT_UNIT2_NUM': materialUnit2Number.toString(),
      'MAT_UNIT2_PRICE3': materialUnit2Price3.toString(),
      'MAT_KIND': materialKind.toString(),
      'mat_unit_default':
          materialUnitDefault.toString(),
      'mat_image': materialImage,
      'PARENT_ID': parentId.toString(),
    };
  }
}
