// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/modules/shop_app/register/cubit/register_states.dart';
import 'package:udemy_course/shared/networks/end_points.dart';
import 'package:udemy_course/shared/networks/remote/dio_helper.dart';
import '../../../../models/shop_app/login_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit()
      : super(
            ShopRegisterInitialState()); //3ashan fe constructor me7tag ya5od el initial state
  static ShopRegisterCubit get(context) =>
      BlocProvider.of(context); //3ashan a3raf a5od object men el cubit

  ShopLoginModel ? loginModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: register, data: {
      "email": email,
      "password": password,
      "name":name,
      "phone":phone,

    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrodState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordState());
  }
}
