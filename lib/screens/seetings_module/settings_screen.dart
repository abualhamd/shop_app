import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/seetings_module/profile_cubit/cubit.dart';
import 'package:shop_app/shared/components.dart';
import 'profile_cubit/states.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        ProfileCubit cubit = ProfileCubit.get(context);


        return buildLayoutScreen(
            condition: (cubit.profileModel != null),
            widget: SafeArea(
              child: Scaffold(
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: cubit.nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Name'),
                            prefixIcon: Icon(Icons.person_outlined),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: cubit.emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Email'),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          controller: cubit.phoneController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Phone'),
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextButton(
                          onPressed: () {
                            // print(cubit.profileModel!.data!.token);
                            // print(CacheHelper.getData(key: token));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                // side: BorderSide()
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
