import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/categoriesModel/categoriesModel.dart';
import 'package:shopapp/models/homemodel/homemodel.dart';
import 'package:shopapp/moduels/cateogries/cateogries.dart';
import 'package:shopapp/moduels/favorietes/favorites.dart';
import 'package:shopapp/moduels/proudects/proucts.dart';

import 'package:shopapp/moduels/settings/settings.dart';
import 'package:shopapp/shared/Network/endPoints.dart';
import 'package:shopapp/shared/local/constance.dart';
import 'package:shopapp/shared/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<Widget> bottomSceerns = [
    ProductsScreen(),
    CateogriesScreen(),
    FavorietesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentindex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      print(homeModel!.status);
      emit(ShopSucessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSucessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }
}
