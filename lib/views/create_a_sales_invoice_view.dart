import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/models/bill_details_model.dart';
import 'package:template/models/bill_model.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/invoice_details_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
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
  final TextEditingController controllerSerch = TextEditingController();
  final TextEditingController totalAllPrice = TextEditingController(text: '0');

  final List<TextEditingController> totalController = [];
  final List<TextEditingController> priceController = [];
  final List<TextEditingController> bounsController = [];
  final List<TextEditingController> quantityController = [];

  final List<BillDetailsModel> bills = [];
  List<MaterialModel> materialModel = [];

  final FocusNode searchFocusNode = FocusNode();
  final AudioPlayer _audioPlayer = AudioPlayer();

  late Map billRoute;
  late bool isNew;
  late String billType;
  BillModel? billModel;
  bool isRebuild = true;

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      if (!searchFocusNode.hasFocus) setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isRebuild) {
      billRoute = ModalRoute.of(context)!.settings.arguments as Map;
      isNew = billRoute['isNew'] as bool;
      billType = billRoute['BillType'] as String;
      billModel =
          billRoute['bill'] != null ? billRoute['bill'] as BillModel : null;

      if (!isNew && billModel != null) {
        final billDetails = context.read<BillCubit>().billDetails.where(
          (detail) => detail.bilId == billModel!.bilId,
        );
        materialModel.clear();
        quantityController.clear();
        priceController.clear();
        totalController.clear();
        bounsController.clear();

        for (var detail in billDetails) {
          final material = context.read<MaterialCubit>().materials.firstWhere(
            (m) => m.materialId == detail.matId,
          );
          materialModel.add(material);

          final quantityCtrl = TextEditingController(
            text: detail.detQuantity.toString(),
          );
          final priceCtrl = TextEditingController(
            text: detail.detSinglePrice.toString(),
          );
          final totalCtrl = TextEditingController();
          final bounsCtrl = TextEditingController(
            text: detail.detBouns.toString(),
          );

          void updateTotal() {
            final price = double.tryParse(priceCtrl.text) ?? 0;
            final quantity = double.tryParse(quantityCtrl.text) ?? 0;
            totalCtrl.text = (price * quantity).toString();
            updateTotalAll();
          }

          priceCtrl.addListener(updateTotal);
          quantityCtrl.addListener(updateTotal);

          quantityController.add(quantityCtrl);
          priceController.add(priceCtrl);
          totalController.add(totalCtrl);
          bounsController.add(bounsCtrl);

          updateTotal();
        }
        updateTotalAll();
        isRebuild = false;
      }
    }
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    controllerSerch.dispose();
    totalAllPrice.dispose();
    scannerController.dispose();
    for (var c in totalController) {
      c.dispose();
    }
    for (var c in bounsController) {
      c.dispose();
    }
    for (var c in priceController) {
      c.dispose();
    }
    for (var c in quantityController) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(
        context: context,
        title: isNew ? 'فاتورة جديدة' : 'تعديل فاتورة',
        showIcons: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            buildSearchBar(),
            if (showScanner) buildScanner(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  if (isSearching && searchResults.isNotEmpty)
                    buildSearchResults(),
                  if (materialModel.isNotEmpty)
                    buildInvoiceItemsList(screenHeight),
                ],
              ),
            ),
            buildSummaryBar(),
            buildFooterButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CustomTextField(
        focusNode: searchFocusNode,
        prefixIcon: IconButton(
          onPressed: _toggleScanner,
          icon: const Icon(FontAwesomeIcons.barcode, color: kBlueAccent),
        ),
        hintText: 'ادخل اسم المادة أو الكود',
        controller: controllerSerch,
        onChanged: _searchMaterials,
      ),
    );
  }

  Widget buildScanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }

  Widget buildSearchResults() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 3),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
    );
  }

  Widget buildInvoiceItemsList(double screenHeight) {
    return ListView.builder(
      itemCount: materialModel.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder:
          (context, index) => InvoiceItemCard(
            unit2: materialModel[index].materialUnit2,
            bounsContoler: bounsController[index],
            isNumericOnly: true,
            unit1: materialModel[index].materialUnit,
            totalController: totalController[index],
            context: context,
            materialName: materialModel[index].materialName,
            materialNameNumber: '${index + 1}',
            priceController: priceController[index],
            quantityController: quantityController[index],
          ),
    );
  }

  Widget buildSummaryBar() {
    return CustomContainer(
      borderRadius: BorderRadius.circular(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'بنود : ${materialModel.length} | كمية : 0 | مجموع : ${totalAllPrice.text} ل.س',
            style: TextStyle(fontSize: getResponsiveText(context, 16)),
          ),
        ],
      ),
    );
  }

  Widget buildFooterButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButtonSave(label: 'إلغاء', onTap: () => Navigator.pop(context)),
          CustomButtonSave(
            label: 'التالي',
            onTap: navigateToInvoiceDetailsView,
          ),
        ],
      ),
    );
  }

  void navigateToInvoiceDetailsView() {
    bills.clear();
    if (materialModel.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar(context, 'قم بإدخال مواد', kRed));
      return;
    }
    for (var i = 0; i < materialModel.length; i++) {
      bills.add(
        BillDetailsModel(
          detId: null,
          bilId: billModel?.bilId,
          matId: materialModel[i].materialId,
          detQuantity: double.tryParse(quantityController[i].text) ?? 0,
          detSinglePrice: double.tryParse(priceController[i].text) ?? 0,
          detPrice: double.tryParse(totalController[i].text) ?? 0,
          strId: 1,
          detBouns: double.tryParse(bounsController[i].text) ?? 0,
        ),
      );
    }
    Navigator.pushNamed(
      context,
      InvoiceDetailsView.id,
      arguments: {
        'bill': bills,
        'total': totalAllPrice.text,
        'billType': billType,
        'isNew': isNew,
        'billModel': billModel,
      },
    );
  }

  void _toggleScanner() => setState(() => showScanner = !showScanner);

  void _searchMaterials(String query) {
    final materials = context.read<MaterialCubit>().materials;
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
    } else {
      setState(() {
        isSearching = true;
        searchResults =
            materials
                .where(
                  (m) =>
                      m.materialName.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      m.materialCode.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();
      });
    }
  }

  Future<void> _playBeepSound() async =>
      await _audioPlayer.play(AssetSource('sounds/beep.mp3'));

  void _addMaterial(MaterialModel material) {
    setState(() {
      materialModel.add(material);
      controllerSerch.clear();
      searchResults.clear();
      isSearching = false;

      final priceCtrl = TextEditingController(
        text: material.materialPrice3.toString(),
      );
      final quantityCtrl = TextEditingController(text: '1');
      final totalCtrl = TextEditingController();
      final bounsCtrl = TextEditingController(text: '0');

      void updateTotal() {
        final price = double.tryParse(priceCtrl.text) ?? 0;
        final quantity = double.tryParse(quantityCtrl.text) ?? 0;
        final total = price * quantity;
        totalCtrl.text = total.toStringAsFixed(1);
        updateTotalAll();
      }

      priceCtrl.addListener(updateTotal);
      quantityCtrl.addListener(updateTotal);

      priceController.add(priceCtrl);
      quantityController.add(quantityCtrl);
      totalController.add(totalCtrl);
      bounsController.add(bounsCtrl);

      updateTotal();
    });
  }

  void updateTotalAll() {
    double total = 0;
    for (var ctrl in totalController) {
      final val = double.tryParse(ctrl.text);
      if (val != null) total += val;
    }
    totalAllPrice.text = total.toString();
    setState(() {});
  }

  void cleanScanner(BarcodeCapture capture) {
    final String? code = capture.barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;
    scannerController.stop();
    controllerSerch.text = code;
    try {
      final material = context.read<MaterialCubit>().materials.firstWhere(
        (m) => m.materialCode == code,
      );
      _playBeepSound();
      _addMaterial(material);
    } catch (_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar(context, 'لم يتم العثور على المادة', kRed));
    }
    setState(() => showScanner = false);
  }
}
