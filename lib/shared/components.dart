import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/app_cubit/cubit.dart';
import 'package:shop_app/shared/constants.dart';
import '../models/categories_model.dart';
import '../models/home_model.dart';
import '../modules/search_module/cubit/search_cubit.dart';
import '../modules/shop_module/shop_cubit/shop_cubit.dart';

//TODO turn the class into a function
class BoardingItem extends StatelessWidget {
  final Size size;
  final int index;

  const BoardingItem({Key? key, required this.size, required this.index})
      : super(key: key);

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

void showToast({required String message, Color color = Colors.red}) async {
  await Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
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

Widget buildGridItem(
        {required ProductModel model, required BuildContext context}) =>
    // if (model.discount > 0)
    Visibility(
      visible: model.discount > 0,
      replacement: GridImage(model: model),
      child: ClipRect(
        child: Banner(
          message: 'Discount',
          location: BannerLocation.topStart,
          child: GridImage(model: model),
        ),
      ),
    );

class GridImage extends StatelessWidget {
  const GridImage({super.key, required this.model});

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  style: kProductPriceStyle,
                ),
                const SizedBox(
                  width: 5,
                ),
                if (model.discount > 0)
                  Text(
                    model.oldPrice.round().toString(),
                    style: kProductOldPriceStyle,
                  ),
                const Spacer(),
                myFavoriteWidget(model: model, context: context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

CircleAvatar myFavoriteWidget(
    {required ProductModel model, required BuildContext context}) {
  ShopCubit cubit = ShopCubit.get(context);
  return CircleAvatar(
//TODO radius: 300,
    foregroundColor: Colors.white,
    backgroundColor: (cubit.favoriteModel!.data.contains(model.id))
        ? Colors.blue
        : Colors.grey,
    child: IconButton(
        onPressed: () {
          cubit.toggleFavorite(id: model.id);
        },
        icon: const Icon(Icons.favorite_border_outlined)),
  );
}
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

////////////////////////////////////////////////////////////////////////////////
//favorite screen components
Widget buildFavoriteItem({required int id, required BuildContext context}) {
  ShopCubit cubit = ShopCubit.get(context);
  late ProductModel favoriteItem; // = cubit.homeModel!.data!.products[0];

  //TODO perhaps remove this and just make a favorite list in the favorite_model
  for (var element in cubit.homeModel!.data!.products) {
    if (element.id == id) {
      favoriteItem = element;
    }
  }

  return Dismissible(
    key: Key(favoriteItem.id.toString()),
    onDismissed: (direction) {
      cubit.toggleFavorite(id: favoriteItem.id);
    },
    child: Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(favoriteItem.image),
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
              if (favoriteItem.discount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: const Text(
                    'Discount',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      favoriteItem.name,
                      maxLines: 2,
                      // softWrap: true,
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  // const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          favoriteItem.price.round().toString(),
                          style: kProductPriceStyle,
                        ),
                        const SizedBox(width: 20),
                        if (favoriteItem.discount > 0)
                          Text(
                            favoriteItem.oldPrice.round().toString(),
                            style: kProductOldPriceStyle,
                          ),

                        // const Spacer(),
                        // myFavoriteWidget(model: favoriteItem, context: context)
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
////////////////////////////////////////////////////////////////////////////////
// settings_screen components

Widget blueButton({required onPressed, required String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // side: BorderSide()
          ),
        ),
      ),
    ),
  );
}

Widget myTextFormField(
    {required TextEditingController controller,
    required String label,
    required IconData icon,
    dynamic onSubmitted}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
        prefixIcon: Icon(icon),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'field can\'t be empty';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        onSubmitted;
      },
    ),
  );
}
////////////////////////////////////////////////////////////////////////////////
//search_screen components

Widget buildSearchComponent(
    {required int index, required BuildContext context}) {
  SearchCubit cubit = SearchCubit.get(context);
  ProductModel searchItem = cubit.searchModel!.products[index];

  return Container(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(searchItem.image),
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
            //TODO resolve the discount and old price null error
            // if (favoriteItem.discount > 0)
            //   Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 5),
            //     color: Colors.red,
            //     child: const Text(
            //       'Discount',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    searchItem.name,
                    maxLines: 2,
                    // softWrap: true,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        searchItem.price.round().toString(),
                        style: kProductPriceStyle,
                      ),
                      const SizedBox(width: 20),
                      // if (searchItem.discount > 0)
                      //   Text(
                      //     searchItem.oldPrice.round().toString(),
                      //     style: kProductOldPriceStyle,
                      //   ),

                      const Spacer(),
                      myFavoriteWidget(model: searchItem, context: context)
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
