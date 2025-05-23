import 'package:template/models/material_model.dart';

abstract class MaterialStatus {}

class InitState extends MaterialStatus {}

class LoadingState extends MaterialStatus {}

class SuccessState extends MaterialStatus {
  final List<MaterialModel> materials;
  SuccessState({required this.materials});
}

class FaliureState extends MaterialStatus {
  final String errorMessage;

  FaliureState({required this.errorMessage});
}
