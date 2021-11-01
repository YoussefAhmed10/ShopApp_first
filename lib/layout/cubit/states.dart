import 'package:shopapp/models/ChangeFavoriteModel/changeFavoritesModel.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSucessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  String? error;
  ShopErrorHomeDataState(this.error);
}

class ShopSucessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {
  String? error;
  ShopErrorCategoriesDataState(this.error);
}

class ShopSucessChangeFavoritesColorDataState extends ShopStates {}

class ShopSucessChangeFavoritesDataState extends ShopStates {
  final ChangeFavoritesModel model;
  ShopSucessChangeFavoritesDataState(this.model);
}

class ShopErrorChangeFavoritesDataState extends ShopStates {
  String? error;
  ShopErrorChangeFavoritesDataState(this.error);
}

class ShopSucessFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopErrorFavoritesState extends ShopStates {
  dynamic error;
  ShopErrorFavoritesState(this.error);
}

class ShopSucessUserDataState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {
  dynamic error;
  ShopErrorUserDataState(this.error);
}

class ShopSucessUpdateUserState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates {
  dynamic error;
  ShopErrorUpdateUserState(this.error);
}
