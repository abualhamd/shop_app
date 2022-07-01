import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/shop_cubit.dart';

import '../cubit/shop_cubit/shop_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: cubit.bottomScreens[cubit.bottomScreensIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomScreensIndex,
              onTap: (index){
                cubit.changeBottomScreenIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.apps_outlined), label: 'categories'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'favorite'),
                BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'settings'),
              ],
            ),
          ),
        );
      },
    );
  }
}
