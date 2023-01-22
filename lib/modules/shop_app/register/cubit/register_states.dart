import 'package:udemy_course/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {

  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
  
}

class ShopRegisterErrodState extends ShopRegisterStates {

  final String error;

  ShopRegisterErrodState(this.error);

}

class ShopRegisterChangePasswordState extends ShopRegisterStates {}
