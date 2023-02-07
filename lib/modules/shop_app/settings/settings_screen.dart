// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_cubit.dart';
import 'package:udemy_course/layout/shop_app/cubit/shop_states.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) {
              nameController.text =
                  ShopCubit.get(context).userModel!.data!.name!;
              emailController.text =
                  ShopCubit.get(context).userModel!.data!.email!;
              phoneController.text =
                  ShopCubit.get(context).userModel!.data!.phone!;
              return Scaffold(
                appBar: AppBar(
                  title: Text("Settings"),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if (state is ShopUpdateUserDataLoadingState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            onSubmit: () {},
                            onTab: () {},
                            onChanged: () {},
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "name must not be empty";
                              }
                            },
                            label: "Name",
                            prefix: Icons.person),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            onSubmit: () {},
                            onTab: () {},
                            onChanged: () {},
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "E-mail must not be empty";
                              }
                            },
                            label: "E-mail adress",
                            prefix: Icons.email),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            onSubmit: () {},
                            onTab: () {},
                            onChanged: () {},
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "phone must not be empty";
                              }
                            },
                            label: "phone",
                            prefix: Icons.phone),
                        SizedBox(
                          height: 40,
                        ),
                        defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text);
                              }
                            },
                            text: "update",
                            isUpperCase: true),
                        SizedBox(
                          height: 40,
                        ),
                        defaultButton(
                            function: () {
                              signout(context);
                            },
                            text: "Signout",
                            isUpperCase: true)
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
