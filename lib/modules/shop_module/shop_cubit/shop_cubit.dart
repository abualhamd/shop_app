import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/shop_module/favorite_screen.dart';
import 'package:shop_app/modules/shop_module/products_screen.dart';
import 'package:shop_app/modules/shop_module/categories_screen.dart';
import 'package:shop_app/modules/settings_module/settings_screen.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'shop_states.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(BuildContext context) => BlocProvider.of(context);

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  FavoriteModel? favoriteModel;

  void loadProducts() {
    emit(ShopProductsLoadingState());
    DioHelper.getData(
            endPoint: home, token: CacheHelper.getData(key: token).toString())
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);


      emit(ShopProductsSuccessState());
    }).catchError((error) {
      emit(ShopProductsErrorState());
    });
  }

  void loadCategories() {
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(endPoint: categories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopCategoriesErrorState());
    });
  }

  void loadFavorites() {
    emit(ShopFavoritesLoadingState());
    DioHelper.getData(
      endPoint: favorites,
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

    DioHelper.postData(endPoint: favorites,
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
