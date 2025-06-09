import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/views/mterial_Invoice_view.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(5),
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
                        focusNode: _focusNode,
                      ),
                      if (isSearching)
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SearchResultsList(
                            results: searchResults,
                            onSelect: (material) {
                              setState(() {
                                materialController.text = material.materialName;
                                isSearching = false;
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
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
                        context.read<MaterialCubit>().materials.forEach((
                          element,
                        ) {
                          if (element.materialName == materialController.text) {
                            matId = element.materialId;
                          }
                        });
                        Navigator.pushNamed(
                          context,
                          MterialInvoiceView.id,
                          arguments: [matId, materialController.text],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
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
              subtitle: Text(material.materialId.toString()),
              onTap: () => onSelect(material),
            );
          },
        ),
      ),
    );
  }
}
