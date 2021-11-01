import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/shared/local/componante.dart';
import 'package:shopapp/shared/local/constance.dart';

var formkey = GlobalKey<FormState>();
var namecontroller = TextEditingController();
var emailcontroller = TextEditingController();
var phonecontroller = TextEditingController();

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        namecontroller.text = model!.data!.name!;
        emailcontroller.text = model.data!.email!;
        phonecontroller.text = model.data!.phone!;
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              ShopCubit.get(context).userModel != null,
          widgetBuilder: (contxt) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: namecontroller,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name must nbe not empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    prefix: Icons.person,
                    border: OutlineInputBorder(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: emailcontroller,
                    type: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Email must nbe not empty';
                      }
                      return null;
                    },
                    label: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    prefix: Icons.email,
                    border: OutlineInputBorder(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: phonecontroller,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Phone must nbe not empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    prefix: Icons.phone_iphone,
                    border: OutlineInputBorder(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: namecontroller.text,
                            email: emailcontroller.text,
                            phone: phonecontroller.text,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        'LOGOUT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        signOut(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallbackBuilder: (context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
