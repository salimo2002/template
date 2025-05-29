import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/models/bill_details_model.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/invoice_details_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';
import 'package:template/widgets/sales%20invoice%20view/invoice_item_card.dart';

class CreateASalesInvoiceView extends StatefulWidget {
  const CreateASalesInvoiceView({super.key});
  static String id = 'CreateASalesInvoice';

  @override
  State<CreateASalesInvoiceView> createState() =>
      _CreateASalesInvoiceViewState();
}

class _CreateASalesInvoiceViewState extends State<CreateASalesInvoiceView> {
  bool showScanner = false;
  List<MaterialModel> searchResults = [];
  bool isSearching = false;
  final MobileScannerController scannerController = MobileScannerController();
  final TextEditingController controller = TextEditingController();
  final TextEditingController controllerSerch = TextEditingController();
  final TextEditingController totalAllPrice = TextEditingController(text: '0');
  final List<TextEditingController> totalController = [];
  final List<TextEditingController> priceController = [];
  final List<TextEditingController> quantityController = [];
  final List<BillDetailsModel> bills = [];
  List<MaterialModel> materialModel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'فاتورة مبيعات جديدة',
        showIcons: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 5),
                              Expanded(
                                child: CustomTextField(
                                  focusNode: FocusNode(),
                                  prefixIcon: IconButton(
                                    onPressed: _toggleScanner,
                                    icon: const Icon(
                                      FontAwesomeIcons.barcode,
                                      color: kBlueAccent,
                                    ),
                                  ),
                                  hintText: 'ادخل اسم المادة أو الكود',
                                  controller: controllerSerch,
                                  onChanged: _searchMaterials,
                                ),
                              ),
                            ],
                          ),
                          if (showScanner)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                left: 5,
                                right: 5,
                              ),
                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: MobileScanner(
                                    controller: scannerController,
                                    onDetect: cleanScanner,
                                  ),
                                ),
                              ),
                            ),
                          if (isSearching && searchResults.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
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
                                  itemCount: searchResults.length,
                                  itemBuilder: (context, index) {
                                    final material = searchResults[index];
                                    return ListTile(
                                      title: Text(material.materialName),
                                      subtitle: Text(material.materialCode),
                                      onTap: () => _addMaterial(material),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 600,
                        child: ListView.builder(
                          itemCount: materialModel.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InvoiceItemCard(
                                isNumericOnly: true,
                                unity:
                                    materialModel[index].materialUnitDefault ==
                                            1
                                        ? materialModel[index].materialUnit
                                        : materialModel[index].materialUnit2,
                                totalController: totalController[index],
                                context: context,
                                materialName: materialModel[index].materialName,
                                materialNameNumber: '1',
                                priceController: priceController[index],
                                quantityController: quantityController[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomContainer(
              borderRadius: BorderRadius.circular(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'بنود : ${materialModel.length} |كمية : 0 | مجموع : ${totalAllPrice.text} ل.س',
                    style: TextStyle(fontSize: getResponsiveText(context, 16)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: navigateToInvoiceDetailsView,
              child: Text('التالي', style: FontStyleApp.black18),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void navigateToInvoiceDetailsView() {
    for (var i = 0; i < totalController.length; i++) {
      bills.add(
        BillDetailsModel(
          detId: null,
          bilId: null,
          matId: materialModel[i].materialId,
          detQuantity: double.parse(quantityController[i].text),
          detSinglePrice: double.parse(priceController[i].text),
          detPrice: double.parse(totalController[i].text),
          strId: 1,
        ),
      );
    }
    Navigator.pushNamed(
      context,
      InvoiceDetailsView.id,
      arguments: {'bill': bills, 'total': totalAllPrice.text},
    );
  }

  void _toggleScanner() {
    setState(() {
      showScanner = !showScanner;
    });
  }

  void _searchMaterials(String query) {
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
              ) ||
              material.materialCode.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      searchResults = results;
    });
  }

  void _addMaterial(MaterialModel material) {
    setState(() {
      materialModel.add(material);
      controllerSerch.clear();
      searchResults = [];
      isSearching = false;
      totalController.add(
        TextEditingController(text: material.materialPrice3.toString())
          ..addListener(updateTotalAll),
      );
      priceController.add(
        TextEditingController(text: material.materialPrice3.toString()),
      );
      quantityController.add(TextEditingController(text: '1'));

      updateTotalAll();
    });
  }

  void updateTotalAll() {
    double total = 0;
    for (var controller in totalController) {
      final value = double.tryParse(controller.text);
      if (value != null) total += value;
    }
    totalAllPrice.text = total.toStringAsFixed(1);
    setState(() {});
  }

  void cleanScanner(BarcodeCapture capture) {
    final String? code = capture.barcodes.first.rawValue;
    if (code != null && code.isNotEmpty) {
      controller.text = code;
      scannerController.stop();
      try {
        final material = context.read<MaterialCubit>().materials.firstWhere(
          (element) => element.materialCode == controller.text,
        );
        _addMaterial(material);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(context, 'لم يتم العثور على المادة', kRed),
        );
      }
      setState(() {
        showScanner = false;
      });
    }
  }
}
