import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/views/mterial_Invoice_view.dart';
import 'package:template/widgets/Invoice%20review/filter_invoice_review.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class MovementOfMatterView extends StatefulWidget {
  const MovementOfMatterView({super.key});
  static String id = 'MovementOfMatterView';
  @override
  State<MovementOfMatterView> createState() => _AccountStatementViewState();
}

class _AccountStatementViewState extends State<MovementOfMatterView> {
  List<MaterialModel> searchResults = [];
  bool isSearching = false;
  final FocusNode _focusNode = FocusNode();
  late int matId;

  Color color3 = kWhite;
  Color textColor3 = kBlueAccent;
  TextEditingController date1Controler = TextEditingController();
  TextEditingController date2Controler = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  FocusNode date1 = FocusNode();
  FocusNode date2 = FocusNode();
  bool isToDay = false;
  bool canRead = false;

  final TextEditingController materialController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'حركة مادة',
        showIcons: false,
      ),
      body: SafeArea(
        child: Form(
          key: globalKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ContainerFields(
                      children: [
                        CustomTextField(
                          onChanged: (query) => searchAccount(query),
                          suffixIcon: const SizedBox(width: 40, height: 40),
                          hintText: 'اسم المادة',
                          controller: materialController,
                          validator: (p0) {
                            if (p0 == '' || p0 == null) {
                              return 'ادخل اسم المادة';
                            }
                            return null;
                          },
                          focusNode: _focusNode,
                        ),
                        if (isSearching)
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: SearchResultsList(
                              results: searchResults,
                              onSelect: (material) {
                                setState(() {
                                  materialController.text =
                                      material.materialName;
                                  matId = material.materialId;
                                  isSearching = false;
                                });
                              },
                            ),
                          ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isToDay = !isToDay;
                                  if (isToDay) {
                                    color3 = kBlueAccent;
                                    textColor3 = kWhite;
                                    canRead = true;
                                    date1Controler.text = '';
                                    date2Controler.text = '';
                                  } else {
                                    canRead = false;
                                    color3 = kWhite;
                                    textColor3 = kBlueAccent;
                                  }
                                });
                              },
                              child: ContainerFilter(
                                height: 35,
                                width: MediaQuery.sizeOf(context).width * .22,
                                text: 'تاريخ اليوم',
                                containerColor: color3,
                                textColor: textColor3,
                              ),
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              child: TextFieldDate(
                                canRead: canRead,
                                date: date1Controler,
                                hoursOrYear: true,
                                label: 'من تاريخ',
                              ),
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              child: TextFieldDate(
                                canRead: canRead,
                                date: date2Controler,
                                hoursOrYear: true,
                                label: 'الى تاريخ',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BlocConsumer<BillCubit, BillStatus>(
                  listener: (context, state) {
                    if (state is SuccessStateBill) {
                      Navigator.pushNamed(context, MterialInvoiceView.id);
                    } else if (state is FaliureStateBill) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        customSnackBar(context, state.errorMessage, kRed),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingStateBill) {
                      return CircularProgressIndicator();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButtonSave(
                              label: 'إلغاء',
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            CustomButtonSave(
                              label: 'التالي',
                              onTap: () {
                                if (globalKey.currentState!.validate()) {
                                  if (date1Controler.text.isEmpty ||
                                      date2Controler.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackBar(
                                        context,
                                        'الرجاء اختيار تاريخ صحيح',
                                        kRed,
                                      ),
                                    );
                                    return;
                                  }
                                  final fromDate = DateTime.tryParse(
                                    date1Controler.text,
                                  );
                                  final toDate = DateTime.tryParse(
                                    date2Controler.text,
                                  );
                                  if (fromDate == null || toDate == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackBar(
                                        context,
                                        'تاريخ غير صالح',
                                        kRed,
                                      ),
                                    );
                                    return;
                                  }
                                  if (fromDate.isAfter(toDate)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackBar(
                                        context,
                                        'التاريخ الأول أحدث من الثاني',
                                        kRed,
                                      ),
                                    );
                                    return;
                                  }
                                  context.read<BillCubit>().fetchMovementBills(
                                    databaseName: 'itechsy_test',
                                    ///TODO Replace DataBase Name
                                    dateFrom: fromDate.toString(),
                                    dateTo: toDate.toString(),
                                    matId: matId.toString(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void searchAccount(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
      return;
    }

    setState(() {
      isSearching = true;
    });

    final materials = context.read<MaterialCubit>().materials;
    final results =
        materials.where((material) {
          return material.materialName.toLowerCase().contains(
            query.toLowerCase(),
          );
        }).toList();

    setState(() {
      searchResults = results;
    });
  }
}

class SearchResultsList extends StatelessWidget {
  final List<MaterialModel> results;
  final void Function(MaterialModel) onSelect;

  const SearchResultsList({
    super.key,
    required this.results,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: results.length,
          itemBuilder: (context, index) {
            final material = results[index];
            return ListTile(
              title: Text(material.materialName),
              onTap: () => onSelect(material),
            );
          },
        ),
      ),
    );
  }
}
