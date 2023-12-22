import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

import '../../shared/app_colors.dart';
import '../../shared/app_strings.dart';
import '../../shared/components.dart';
import '../../shared/components/layout_component.dart';
import 'shop_cubit/shop_cubit.dart';
import 'shop_cubit/shop_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
    // required this.banners,
    // required this.homeModel,
    // required this.categoriesModel,
  });

  // categoriesModel: shopWatch.categoriesModel,
  //       banners: shopWatch.homeModel?.data?.banners ?? [],

  @override
  Widget build(BuildContext context) {
    //TODO add product details screen
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        final shopWatch = context.watch<ShopCubit>();
        final Size size = MediaQuery.of(context).size;

        return LayoutComponent(
          condition: shopWatch.homeModel != null && shopWatch.categoriesModel != null,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //slider images of banners
                Container(
                  color: AppColors.white,
                  height: size.height / 5,
                  width: double.infinity,
                  child: CarouselSlider(
                    items: (shopWatch.homeModel?.data?.banners ?? [])
                        .map((e) => buildSliderItem(image: e.image))
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      aspectRatio: 1 / 1.55,
                      autoPlay: true,
                    ),
                  ),
                ),
                buildTitle(title: AppStrings.categories, size: size),
                //categories
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 80,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: shopWatch.categoriesModel
                        ?.data.length ?? 0, //cubit.categoriesModel?.data.length ?? 0,
                    itemBuilder: (context, index) => builderCatItem(
                      image: shopWatch.categoriesModel!.data[index].image,
                      name: shopWatch.categoriesModel!.data[index].name,
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: MediaQuery.of(context).size.height / 40,
                    ),
                  ),
                ),
                buildTitle(title: AppStrings.newProducts, size: size),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.55,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: (shopWatch.homeModel?.data?.products ?? [])
                      .map((e) => buildGridItem(model: e, context: context))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
