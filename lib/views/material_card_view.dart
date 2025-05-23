import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/cubit/material%20cubit/material_status.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/edit_prodict_view.dart';
import 'package:template/views/home_view.dart';
import 'package:template/views/new_material_view.dart';
import 'package:template/widgets/item%20card%20view%20widgets/container_item_countity.dart';
import 'package:template/widgets/item%20card%20view%20widgets/search_text_field.dart';

class MaterialCardView extends StatefulWidget {
  const MaterialCardView({super.key});
  static String id = 'MaterialCardView';

  @override
  State<MaterialCardView> createState() => _MaterialCardViewState();
}

class _MaterialCardViewState extends State<MaterialCardView> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<List<MaterialModel>> _filteredMaterials = ValueNotifier(
    [],
  );

  @override
  void dispose() {
    _searchController.dispose();
    _filteredMaterials.dispose();
    super.dispose();
  }

  void filterMaterials(String query, List<MaterialModel> materials) {
    if (query.isEmpty) {
      _filteredMaterials.value = materials;
    } else {
      _filteredMaterials.value =
          materials.where((material) {
            return material.materialName.toLowerCase().contains(
              query.toLowerCase(),
            );
          }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialCubit, MaterialStatus>(
      builder: (context, state) {
        if (state is SuccessState) {
          List<MaterialModel> materials = state.materials;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _filteredMaterials.value = materials;
          });

          return Scaffold(
            appBar: AppBar(
              backgroundColor: kBlueAccent,
              actions: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .65,
                  height: 35,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: SearchTextField(
                      searchController: _searchController,
                      onChanged: (value) => filterMaterials(value, materials),
                    ),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: null,
              shape: CircleBorder(),
              tooltip: 'ادخال بطاقة مادة',
              backgroundColor: kBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, NewMaterialView.id);
              },
              child: Icon(Icons.add_circle_outline, color: kWhite, size: 30),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0.3,
                ),
                child: ValueListenableBuilder<List<MaterialModel>>(
                  valueListenable: _filteredMaterials,
                  builder: (context, filteredList, _) {
                    return filteredList.isEmpty
                        ? Center(
                          child: Text(
                            'لايوجد مواد',
                            style: FontStyleApp.black18.copyWith(
                              fontSize: getResponsiveText(context, 18),
                            ),
                          ),
                        )
                        : Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: ContainerItemCountity(
                                  openItemCard: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                      context,
                                      EditProdictView.id,
                                      arguments: filteredList[index],
                                    );
                                  },
                                  index: index + 1,
                                  material: filteredList[index],
                                ),
                              );
                            },
                          ),
                        );
                  },
                ),
              ),
            ),
          );
        } else if (state is LoadingState) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator(color: kBlueAccent)),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'حدث خطأ حاول مجددا',
                    style: FontStyleApp.black18.copyWith(
                      fontSize: getResponsiveText(context, 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeView.id,
                        (route) => false,
                      );
                    },
                    icon: Icon(Icons.refresh, color: kBlueAccent, size: 40),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
