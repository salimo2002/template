class AccontsGetPerintIdZero {
  final int? idPierint;
  final String namePierint;
  AccontsGetPerintIdZero({this.idPierint, required this.namePierint});
  factory AccontsGetPerintIdZero.fromJson(json) {
    return AccontsGetPerintIdZero(
      idPierint: int.parse(json['ACC_ID'].toString()),
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
