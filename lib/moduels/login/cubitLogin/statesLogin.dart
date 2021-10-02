import 'package:shopapp/models/LoginModel/shopLogIn.dart';

abstract class ShopLogInStates {}

class ShopInitialLoginState extends ShopLogInStates {}

class ShopLoadingLoginState extends ShopLogInStates {}

class ShopSucsessfulLoginState extends ShopLogInStates {
  final ShopLoginModel? loginModel;

  ShopSucsessfulLoginState(this.loginModel);
}

class ShopErrorLoginState extends ShopLogInStates {
  final String error;
  ShopErrorLoginState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLogInStates {}
