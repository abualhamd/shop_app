import 'package:shop_app/cubit/login_cubit/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/constants.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit(): super(LoginInitState());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;
  IconData visibilityIcon = Icons.visibility_outlined;
  LoginModel? loginModel;

  final validator = (value) {
    if (value == null || value.isEmpty) {
      return 'field can\'t be empty';
    }
    return null;
  };

 void togglePasswordVisibility(){
   passwordVisibility = !passwordVisibility;
   if(!passwordVisibility) {
     visibilityIcon = Icons.visibility_off_outlined;
   } else {
     visibilityIcon = Icons.visibility_outlined;
   }

   emit(LoginToggleVisibilityState());
 }

 void userLogin({required String email, required String password}){
   emit(LoginLoadingState());
   DioHelper.postData(url: login, data: {
     'email': email,
     'password': password,
   }).then((value) {
      loginModel = LoginModel.fromJson(value.data);

     emit(LoginSuccessState(loginModel!));
   }).catchError((error){

     emit(LoginErrorState(error.toString()));
   });
 }

}