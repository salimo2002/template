class CategoryModel {
  final String matName;
  final String matNumber;

  CategoryModel({required this.matName, required this.matNumber});
  factory CategoryModel.fromJson(json) {
    return CategoryModel(
      matName: json['mat_name'],
      matNumber: json['mat_number'],
    );
  }
  Map<String, String> toMap() {
    return {
      'database_name': 'itechsy_test',
      'mat_number': matNumber,
      'mat_name': matName,
      'mat_kind': (5).toString(),
    };
  }
}
