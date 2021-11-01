import 'package:shopapp/models/RegisterModel/shopRegister.dart';

abstract class ShopRegisterStates {}

class ShopInitialRegisterState extends ShopRegisterStates {}

class ShopLoadingRegisterState extends ShopRegisterStates {}

class ShopSucsessfulRegisterState extends ShopRegisterStates {
  final ShopRegisterModel? registerModel;

  ShopSucsessfulRegisterState(this.registerModel);
}

class ShopErrorRegisterState extends ShopRegisterStates {
  final String error;
  ShopErrorRegisterState(this.error);
}

class ShopRigsterChangePasswordVisibilityState extends ShopRegisterStates {}
