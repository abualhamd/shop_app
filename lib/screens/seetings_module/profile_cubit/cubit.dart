import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/screens/seetings_module/profile_cubit/states.dart';
import 'package:shop_app/shared/components.dart';
import '../../../shared/constants.dart';
import 'package:flutter/material.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileModel? profileModel;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  void userProfile() {
    emit(ProfileLoadingState());

    DioHelper.getData(
      endPoint: profile,
      token: CacheHelper.getData(key: token),
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      nameController.text = profileModel!.name;
      emailController.text = profileModel!.email;
      phoneController.text = profileModel!.phone;

      emit(ProfileSuccessState());
    }).catchError((error){
      showToast(message: error.toString());

      emit(ProfileErrorState());
    });
  }
}
