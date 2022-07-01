import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/shop_states.dart';
import 'package:shop_app/models/home_model.dart';
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
          //slider images of banners
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
          //categories
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.55,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: cubit.homeModel!.data!.products
                .map((e) => GridItemBuilder(model: e))
                .toList(),
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
      decoration: BoxDecoration(
        //TODO fix the border radius
        borderRadius: BorderRadius.circular(20),
      ),
      height: 80,
      width: 120,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image:
                  DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            height: 14,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                name,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridItemBuilder extends StatelessWidget {
  final ProductModel model;

  const GridItemBuilder({required this.model});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(model.image),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    model.name,
                    maxLines: 2,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      model.price.round().toString(),
                      style: const TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount > 0)
                      Text(
                        model.oldPrice.round().toString(),
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 12),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (model.discount > 0)
          const Padding(
            //TODO pickup from here
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              'Discount',
              style: TextStyle(backgroundColor: Colors.red, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
