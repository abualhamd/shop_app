import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/shop_states.dart';
import '../cubit/shop_cubit/shop_cubit.dart';

//TODO remove the space in the place of the AppBar

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
            builder: (context) => Products(),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          )),
        );
      },
    );
  }
}

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            child: CarouselSlider(
              items: cubit.homeModel!.data!.banners
                  .map((e) => SliderItemBuilder(image: e.image))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                aspectRatio: 1 / 1.55,
                autoPlay: true,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 80,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cubit.categoriesModel!.data.length,
              itemBuilder: (context, index) => CategoryItemBuilder(
                image: cubit.categoriesModel!.data[index].image,
                name: cubit.categoriesModel!.data[index].name,
              ),
              separatorBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.height / 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SliderItemBuilder extends StatelessWidget {
  final String image;

  const SliderItemBuilder({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class CategoryItemBuilder extends StatelessWidget {
  final String image;
  final String name;

  const CategoryItemBuilder({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 120,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.fill)),
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            height: 14,
            width: double.maxFinite,
            child: Text(
              name,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
