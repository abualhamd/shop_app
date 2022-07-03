import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/shop_states.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/screens/favorite_screen.dart';
import 'package:shop_app/screens/products_screen.dart';
import 'package:shop_app/screens/categories_screen.dart';
import 'package:shop_app/screens/settings_screen.dart';
import 'package:shop_app/shared/components.dart';
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
  FavoriteModel? favoriteModel;

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

  void loadCategories() {
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(url: categories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopCategoriesErrorState());
    });
  }

  void loadFavorites() {
    emit(ShopFavoritesLoadingState());
    DioHelper.getData(
      url: favorites,
      token: CacheHelper.getData(key: token).toString(),
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);

      emit(ShopFavoritesSuccessState());
    }).catchError((error) {
      emit(ShopFavoritesErrorState());
    });
  }

  void toggleFavorite({required int id}) {
    //TODO
    if(!favoriteModel!.data.contains(id)){
      favoriteModel!.data.add(id);
    } else {
      favoriteModel!.data.remove(id);
    }
    emit(ShopToggleFavoriteLoadingState());

    DioHelper.postData(url: favorites,
        token: CacheHelper.getData(key: token).toString(),
        data: {"product_id": id}).then((value) {
      if (!value.data['status']) {
        if(!favoriteModel!.data.contains(id)){
          favoriteModel!.data.add(id);
        } else {
          favoriteModel!.data.remove(id);
        }

        showToast(message: value.data['message']);
      }
      // else if (value.data['message'] == "Added Successfully") {
      //   favoriteModel!.data.add(id);
      // }
      // else {
      //   favoriteModel!.data.remove(id);
      // }

      emit(ShopToggleFavoriteSuccessState());
    }).catchError((error) {
      showToast(message: error.toString());
      emit(ShopToggleFavoriteErrorState());
    });
  }
}
