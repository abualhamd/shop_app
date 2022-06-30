import 'package:flutter/material.dart';
import 'package:shop_app/shared/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shop_app/cubit/app_cubit/cubit.dart';
import 'package:shop_app/shared/constants.dart';
import '../helpers/cache_helper.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final PageController _pageController = PageController();
    AppCubit cubit = AppCubit.get(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              child: const Text(
                'Skip',
                // style: TextStyle(color: kOrangeMaterialColor),
              ),
              onPressed: () {
                CacheHelper.setBool(key: onBoarding, value: false).then((value) {
                  // print('setting onBoarding $value');
                  cubit.navigateToLoginScreen(context);
                })
                ;
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView.builder(
            onPageChanged: (index) {
              if (index == cubit.onBoardingItems.length - 1) {
                cubit.isLast = true;
              } else {
                cubit.isLast = false;
              }
            },
            controller: _pageController,
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
                controller: _pageController,
                count: cubit.onBoardingItems.length,
                effect: const ExpandingDotsEffect(
                    // activeDotColor: kOrangeMaterialColor,
                    ),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (cubit.isLast) {
                    CacheHelper.setBool(key: onBoarding, value: false)
                        .then((value) {
                      cubit.navigateToLoginScreen(context);
                    });
                  } else {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 850),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                },
                child: const Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
    );
  }
}
