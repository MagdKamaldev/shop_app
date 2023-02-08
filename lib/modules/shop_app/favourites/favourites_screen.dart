// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/shop_cubit.dart';
import '../../../layout/shop_app/cubit/shop_states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          condition: state is! ShopGetFavouritesDataLoadingState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavItem(
                ShopCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data[index]
                    .product!,
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
          ),
        );
      },
    );
  }
}

Widget buildFavItem(model, context) => Padding(
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
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "Discount",
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(
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
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: defaultColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavourites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: defaultColor,
                          child: Icon(
                            Icons.favorite_border_outlined,
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
