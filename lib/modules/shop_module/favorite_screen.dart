import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components.dart';
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

        return buildLayoutScreen(
            condition: (cubit.homeModel != null && cubit.favoriteModel != null),
            widget: ListView.separated(
          // shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildFavoriteItem(
                id: cubit.favoriteModel!.data[index], context: context),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey,
            ),
            itemCount: cubit.favoriteModel!.data.length));
      },
    );
  }
}