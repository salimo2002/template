import 'package:template/cubit/company%20cubit/company_cubit.dart';

class CategoryModel {
  final int matId;
  final String matName;
  final String matNumber;

  const CategoryModel({
    required this.matId,
    required this.matName,
    required this.matNumber,
  });
  CategoryModel copyWith(int? matId, String? matName, String? matNumber) {
    return CategoryModel(
      matId: matId ?? this.matId,
      matName: matName ?? this.matName,
      matNumber: matNumber ?? this.matNumber,
    );
  }

  factory CategoryModel.fromJson(json) {
    return CategoryModel(
      matId: int.parse(json['mat_id'].toString()),
      matName: json['mat_name'],
      matNumber: json['mat_number'],
    );
  }

  Map<String, String> toMap() {
    return {
      'database_name': CompanyCubit.comp.dataBase,
      'mat_id': matId.toString(),
      'mat_number': matNumber,
      'mat_name': matName,
      'mat_kind': '5',
    };
  }
}
