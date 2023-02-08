// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_cubit.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_states.dart';
import 'package:udemy_course/modules/shop_app/settings/settings_screen.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:udemy_course/shared/styles/colors.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        return Drawer(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  model!.data!.name!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  model.data!.email!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                defaultDivider(),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  color: Colors.blueGrey,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Dark Mode",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(height: 1.4, color: Colors.white),
                        ),
                        Switch(
                            value: ShopCubit.get(context).isDark,
                            onChanged: (value) {
                              ShopCubit.get(context).changeAppMode();
                            }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  color: Colors.blueGrey,
                  child: MaterialButton(
                    onPressed: () {
                      navigateTo(context, SettingsScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Settings",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(height: 1.4, color: Colors.white),
                        ),
                        const Icon(
                          Icons.settings,
                          color: defaultColor,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  color: Colors.blueGrey,
                  child: MaterialButton(
                    onPressed: () {
                      signout(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Sign Out",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(height: 1.4, color: Colors.white),
                        ),
                        const Icon(
                          Icons.logout,
                          color: defaultColor,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
