import 'package:udemy_course/models/shop_app/cahnge_favourites_model.dart';
import 'package:udemy_course/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChnageBottomNavState extends ShopStates {}

class ShopGetHomeDataLoadingState extends ShopStates {}

class ShopGetHomeDataSuccessState extends ShopStates {}

class ShopGetHomeDataErrorState extends ShopStates {}

class ShopGetCategoriesDataSuccessState extends ShopStates {}

class ShopGetCategoriesDataErrorState extends ShopStates {}

class ShopChangeFavouritesState extends ShopStates {}

class ShopChangeFavouritesSuccessState extends ShopStates {
  final ChangeFavouritesmodel model;
  ShopChangeFavouritesSuccessState(this.model);
}

class ShopChangeFavouritesErrorState extends ShopStates {}

class ShopGetFavouritesDataLoadingState extends ShopStates {}

class ShopGetFavouritesDataSuccessState extends ShopStates {}

class ShopGetFavouritesDataErrorState extends ShopStates {}

class ShopGetUserDataLoadingState extends ShopStates {}

class ShopGetUserDataSuccessState extends ShopStates {
  final ShopLoginModel loginModel;
  ShopGetUserDataSuccessState(this.loginModel);
}

class ShopGetUserDataErrorState extends ShopStates {}

class ShopUpdateUserDataLoadingState extends ShopStates {}

class ShopUpdateUserDataSuccessState extends ShopStates {
  final ShopLoginModel loginModel;
  ShopUpdateUserDataSuccessState(this.loginModel);
}

class ShopUpdateUserDataErrorState extends ShopStates {}

