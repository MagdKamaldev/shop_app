// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_cubit.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_states.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Salla"),
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.chnageBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: "Categories",
                  icon: Icon(Icons.apps),
                ),
                BottomNavigationBarItem(
                  label: "Favourites",
                  icon: Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                  label: "Settings",
                  icon: Icon(Icons.settings),
                ),
              ]),
        );
      },
    );
  }
}
