import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../login_module/login_cubit/login_cubit.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/modules/register_module/register_cubit/register_states.dart';
import 'package:shop_app/shared/components.dart';
import '../../../shared/constants.dart';
import 'package:shop_app/models/login_model.dart';

class RegisterCubit extends LoginCubit{
  RegisterCubit(): super.fromRegister(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void userRegister(){
    emit(RegisterLoadingState());
    
    DioHelper.postData(endPoint: register, data: {
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "password": passwordController.text
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      showToast(message: error.toString());
      emit(RegisterErrorState());
    });
    
  }

  


}