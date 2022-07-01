import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/shop_states.dart';
import '../cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/shared/components.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: ConditionalBuilder(
              //TODO might need to change condition
              condition: ShopCubit.get(context).homeModel != null &&
                  ShopCubit.get(context).categoriesModel != null,
              builder: (context) => BuildProductsScreen(),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}

class BuildProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //slider images of banners
          Container(
            color: Colors.white,
            height: size.height / 5,
            width: double.infinity,
            child: CarouselSlider(
              items: cubit.homeModel!.data!.banners
                  .map((e) => buildSliderItem(image: e.image))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                aspectRatio: 1 / 1.55,
                autoPlay: true,
              ),
            ),
          ),
          buildTitle(title: 'Categories', size: size),
          //categories
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 80,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cubit.categoriesModel!.data.length,
              itemBuilder: (context, index) => builderCatItem(
                image: cubit.categoriesModel!.data[index].image,
                name: cubit.categoriesModel!.data[index].name,
              ),
              separatorBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
          buildTitle(title: 'New Products', size: size),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.55,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: cubit.homeModel!.data!.products
                .map((e) => buildGridItem(model: e))
                .toList(),
          )
        ],
      ),
    );
  }
}

