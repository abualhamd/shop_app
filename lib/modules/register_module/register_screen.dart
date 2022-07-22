import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login_module/login_cubit/login_states.dart';
import '../login_module/login_screen.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/themes_and_decorations.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'register_cubit/register_cubit.dart';
import 'register_cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, LoginState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.model!.status) {
              // CacheHelper.setToken(value: state.model!.data!.token).then(
              //   (value) {
              //
              //   },
              // );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
              showToast(message: 'Successful registration');
            } else {
              showToast(message: state.model!.message);
            }
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
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
                            'Register',
                            style: Theme.of(context).textTheme.headline3!,
                          ),
                          SizedBox(height: size.height / 65),
                          const Text(
                            'Register to explore our deals',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                          SizedBox(height: size.height / 40),
                          //name
                          TextFormField(
                            controller: cubit.nameController,
                            decoration: decorationFormField.copyWith(
                              label: const Text('name'),
                              prefixIcon: const Icon(Icons.person_outlined),
                            ),
                            keyboardType: TextInputType.name,
                            validator: cubit.validator,
                          ),
                          SizedBox(height: size.height / 50),
                          //email
                          TextFormField(
                            controller: cubit.emailController,
                            decoration: decorationFormField,
                            keyboardType: TextInputType.emailAddress,
                            validator: cubit.validator,
                          ),
                          SizedBox(height: size.height / 50),
                          //phone
                          TextFormField(
                            controller: cubit.phoneController,
                            decoration: decorationFormField.copyWith(
                              label: const Text('phone'),
                              prefixIcon: const Icon(Icons.phone_outlined),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: cubit.validator,
                          ),
                          SizedBox(height: size.height / 50),
                          //password
                          TextFormField(
                            onFieldSubmitted: (value) {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.userRegister();
                              }
                            },
                            controller: cubit.passwordController,
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
                          SizedBox(height: size.height / 50),
                          Center(
                            child: Column(
                              children: [
                                ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  builder: (context) => TextButton(
                                    onPressed: () {
                                      //TODO regex to check email and password
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.userRegister();
                                      }
                                    },
                                    child: const Text('Sing Up'),
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
                                    const Text('Already have an account?'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      },
                                      child: const Text('Log In'),
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
