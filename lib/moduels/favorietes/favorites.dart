// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/shared/local/componante.dart';

class FavorietesScreen extends StatelessWidget {
  const FavorietesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ShopCubit.get(context).favoritesModel == null ||
                state is ShopErrorFavoritesState
            ? Center(
                child: Text(
                  'Please Enter Some Favorites',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Conditional.single(
                context: context,
                conditionBuilder: (context) =>
                    state is! ShopLoadingGetFavoritesState,
                widgetBuilder: (context) {
                  return ListView.separated(
                    itemBuilder: (context, index) => buildListProduct(
                      ShopCubit.get(context)
                          .favoritesModel!
                          .data
                          .data[index]
                          .product,
                      context,
                    ),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount:
                        ShopCubit.get(context).favoritesModel!.data.data.length,
                  );
                },
                fallbackBuilder: (context) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });
      },
    );
  }
}
