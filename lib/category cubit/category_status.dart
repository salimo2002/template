abstract class CategoryStatus {}

class InitStateCategory extends CategoryStatus {}

class LoadingStateCategory extends CategoryStatus {}

class SuccessStateCategory extends CategoryStatus {
  final List<dynamic> categories;
  SuccessStateCategory({required this.categories});
}

class FaliureStateCategory extends CategoryStatus {
  final String errorMessage;

  FaliureStateCategory({required this.errorMessage});
}
