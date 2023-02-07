// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_app/shop_layout.dart';
import 'package:udemy_course/modules/shop_app/login/cubit/login_cubit.dart';
import 'package:udemy_course/modules/shop_app/login/cubit/login_states.dart';
import 'package:udemy_course/modules/shop_app/register/shop_register_screen.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/networks/local/cache_helper.dart';

import '../../../shared/components/constants.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) => {
          if (state is ShopLoginSuccessState)
            {
              if (state.loginModel.status!)
                {
                  CacheHelper.saveData(
                          key: "token", value: state.loginModel.data?.token)
                      .then((value) {
                    token = state.loginModel.data!.token;
                    navigateAndFinish(context, ShopLayout());
                  })
                }
              else
                {
                  showToast(
                    text: state.loginModel.message.toString(),
                    state: ToasStates.error,
                  ),
                }
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Login now to browse our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "Please enter your email adress";
                                }
                              },
                              onSubmit: () {},
                              onTab: () {},
                              onChanged: () {},
                              label: "E-mail adress",
                              prefix: Icons.email),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              isPassword:
                                  ShopLoginCubit.get(context).isPassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "Password is too short";
                                }
                              },
                              onSubmit: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              onTab: () {},
                              onChanged: () {},
                              label: "password",
                              prefix: Icons.lock),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: State is! ShopLoginLoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: "Login",
                                isUpperCase: true),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account ?"),
                              defaultTextButton(
                                  text: "register",
                                  onpressed: () {
                                    navigateTo(
                                      context,
                                      ShopRegisterScreen(),
                                    );
                                  })
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
