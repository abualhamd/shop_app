import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login_cubit/login_states.dart';
import 'package:shop_app/screens/shop_layout.dart';
import 'package:shop_app/screens/signup_screen.dart';
import 'package:shop_app/shared/themes_and_decorations.dart';
import 'package:shop_app/cubit/login_cubit/login_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../helpers/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.setToken(value: state.loginModel.data!.token).then(
                (value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopLayout(),
                    ),
                  );
                },
              );
            } else {
              Fluttertoast.showToast(
                msg: state.loginModel.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          final Size size = MediaQuery.of(context).size;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline3!,
                          ),
                          SizedBox(height: size.height / 65),
                          const Text(
                            'Login to explore our deals',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                          SizedBox(height: size.height / 40),
                          //email
                          TextFormField(
                            controller: emailController,
                            decoration: decorationFormField,
                            keyboardType: TextInputType.emailAddress,
                            validator: cubit.validator,
                          ),
                          SizedBox(height: size.height / 30),
                          //password
                          TextFormField(
                            onFieldSubmitted: (value) {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            controller: passwordController,
                            decoration: decorationFormField.copyWith(
                              label: const Text('password'),
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  cubit.togglePasswordVisibility();
                                },
                                icon: Icon(cubit.visibilityIcon),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: cubit.passwordVisibility,
                            validator: cubit.validator,
                          ),
                          SizedBox(height: size.height / 30),
                          Center(
                            child: Column(
                              children: [
                                ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => TextButton(
                                    onPressed: () {
                                      //TODO regex to check email and password
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    child: const Text('Sing In'),
                                    // style: ButtonStyle(
                                    //   backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    //   // shape:
                                    // ),
                                  ),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('don\'t have an account yet?'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUp()));
                                      },
                                      child: const Text('Sing up'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
