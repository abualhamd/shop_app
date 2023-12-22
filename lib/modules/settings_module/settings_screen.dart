import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings_module/profile_cubit/profile_cubit.dart';
import 'package:shop_app/shared/components.dart';
import '../../shared/components/layout_component.dart';
import '../login_module/login_screen.dart';
import 'profile_cubit/profile_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  //TODO add an editing button

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccessState) {
          showToast(
              message: 'Profile updated successfully', color: Colors.green);
        }
        if (state is ProfileLogoutSuccessState) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()));
        }
      },
      builder: (context, state) {
        ProfileCubit cubit = ProfileCubit.get(context);
        final formKey = GlobalKey<FormState>();

        return LayoutComponent(
          condition: (cubit.profileModel != null),
          child: SafeArea(
            child: Scaffold(
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                //TODO fix the overflow problem
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (state is ProfileUpdateLoadingState)
                          const LinearProgressIndicator(),
                        // const SizedBox(height: 20,),

                        myTextFormField(
                            controller: cubit.nameController,
                            label: 'Name',
                            icon: Icons.person_outlined),
                        myTextFormField(
                            controller: cubit.emailController,
                            label: 'Email',
                            icon: Icons.email_outlined),
                        myTextFormField(
                            controller: cubit.phoneController,
                            label: 'Phone',
                            icon: Icons.phone_outlined),
                        blueButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.profileUpdateP();
                              }
                            },
                            title: 'Update Profile'),
                        const Spacer(),
                        blueButton(
                            onPressed: () {
                              cubit.logout(context);
                            },
                            title: 'Logout')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
