import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/shop_states.dart';
import '../cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared/components.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO add product details screen
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state){
        ShopCubit cubit = ShopCubit.get(context);

        return buildLayoutScreen(
        condition: (cubit.homeModel != null && cubit.categoriesModel != null),
        widget: BuildProductsScreen(),
        );
      },
    );
  }
}
