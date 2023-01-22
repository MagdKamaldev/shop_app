// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_states.dart';
import 'package:udemy_course/models/shop_app/categories_model.dart';
import 'package:udemy_course/models/shop_app/cahnge_favourites_model.dart';
import 'package:udemy_course/models/shop_app/home_model.dart';
import 'package:udemy_course/modules/shop_app/categories/categories_screen.dart';
import 'package:udemy_course/modules/shop_app/favourites/favourites_screen.dart';
import 'package:udemy_course/modules/shop_app/products/products_screen.dart';
import 'package:udemy_course/modules/shop_app/settings/settings_screen.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:udemy_course/shared/networks/remote/dio_helper.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../shared/networks/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  void chnageBottom(int index) {
    currentIndex = index;
    emit(ShopChnageBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopGetHomeDataLoadingState());

    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favourites.addAll({
          element.id!: element.inFavourites!,
        });
      });
      emit(ShopGetHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetHomeDataErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: getCategories,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopGetCategoriesDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetCategoriesDataErrorState());
    });
  }

  ChangeFavouritesmodel? changeFavouritesmodel;

  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavouritesState());
    DioHelper.postData(
      url: favourite,
      data: {"product_id": productId},
      authorization: token,
    ).then((value) {
      changeFavouritesmodel = ChangeFavouritesmodel.fromJson(value.data);
      if (!changeFavouritesmodel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavouritesData();
      }
      emit(ShopChangeFavouritesSuccessState(changeFavouritesmodel!));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopChangeFavouritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavouritesData() {
    emit(ShopGetFavouritesDataLoadingState());
    DioHelper.getData(url: favourite, authorization: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopGetFavouritesDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavouritesDataErrorState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(url: profile, authorization: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopGetUserDataSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetUserDataErrorState());
    });
  }

   void updateUserData({
    required String name,
    required String phone,
    required String email,
   }) {
    emit(ShopUpdateUserDataLoadingState());
    DioHelper.putData(
      url: updateProfile,
       authorization: token,
       data: {
       "name":name,
       "email":email,
       "phone":phone,       }
       ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopUpdateUserDataSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateUserDataErrorState());
    });
  }
}
