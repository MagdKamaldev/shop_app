// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/models/shop_app/login_model.dart';
import 'package:udemy_course/modules/shop_app/login/cubit/login_states.dart';
import 'package:udemy_course/shared/networks/end_points.dart';
import 'package:udemy_course/shared/networks/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit()
      : super(
            ShopLoginInitialState()); //3ashan fe constructor me7tag ya5od el initial state
  static ShopLoginCubit get(context) =>
      BlocProvider.of(context); //3ashan a3raf a5od object men el cubit

  ShopLoginModel ? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: login, data: {
      "email": email,
      "password": password,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrodState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordState());
  }
}
