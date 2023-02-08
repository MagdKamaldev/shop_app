// ignore_for_file: implementation_imports, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_cubit.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_states.dart';
import 'package:udemy_course/modules/checkout/checkout_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          condition: ShopCubit.get(context).getCartModel != null,
          builder: (context) => Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => buildCartItem(
                      ShopCubit.get(context)
                          .getCartModel!
                          .data!
                          .cartItems![index]
                          .product,
                      context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: ShopCubit.get(context)
                      .getCartModel!
                      .data!
                      .cartItems!
                      .length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultButton(
                    function: () {
                      navigateTo(context, const CheckOutScreen());
                    },
                    text: "proceed to checkout"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCartItem(model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image.toString()),
                    width: 120,
                    height: 120,
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: const Text(
                        "Discount",
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 14),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: defaultColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (model.discount != 0)
                          Text(
                            model.oldPrice.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).addToCart(model.id!);
                            showToast(
                                text: "deleted succefully",
                                state: ToasStates.succes);
                          },
                          icon: const CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.redAccent,
                            child: Icon(
                              Icons.delete,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
