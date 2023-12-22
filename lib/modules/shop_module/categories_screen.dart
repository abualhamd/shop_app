import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/shared/components.dart';
import '../../shared/components/layout_component.dart';
import 'shop_cubit/shop_cubit.dart';
import 'shop_cubit/shop_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  //TODO add category details screen
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return LayoutComponent(
          condition: (cubit.categoriesModel != null),
          child: ListView.separated(
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
