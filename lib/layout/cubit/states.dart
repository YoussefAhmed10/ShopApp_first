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
