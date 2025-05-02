class CategoryModel {
  final int matId; 
  final String matName;
  final String matNumber;

  CategoryModel({
    required this.matId,
    required this.matName,
    required this.matNumber,
  });

  factory CategoryModel.fromJson(json) {
    return CategoryModel(
      matId: int.parse(json['mat_id'].toString()), 
      matName: json['mat_name'],
      matNumber: json['mat_number'],
    );
  }

  Map<String, String> toMap() {
    return {
      'database_name': 'itechsy_test',
      'mat_id': matId.toString(), 
      'mat_number': matNumber,
      'mat_name': matName,
      'mat_kind': '5',
    };
  }
}
