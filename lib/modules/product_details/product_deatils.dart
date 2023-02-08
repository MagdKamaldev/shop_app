// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_cubit.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_states.dart';
import 'package:udemy_course/shared/components/components.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int index;
  const ProductDetailsScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).homeModel!.data!.products[index];
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.network(model.image!),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  model.name!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 22),
                ),
                const SizedBox(
                  height: 25,
                ),
                defaultDivider(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price   :",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18),
                      ),
                      Text(
                        "${model.price.toString()}  L.E.",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultDivider(),
                const SizedBox(
                  height: 25,
                ),
                defaultButton(
                    function: () {
                      ShopCubit.get(context).addToCart(model.id!);
                    },
                    text: "add To cart",
                    height: 50),
              ],
            ),
          ),
        );
      },
    );
  }
}
