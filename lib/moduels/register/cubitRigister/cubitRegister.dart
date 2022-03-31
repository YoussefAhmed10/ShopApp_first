import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/RegisterModel/shopRegister.dart';
import 'package:shopapp/moduels/register/cubitRigister/statesRegister.dart';
import 'package:shopapp/shared/Network/endPoints.dart';
import 'package:shopapp/shared/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopInitialRegisterState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  late ShopRegisterModel registerModel;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ShopRigsterChangePasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(ShopLoadingRegisterState());
    DioHelper.postData(
      url: REIGSTER,
      data: {
        'name': email,
        'email': email,
        'phone': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      registerModel = ShopRegisterModel.fromJson(value.data);
      emit(ShopSucsessfulRegisterState(registerModel));
    }).catchError(
      (error) {
        print(error.toString());
        emit(
          ShopErrorRegisterState(
            error.toString(),
          ),
        );
      },
    );
  }
}
