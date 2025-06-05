import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/material_services.dart';
import 'package:template/cubit/material%20cubit/material_status.dart';
import 'package:template/models/material_model.dart';

class MaterialCubit extends Cubit<MaterialStatus> {
  MaterialCubit() : super(InitState());
  List<dynamic> resultMaterial = [];
  List<MaterialModel> materials = [];

  Future<void> fetchMaterials({bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(LoadingState());
    }
    try {
      materials = [];
      resultMaterial = await MaterialServices.fetchMaterials();
      for (var element in resultMaterial) {
        materials.add(MaterialModel.fromJson(element));
      }
      emit(SuccessState(materials: materials));
    } on Exception catch (e) {
      emit(FaliureState(errorMessage: e.toString()));
    }
  }

  Future<void> insertMaterial(MaterialModel material) async {
    try {
      emit(LoadingState());
      await MaterialServices.addMaterial(material);
      await fetchMaterials(isRefresh: true);
    } catch (e) {
      emit(FaliureState(errorMessage: e.toString()));
    }
  }

  Future<void> updateMaterial(MaterialModel material) async {
    try {
      emit(LoadingState());
      await MaterialServices.updateMaterialById(material);
      await fetchMaterials(isRefresh: true);
    } catch (e) {
      emit(FaliureState(errorMessage: e.toString()));
    }
  }

  Future<void> deleteMaterial(MaterialModel material) async {
    try {
      emit(LoadingState());
      final int statusCode = await MaterialServices.deleteMaterial(
        material.materialId,
      );
      if (statusCode == 1) {
        await fetchMaterials(isRefresh: true);
      }
      if (statusCode == 2) {
        emit(
          FaliureState(
            errorMessage: 'المادة مرتبطة بفاتورة الرجاء حذف الفاتورة',
          ),
        );
      }
    } catch (e) {
      emit(FaliureState(errorMessage: 'حدث هطأ ما حاول مجددا او تحقق من اتصالك بالانترنت'));
    }
  }
}
