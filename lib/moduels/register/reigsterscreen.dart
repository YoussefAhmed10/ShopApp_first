import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopapp/layout/shoplayout.dart';
import 'package:shopapp/moduels/register/cubitRigister/cubitRegister.dart';
import 'package:shopapp/moduels/register/cubitRigister/statesRegister.dart';
import 'package:shopapp/shared/local/componante.dart';
import 'package:shopapp/shared/local/constance.dart';
import 'package:shopapp/shared/remote/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  // ignore_for_file: must_be_immutable
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopSucsessfulRegisterState) {
            if (state.registerModel!.status!) {
              CacheHelper.saveDate(
                key: 'token',
                value: state.registerModel!.data!.token,
              ).then((value) {
                token = state.registerModel!.data!.token;
                navigateAndFinish(
                  context,
                  LayoutScreen(),
                );
              });
            } else {
              print(state.registerModel!.message);
              toastShow(
                text: '${state.registerModel!.message}',
                state: ToastStates.ERROR,
                context: context,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Register',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                            ),
                            Spacer(),
                            Expanded(
                              child: Container(
                                width: 50,
                                height: 60,
                                child: Image.asset(
                                  'assets/images/reg.jpg',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          'SignUp To Our Services',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(height: 25.0),
                        //TextFormFieldForEmail
                        defaultTextFormField(
                          label: 'User Nmae',
                          controller: nameController,
                          type: TextInputType.name,
                          prefix: Icons.person,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Sorry ! , Name can't be empty, Enter your name ";
                            }
                          },
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: (20),
                            vertical: (25),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        defaultTextFormField(
                          label: 'Email adresse',
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          prefix: Icons.email_outlined,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Sorry ! , Email can't be empty, Enter your email ";
                            }
                          },
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: (20),
                            vertical: (25),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        //TextFormFieldForPhone
                        defaultTextFormField(
                          label: 'Phone',
                          controller: phoneController,
                          type: TextInputType.phone,
                          prefix: Icons.phone_iphone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return " Phone can't be empty ";
                            }
                          },
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: (20),
                            vertical: (25),
                          ),
                        ),

                        SizedBox(height: 25.0),
                        //TextFormFieldForPassword
                        defaultTextFormField(
                          isPassword:
                              ShopRegisterCubit.get(context).isPasswordShow,
                          label: 'Password',
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock_outline,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Sorry ! , Password is too short ";
                            }
                          },
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: (25),
                            vertical: (25),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        //Elvated Button
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: Conditional.single(
                            context: context,
                            conditionBuilder: (context) =>
                                state is! ShopLoadingRegisterState,
                            widgetBuilder: (context) => ElevatedButton(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                            fallbackBuilder: (BuildContext context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                    ),
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
