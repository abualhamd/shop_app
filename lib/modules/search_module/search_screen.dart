import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_module/cubit/search_cubit.dart';
import 'package:shop_app/modules/search_module/cubit/search_states.dart';
import '../../shared/components.dart';
import '../shop_module/shop_cubit/shop_cubit.dart';
import '../shop_module/shop_cubit/shop_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, shopState) {},
        builder: (context, shopState) {
          return BlocProvider(
            create: (context) => SearchCubit(),
            child: BlocConsumer<SearchCubit, SearchState>(
              listener: (context, state) {},
              builder: (context, state) {
                SearchCubit cubit = SearchCubit.get(context);

                return SafeArea(
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    body: Column(
                        children: [
                          // myTextFormField(
                          //     controller: cubit.searchController,
                          //     label: 'search',
                          //     icon: Icons.search_outlined),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: TextFormField(
                              controller: cubit.searchController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('search'),
                                prefixIcon: Icon(Icons.search_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'field can\'t be empty';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                cubit.searchProducts();
                              },
                            ),
                          ),
                          if (cubit.searchModel != null &&
                              cubit.searchModel!.status == true)
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    buildSearchComponent(
                                        index: index, context: context),
                                itemCount: cubit.searchModel!.products.length,
                              ),
                            )
                        ]),
                  ),
                );
              },
            ),
          );
        });
  }
}
