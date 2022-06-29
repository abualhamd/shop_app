import 'package:shop_app/cubit/signin_cubit/signin_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/models/login_model.dart';

class SignInCubit extends Cubit<SignInState>{
  SignInCubit(): super(SignInInitState());
  static SignInCubit get(BuildContext context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;
  IconData visibilityIcon = Icons.visibility_outlined;
  LoginModel? _loginModel;

  final validator = (value) {
    if (value == null || value.isEmpty) {
      return 'field can\'t be empty';
    }
    return null;
  };

 void togglePasswordVisibility(){
   passwordVisibility = !passwordVisibility;
   if(!passwordVisibility)
     visibilityIcon = Icons.visibility_off_outlined;
   else
     visibilityIcon = Icons.visibility_outlined;

   emit(SignInToggleVisibilityState());
 }

 void userLogin({required String email, required String password}){
   DioHelper.init();

   emit(SignInLoadingState());
   DioHelper.postData(url: 'login', data: {
     'email': email,
     'password': password,
   }).then((value) {
      _loginModel = LoginModel.fromJson(value.data);
     // print(_loginModel!.status);
     // print(_loginModel!.message);
     // print(_loginModel!.data!.token);
     emit(SignInSuccessState(_loginModel!));
   }).catchError((error){

     emit(SignInErrorState(error.toString()));
   });
 }

}