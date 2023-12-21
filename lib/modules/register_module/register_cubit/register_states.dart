import 'package:shop_app/models/login_model.dart';
import '../../login_module/login_cubit/login_states.dart';

//TODO abstract class RegisterState extends LoginState{}

class RegisterInitState extends LoginState{}

class RegisterLoadingState extends LoginState{}
class RegisterSuccessState extends LoginState{
  final LoginModel? model;
  RegisterSuccessState(this.model);
}
class RegisterErrorState extends LoginState{}