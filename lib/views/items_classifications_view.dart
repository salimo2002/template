import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/material_services.dart';
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

class ItemsClassificationsView extends StatefulWidget {
  const ItemsClassificationsView({super.key});
  static String id = 'ItemClassificationsView';

  @override
  State<ItemsClassificationsView> createState() =>
      _ItemsClassificationsViewState();
}

class _ItemsClassificationsViewState extends State<ItemsClassificationsView> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController categoryName = TextEditingController();

  final TextEditingController categoryNameUpdate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryStatus>(
      builder: (context, state) {
        if (state is SuccessStateCategory) {
          List categories = state.categories;

          return Scaffold(
            appBar: customAppBar(
              context: context,
              title: 'تصنيفات المواد',
              showIcons: false,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    ContainerNameClassifications(
                      categoryName: categoryName,
                      globalKey: globalKey,
                      onPressed: () async {
                        if (globalKey.currentState!.validate()) {
                          context.read<CategoryCubit>().insertCategory(
                            CategoryModel(
                              matId: 0,
                              matName: categoryName.text,
                              matNumber: Random().nextInt(10000).toString(),
                            ),
                          );
                          categoryName.clear();
                        }
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * .005),
                    categories.isEmpty
                        ? Text(
                          'لايوجد تصنيفات',
                          style: FontStyleApp.black18.copyWith(
                            fontSize: getResponsiveText(context, 18),
                          ),
                        )
                        : Expanded(
                          child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ContainerItemClassifications(
                                  color: kGrey,
                                  nameClassificatio:
                                      state.categories[index].matName,
                                  onTap: () {
                                    categoryNameUpdate.text =
                                        categories[index].matName;
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                          categoryNameUpdate:
                                              categoryNameUpdate,
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await context
                                                .read<CategoryCubit>()
                                                .updateCategory(
                                                  CategoryModel(
                                                    matId:
                                                        state
                                                            .categories[index]
                                                            .matId,
                                                    matName:
                                                        categoryNameUpdate.text,
                                                    matNumber:
                                                        state
                                                            .categories[index]
                                                            .matNumber,
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
                    icon: Icon(Icons.refresh, color: kBlack),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator(color: kBlueAccent)),
          );
        }
      },
    );
  }
}
