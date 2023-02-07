// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/shared/bloc_observer.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:udemy_course/shared/networks/local/cache_helper.dart';
import 'package:udemy_course/shared/networks/remote/dio_helper.dart';
import 'package:udemy_course/shared/styles/themes.dart';
import 'layout/shop_app/cubit/shop_cubit.dart';
import 'layout/shop_app/cubit/shop_states.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/shop_app/login/shop_login_screen.dart';
import 'modules/shop_app/on_boarding/on_borading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;
  bool? onBoarding = CacheHelper.getData(key: "onBoarding");
  token = CacheHelper.getData(key: "token");
  uId = CacheHelper.getData(key: "uId");
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          bool isDark = CacheHelper.getData(key: 'isDark');
          return ShopCubit()
            ..changeAppMode(fromShared: isDark)
            ..getHomeData()
            ..getCategoriesData()
            ..getFavouritesData()
            ..getUserData();
        }),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            home: startWidget,
            themeMode: ShopCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
