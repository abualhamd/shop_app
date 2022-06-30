import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/shop_states.dart';
import 'package:shop_app/screens/favorite_screen.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/categories_screen.dart';
import 'package:shop_app/screens/settings_screen.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(BuildContext context) => BlocProvider.of(context);

  int bottomScreensIndex = 0;
  List bottomScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomScreenIndex(int index) {
    bottomScreensIndex = index;

    emit(ShopChangeBottomScreenIndexState());
  }
}
