import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/cubit/app_cubit/cubit.dart';
import 'package:shop_app/cubit/app_cubit/states.dart';
import 'package:shop_app/cubit/login_cubit/login_cubit.dart';
import 'package:shop_app/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/screens/onboarding_screen.dart';
import 'package:shop_app/screens/seetings_module/profile_cubit/cubit.dart';
import 'package:shop_app/screens/shop_layout.dart';
import 'screens/login_screen.dart';
import 'shared/themes_and_decorations.dart';
import 'shared/constants.dart';
import 'helpers/dio_helper.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      DioHelper.init();
      await CacheHelper.init();
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
            title: 'Flutter Demo',
            theme: themeLight,
            home: (CacheHelper.getData(key: onBoarding) == false)
                ? (CacheHelper.getData(key: token) != null) //TODO .isEmpty
                    ? ShopLayout()
                    : LoginScreen()
                : const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
