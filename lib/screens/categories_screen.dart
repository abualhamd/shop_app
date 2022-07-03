import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shop_cubit/shop_states.dart';
import 'package:shop_app/shared/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return buildLayoutScreen(
          condition: cubit.categoriesModel != null,
          widget: ListView.separated(
            itemBuilder: (context, index) =>
                buildCategoryItem(cubit.categoriesModel!.data[index]),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey,
            ),
            itemCount: cubit.categoriesModel!.data.length,
          ),
        );
      },
    );
  }
}
