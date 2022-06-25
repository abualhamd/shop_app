import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import 'states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models.dart';

class ShopCubit extends Cubit<AppState> {
  ShopCubit() : super(AppInitState());

  static ShopCubit get(context) => BlocProvider.of<ShopCubit>(context);

  bool isLast = false;
  List<BoardingModel> onBoardingItems = [
    BoardingModel(
        img: 'lib/assets/food-and-grocery.png',
        screenTitle: 'screenTitle 1',
        screenBody: 'screenBody 1'),
    BoardingModel(
        img: 'lib/assets/supermarket.png',
        screenTitle: 'screenTitle 2',
        screenBody: 'screenBody 3'),
    BoardingModel(
        img: 'lib/assets/food-and-grocery.png',
        screenTitle: 'screenTitle 3',
        screenBody: 'screenBody 3'),
  ];

  void navigateToLoginScreen(BuildContext context){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LoginScreen()));

    emit(AppNavigateToLoginScreenState());
  }


}