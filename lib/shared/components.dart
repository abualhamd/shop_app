import 'package:flutter/material.dart';
import 'package:shop_app/cubit/app_cubit/cubit.dart';

import '../models/categories_model.dart';
import '../models/home_model.dart';

class BuildBoardingItem extends StatelessWidget {
  final Size size;
  final int index;

  const BuildBoardingItem({required this.size, required this.index});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height / 4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage(cubit.onBoardingItems[index].img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: size.height / 20,
        ),
        Text(
          cubit.onBoardingItems[index].screenTitle,
          //TODO add Jannah font
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: size.height / 25,
        ),
        Text(
          cubit.onBoardingItems[index].screenBody,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//products screen components

Widget buildTitle({
  required String title,
  required Size size,
}) =>
    Padding(
      padding: EdgeInsets.only(
          top: size.height / 30,
          bottom: size.height / 100,
          left: size.height / 100),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

Widget buildSliderItem({required String image}) => Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: NetworkImage(image),
      fit: BoxFit.fill,
    ),
  ),
);

Widget builderCatItem({required String image, required String name}) =>
    Container(
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

Widget buildGridItem({required ProductModel model}) => Stack(
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
                const SizedBox(
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
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border_outlined)),
              ],
            ),
          ],
        ),
      ),
    ),
    if (model.discount > 0)
      Container(
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            'Discount',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
  ],
);
////////////////////////////////////////////////////////////////////////////////
//category screen components

Widget buildCategoryItem(CategoriesDataModel model) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15),
        child: Image(
          image: NetworkImage(model.image),
          height: 120,
          width: 120,
          fit: BoxFit.fill,
        ),
      ),

      Text(model.name),
      const Spacer(),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_forward_ios),
      ),
    ],
  );
}
