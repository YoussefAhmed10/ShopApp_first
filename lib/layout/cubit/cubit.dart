import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/ChangeFavoriteModel/changeFavoritesModel.dart';
import 'package:shopapp/models/LoginModel/shopLogIn.dart';
import 'package:shopapp/models/categoriesModel/categoriesModel.dart';
import 'package:shopapp/models/favoritesModel/favoritesModel.dart';
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

  Map<int?, bool?> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.status);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll(
          {element.id: element.inFavorites},
        );
      });
      print(favorites.toString());
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

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopSucessChangeFavoritesColorDataState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSucessChangeFavoritesDataState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      if (changeFavoritesModel == null) {
        print('${int.parse('Enter', radix: 1)}');
      }
      emit(ShopErrorChangeFavoritesDataState(error));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSucessFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoritesState(error));
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token!,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name!);
      emit(ShopSucessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState(error));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.updateData(
      url: UPDATEPROFILE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token!,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSucessUpdateUserState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState(error));
    });
  }
}
