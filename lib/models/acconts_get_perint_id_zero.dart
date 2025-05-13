class ParentAccountsModel {
  final String idPierint;
  final String namePierint;
  ParentAccountsModel({required this.idPierint, required this.namePierint});
  factory ParentAccountsModel.fromJson(json) {
    return ParentAccountsModel(
      idPierint: json['ACC_ID'],
      namePierint: json['ACC_NAME'],
    );
  }

  Map<String, String> toMap() {
    return {
      'database_name': 'itechsy_test',
      'ACC_ID': idPierint.toString(),
      'ACC_NAME': namePierint,
      //اضافة بيرنت ايدي في قاعدة البيانات و ااضافة ملف الانسيرت وبعت له 0
    };
  }
}
