import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/category_services.dart';
import 'package:template/category%20cubit/category_status.dart';
import 'package:template/models/category_model.dart';

class CategoryCubit extends Cubit<CategoryStatus> {
  CategoryCubit() : super(InitStateCategory());
  List<dynamic> resultCategories = [];
  List<CategoryModel> categories = [];

  Future<void> categoryDeletById({required String matId}) async {
    try {
      emit(LoadingStateCategory());
      await CategoryServices.categoryDeletById(matId: matId);
      resultCategories = await CategoryServices.fetchCategory();
      categories =
          resultCategories.map((e) => CategoryModel.fromJson(e)).toList();
      emit(SuccessStateCategory(categories: categories));
    } catch (e) {
      emit(FaliureStateCategory(errorMessage: e.toString()));
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      emit(LoadingStateCategory());
      await CategoryServices.updateCategory(category);
      resultCategories = await CategoryServices.fetchCategory();
      categories =
          resultCategories.map((e) => CategoryModel.fromJson(e)).toList();
      emit(SuccessStateCategory(categories: categories));
    } catch (e) {
      emit(FaliureStateCategory(errorMessage: e.toString()));
    }
  }

  Future<void> insertCategory(CategoryModel category) async {
    try {
      emit(LoadingStateCategory());
      await CategoryServices.addCategory(category);
      resultCategories = await CategoryServices.fetchCategory();
      categories =
          resultCategories.map((e) => CategoryModel.fromJson(e)).toList();
      emit(SuccessStateCategory(categories: categories));
    } catch (e) {
      emit(FaliureStateCategory(errorMessage: e.toString()));
    }
  }

  Future<void> fetchCategory() async {
    emit(LoadingStateCategory());
    try {
      categories = [];
      resultCategories = await CategoryServices.fetchCategory();
      for (var element in resultCategories) {
        categories.add(CategoryModel.fromJson(element));
      }
      emit(SuccessStateCategory(categories: categories));
    } on Exception catch (e) {
      emit(FaliureStateCategory(errorMessage: e.toString()));
    }
  }
}
