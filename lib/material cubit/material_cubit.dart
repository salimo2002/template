import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/material_services.dart';
import 'package:template/material%20cubit/material_status.dart';

class MaterialCubit extends Cubit<MaterialStatus> {
  MaterialCubit() : super(InitState());
  late List<dynamic> materials;
  Future<void> fetchMaterials() async {
    emit(LoadingState());
    try {
      materials = await MaterialServices.fetchMaterials();
      emit(SuccessState(materials: materials));
    } catch (e) {
      emit(FaliureState(errorMessage: e.toString()));
    }
  }
}
