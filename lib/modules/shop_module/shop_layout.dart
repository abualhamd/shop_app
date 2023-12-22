import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shop_app/shared/app_strings.dart';

import '../../shared/constants.dart';
import '../../shared/icons_manager.dart';
import '../search_module/search_screen.dart';
import '../settings_module/settings_screen.dart';
import 'categories_screen.dart';
import 'favorite_screen.dart';
import 'products_screen.dart';
import 'shop_cubit/shop_cubit.dart';
import 'shop_cubit/shop_states.dart';

class ShopLayout extends HookWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shopWatch = context.watch<ShopCubit>();
    final bottomScreensIndex = useState(0);

    final bottomScreens = useMemoized(() =>  [
      ProductsScreen(
        
        
      ),
      const CategoriesScreen(),
      const FavoriteScreen(),
      const SettingsScreen(),
    ]);

    

    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        // ShopCubit cubit = ShopCubit.get(context);
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) return;

            if (bottomScreensIndex.value != 0) {
              bottomScreensIndex.value = 0;
            } else {
              Navigator.pop(context);
            }
          },
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  AppStrings.appTitle,
                  style: TextStyle(fontFamily: AppConstants.smoochFont),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()));
                    },
                    icon: const Icon(IconsManager.search),
                  )
                ],
              ),
              body: bottomScreens[bottomScreensIndex.value],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: bottomScreensIndex.value,
                onTap: (index) {
                  bottomScreensIndex.value = index;
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(IconsManager.home), label: AppStrings.home),
                  BottomNavigationBarItem(
                      icon: Icon(IconsManager.apps),
                      label: AppStrings.categories),
                  BottomNavigationBarItem(
                      icon: Icon(IconsManager.favorite),
                      label: AppStrings.favorite),
                  BottomNavigationBarItem(
                      icon: Icon(IconsManager.settings),
                      label: AppStrings.settings),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
