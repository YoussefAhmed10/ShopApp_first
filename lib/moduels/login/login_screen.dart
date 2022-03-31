import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopapp/layout/shoplayout.dart';
import 'package:shopapp/moduels/login/cubitLogin/cubitLogin.dart';
import 'package:shopapp/moduels/login/cubitLogin/statesLogin.dart';
import 'package:shopapp/moduels/register/reigsterscreen.dart';
import 'package:shopapp/shared/local/componante.dart';
import 'package:shopapp/shared/local/constance.dart';
import 'package:shopapp/shared/remote/cache_helper.dart';

// ignore_for_file: must_be_immutable
class LogInScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLogInStates>(
        listener: (context, state) {
          if (state is ShopSucsessfulLoginState) {
            if (state.loginModel!.status!) {
              CacheHelper.saveDate(
                key: 'token',
                value: state.loginModel!.data!.token,
              ).then((value) {
                token = state.loginModel!.data!.token;
                navigateAndFinish(
                  context,
                  LayoutScreen(),
                );
              });
            } else {
              print(state.loginModel!.message);
              toastShow(
                text: '${state.loginModel!.message}',
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
                              'LOGIN',
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
                                height: 50,
                                child: Image.asset('assets/images/log.jpg'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          'LogIN To Our Services',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(height: 25.0),
                        //TextFormFieldForEmail
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
                        //TextFormFieldForPassword
                        defaultTextFormField(
                          isPassword:
                              ShopLoginCubit.get(context).isPasswordShow,
                          label: 'Password',
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
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
                                state is! ShopLoadingLoginState,
                            widgetBuilder: (context) => ElevatedButton(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
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
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an Account? ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
