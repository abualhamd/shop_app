import 'package:flutter/material.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shop_app/cubit/cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PageController pageController = PageController();
    ShopCubit cubit = ShopCubit.get(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              child: const Text(
                'Skip',
                style: TextStyle(color: kOrangeMaterialColor),
              ),
              onPressed: () {
                cubit.navigateToLoginScreen(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView.builder(
            onPageChanged: (index) {
              if (index == cubit.onBoardingItems.length - 1)
                cubit.isLast = true;
              else
                cubit.isLast = false;
            },
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => BuildBoardingItem(
              size: size,
              index: index,
            ),
            itemCount: cubit.onBoardingItems.length,
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              SmoothPageIndicator(
                controller: pageController,
                count: cubit.onBoardingItems.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: kOrangeMaterialColor,
                ),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (cubit.isLast) {
                    cubit.navigateToLoginScreen(context);
                  } else {
                    pageController.nextPage(
                        duration: const Duration(microseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                },
                //TODO solve the instant transition when pressing the FloatingActionBotton
                child: const Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
    );
  }
}
