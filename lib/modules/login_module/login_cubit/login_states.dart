import 'package:shop_app/models/login_model.dart';

abstract class LoginState{}

class LoginInitState extends LoginState{}

class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginState{
  final String error;

  LoginErrorState(this.error);
}

class LoginToggleVisibilityState extends LoginState{}

