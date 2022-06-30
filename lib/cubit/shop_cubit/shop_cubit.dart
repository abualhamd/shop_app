import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/shop_states.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/screens/favorite_screen.dart';
import 'package:shop_app/screens/products_screen.dart';
import 'package:shop_app/screens/categories_screen.dart';
import 'package:shop_app/screens/settings_screen.dart';
import 'package:shop_app/shared/constants.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(BuildContext context) => BlocProvider.of(context);

  int bottomScreensIndex = 0;
  List bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;

  void changeBottomScreenIndex(int index) {
    bottomScreensIndex = index;

    emit(ShopChangeBottomScreenIndexState());
  }

  void loadProducts() {
    emit(ShopProductsLoadingState());
    DioHelper.getData(
            url: home, token: CacheHelper.getData(key: token).toString())
        .then((value) {
      // print(value.data.toString());
      homeModel = HomeModel.fromJson(value.data);

      // print(homeModel.data!.products.length);

      emit(ShopProductsSuccessState());
    }).catchError((error) {
      emit(ShopProductsErrorState());
    });
  }

  void loadCategories(){
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(
        url: categories)
        .then((value) {
      // print(value.data.toString());
      categoriesModel = CategoriesModel.fromJson(value.data);

      // print(homeModel.data!.products.length);

      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopCategoriesErrorState());
    });
  }
}
