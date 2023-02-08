import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_cubit.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_states.dart';
import 'package:udemy_course/models/shop_app/get_cart_model.dart';
import 'package:udemy_course/shared/components/components.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var textStyle = Theme.of(context).textTheme.titleMedium!;
        GetCartModel model = ShopCubit.get(context).getCartModel!;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Checkout"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "total items :",
                    style: textStyle.copyWith(fontSize: 22),
                  ),
                  Text(
                    model.data!.cartItems!.length.toString(),
                    style: textStyle.copyWith(fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              defaultDivider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "total price :",
                    style: textStyle.copyWith(fontSize: 22),
                  ),
                  Text(
                    "${model.data!.total.toString()} L.E.",
                    style: textStyle.copyWith(fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              defaultDivider(),
              const SizedBox(
                height: 20,
              ),
              defaultButton(function: () {}, text: "Proceed to Payment"),
            ]),
          ),
        );
      },
    );
  }
}
