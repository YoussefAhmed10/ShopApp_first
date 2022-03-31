import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/LoginModel/shopLogIn.dart';
import 'package:shopapp/moduels/login/cubitLogin/statesLogin.dart';
import 'package:shopapp/shared/Network/endPoints.dart';
import 'package:shopapp/shared/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLogInStates> {
  ShopLoginCubit() : super(ShopInitialLoginState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  late ShopLoginModel loginModel;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoadingLoginState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSucsessfulLoginState(loginModel));
    }).catchError(
      (error) {
        print(error.toString());
        emit(
          ShopErrorLoginState(
            error.toString(),
          ),
        );
      },
    );
  }
}
