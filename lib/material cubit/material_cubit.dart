import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/material_services.dart';
import 'package:template/material%20cubit/material_status.dart';
import 'package:template/models/material_model.dart';

class MaterialCubit extends Cubit<MaterialStatus> {
  MaterialCubit() : super(InitState());
  List<dynamic> result = [];
  List<MaterialModel> materials = [];

  Future<void> fetchMaterials() async {
    emit(LoadingState());
    try {
      materials = [];
      result = await MaterialServices.fetchMaterials();
      for (var element in result) {
        materials.add(MaterialModel.fromJson(element));
      }
      emit(SuccessState(materials: materials));
    } on Exception catch (e) {
      emit(FaliureState(errorMessage: e.toString()));
    }
  }

  Future<void> insertMaterial(MaterialModel material) async {
    try {
      await MaterialServices.addMaterial(material);
      emit(SuccessState(materials: materials));
    } catch (e) {
      emit(FaliureState(errorMessage: e.toString()));
    }
  }
  
  Future<void> updateMaterial(MaterialModel material) async {
    try {
      await MaterialServices.addMaterial(material);
      emit(SuccessState(materials: materials));
    } catch (e) {
      emit(FaliureState(errorMessage: e.toString()));
    }
  }
}
