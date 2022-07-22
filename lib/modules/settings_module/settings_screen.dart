import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings_module/profile_cubit/profile_cubit.dart';
import 'package:shop_app/shared/components.dart';
import 'profile_cubit/profile_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  //TODO add an editing button

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        ProfileCubit cubit = ProfileCubit.get(context);
        final formKey = GlobalKey<FormState>();

        return buildLayoutScreen(
          condition: (cubit.profileModel != null),
          widget: SafeArea(
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
                        if(state is ProfileUpdateLoadingState)
                          const LinearProgressIndicator(),
                        // const SizedBox(height: 20,),

                        myTextFormField(controller: cubit.nameController, label: 'Name', icon: Icons.person_outlined),
                        myTextFormField(controller: cubit.emailController, label: 'Email', icon: Icons.email_outlined),
                        myTextFormField(controller: cubit.phoneController, label: 'Phone', icon: Icons.phone_outlined),
                        blueButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()) {
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
