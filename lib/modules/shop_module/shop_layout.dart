import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_module/search_screen.dart';
import 'shop_cubit/shop_cubit.dart';
import 'shop_cubit/shop_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Abu-Alhamd Shop',
                style: TextStyle(fontFamily: 'smooch'),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                  },
                  icon: const Icon(Icons.search_outlined),
                )
              ],
            ),
            body: cubit.bottomScreens[cubit.bottomScreensIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomScreensIndex,
              onTap: (index) {
                cubit.changeBottomScreenIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps_outlined), label: 'categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline), label: 'favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined), label: 'settings'),
              ],
            ),
          ),
        );
      },
    );
  }
}
