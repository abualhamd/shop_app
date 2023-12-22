import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/app_colors.dart';
import '../../shared/components.dart';
import '../../shared/components/layout_component.dart';
import 'shop_cubit/shop_cubit.dart';
import 'shop_cubit/shop_states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return LayoutComponent(
            condition: (cubit.homeModel != null && cubit.favoriteModel != null),
            child: ListView.separated(
                // shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildFavoriteItem(
                    id: cubit.favoriteModel!.data[index], context: context),
                separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: AppColors.grey,
                    ),
                itemCount: cubit.favoriteModel!.data.length));
      },
    );
  }
}
