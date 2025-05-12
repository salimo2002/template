import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/category%20cubit/category_cubit.dart';
import 'package:template/category%20cubit/category_status.dart';
import 'package:template/models/category_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/home_view.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/container_item_classifications.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/container_name_classifications.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_alert_dialog.dart';

class MaterialClassificationsView extends StatefulWidget {
  const MaterialClassificationsView({super.key});
  static String id = 'MaterialClassificationsView';

  @override
  State<MaterialClassificationsView> createState() =>
      _MaterialClassificationsViewState();
}

class _MaterialClassificationsViewState
    extends State<MaterialClassificationsView> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController categoryNameUpdate = TextEditingController();
  final TextEditingController categoryNameInsert = TextEditingController();

  List<CategoryModel> filteredCategories = [];
  List<CategoryModel> allCategories = [];

  @override
  void dispose() {
    searchController.dispose();
    categoryNameUpdate.dispose();
    categoryNameInsert.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryStatus>(
      builder: (context, state) {
        if (state is SuccessStateCategory) {
          if (allCategories != state.categories) {
            allCategories = state.categories;
            filteredCategories = List.from(allCategories);
          }

          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            appBar: customAppBar(
              context: context,
              title: 'تصنيفات المواد',
              showIcons: false,
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: null,
              shape: const CircleBorder(),
              tooltip: 'ادخال بطاقة مادة',
              backgroundColor: kBlueAccent,
              child: const Icon(Icons.add_circle, color: kWhite),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      text: 'اضافة تصنيف',
                      globalKey: globalKey,
                      validator: (p0) {
                        if (p0 == null || p0 == '') {
                          return 'الرجاء ادخال اسم التصنيف';
                        }
                        return null;
                      },
                      categoryNameUpdate: categoryNameInsert,
                      onTap: () async {
                        if (globalKey.currentState!.validate()) {
                          Navigator.pop(context);
                          context.read<CategoryCubit>().insertCategory(
                            CategoryModel(
                              matId: 0,
                              matName: categoryNameInsert.text,
                              matNumber: Random().nextInt(10000).toString(),
                            ),
                          );
                          categoryNameInsert.clear();
                        }
                      },
                    );
                  },
                );
              },
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    SearchByName(
                      categoryName: searchController,
                      onChanged: _filterCategories,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),
                    filteredCategories.isEmpty
                        ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'لا توجد تصنيفات مطابقة للبحث',
                              style: FontStyleApp.black18.copyWith(
                                fontSize: getResponsiveText(context, 18),
                              ),
                            ),
                          ),
                        )
                        : Expanded(
                          child: ListView.builder(
                            itemCount: filteredCategories.length,
                            itemBuilder: (context, index) {
                              final category = filteredCategories[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ContainerItemClassifications(
                                  matId: category.matId.toString(),
                                  color: kGrey,
                                  nameClassificatio: category.matName,
                                  onTap: () {
                                    categoryNameUpdate.text = category.matName;
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                          text: 'تعديل التصنيف',
                                          globalKey: globalKey,
                                          validator: (p0) {
                                            if (p0 == null || p0 == '') {
                                              return 'ادخل قيمة';
                                            }
                                            return null;
                                          },
                                          categoryNameUpdate:
                                              categoryNameUpdate,
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await context
                                                .read<CategoryCubit>()
                                                .updateCategory(
                                                  CategoryModel(
                                                    matId: category.matId,
                                                    matName:
                                                        categoryNameUpdate.text,
                                                    matNumber:
                                                        category.matNumber,
                                                  ),
                                                );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is FaliureStateCategory) {
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
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeView.id,
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.refresh, color: kBlack),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: kBlueAccent)),
          );
        }
      },
    );
  }

  void _filterCategories(String query) {
    final trimmedQuery = query.trim().toLowerCase();

    setState(() {
      if (trimmedQuery.isEmpty) {
        filteredCategories = List.from(allCategories);
      } else {
        filteredCategories =
            allCategories.where((category) {
              return category.matName.toLowerCase().contains(trimmedQuery) ||
                  category.matNumber.contains(trimmedQuery);
            }).toList();
      }
    });
  }
}
