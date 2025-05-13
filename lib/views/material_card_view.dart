import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/material%20cubit/material_cubit.dart';
import 'package:template/material%20cubit/material_status.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/edit_prodict_view.dart';
import 'package:template/views/home_view.dart';
import 'package:template/views/new_material_view.dart';
import 'package:template/widgets/item%20card%20view%20widgets/container_item_countity.dart';

class MaterialCardView extends StatelessWidget {
  const MaterialCardView({super.key});
  static String id = 'MaterialCardView';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialCubit, MaterialStatus>(
      builder: (context, state) {
        if (state is SuccessState) {
          List<MaterialModel> materials = state.materials;
          return Scaffold(
            appBar: customAppBar(
              context: context,
              title: 'بطاقات المواد',
              showIcons: true,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: FloatingActionButton(
              heroTag: null,
              shape: CircleBorder(),
              tooltip: 'ادخال بطاقة مادة',
              backgroundColor: kBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, NewMaterialView.id);
              },
              child: Icon(Icons.add_circle, color: kWhite),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0.3,
                ),
                child:
                    materials.isEmpty
                        ? Center(
                          child: Text(
                            'لايوجد مواد',
                            style: FontStyleApp.black18.copyWith(
                              fontSize: getResponsiveText(context, 18),
                            ),
                          ),
                        )
                        : ListView.builder(
                          itemCount: materials.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ContainerItemCountity(
                                openItemCard: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                    context,
                                    EditProdictView.id,
                                    arguments: state.materials[index],
                                  );
                                },
                                index: index + 1,
                                material: materials[index],
                              ),
                            );
                          },
                        ),
              ),
            ),
          );
        } else if (state is FaliureState) {
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
