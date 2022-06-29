import 'package:flutter/material.dart';
import 'package:shop_app/cubit/app_cubit/cubit.dart';

class BuildBoardingItem extends StatelessWidget {
  final Size size;
  final int index;

  const BuildBoardingItem({required this.size, required this.index});

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);

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