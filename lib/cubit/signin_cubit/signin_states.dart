import 'package:shop_app/models/login_model.dart';

abstract class SignInState{}

class SignInInitState extends SignInState{}

class SignInLoadingState extends SignInState{}

class SignInSuccessState extends SignInState{
  final LoginModel loginModel;

  SignInSuccessState(this.loginModel);
}

class SignInErrorState extends SignInState{
  final String error;

  SignInErrorState(this.error);
}

class SignInToggleVisibilityState extends SignInState{}
