import 'package:udemy_course/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {

  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
  
}

class ShopLoginErrodState extends ShopLoginStates {

  final String error;

  ShopLoginErrodState(this.error);

}

class ShopLoginChangePasswordState extends ShopLoginStates {}
