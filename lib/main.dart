import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_cubit/bloc_observer.dart';
import 'app_cubit/cubit.dart';
import 'app_cubit/states.dart';
import 'helpers/cache_helper.dart';
import 'helpers/dio_helper.dart';
import 'modules/login_module/login_screen.dart';
import 'modules/onboarding_screen.dart';
import 'modules/settings_module/profile_cubit/profile_cubit.dart';
import 'modules/shop_module/shop_cubit/shop_cubit.dart';
import 'modules/shop_module/shop_layout.dart';
import 'shared/app_strings.dart';
import 'shared/constants.dart';
import 'shared/themes_and_decorations.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(),
        ),
        // BlocProvider<LoginCubit>(
        //   create: (context) => LoginCubit(),
        // ),
        BlocProvider<ShopCubit>(
          create: (context) => ShopCubit()
            ..loadProducts()
            ..loadFavorites()
            ..loadCategories(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit()..userProfile(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {},
        builder: (BuildContext context, AppState state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            theme: themeLight,
            home: (CacheHelper.getData(key: onBoarding) == false)
                ? (CacheHelper.getData(key: token) != null)
                    ? const ShopLayout()
                    : const LoginScreen()
                : const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
