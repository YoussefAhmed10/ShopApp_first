import 'package:flutter/material.dart';
import 'package:shopapp/models/bordingModel.dart';

Widget buildOnBoardingItem(BoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        '${model.title}',
        style: TextStyle(fontSize: 24, fontFamily: 'Roboto'),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      SizedBox(height: 40),
    ],
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required TextStyle labelStyle,
  required IconData prefix,
  IconData? suffix,
  dynamic suffixPressed,
  required InputBorder border,
  Function? onSubmit,
  bool isPassword = false,
  EdgeInsetsGeometry? padding,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    validator: (validate) {},
    onFieldSubmitted: (onSubmit) {},
    obscureText: isPassword,
    decoration: InputDecoration(
      contentPadding: padding,
      labelStyle: labelStyle,
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: GestureDetector(
        onTap: suffixPressed,
        child: Icon(suffix),
      ),
      border: border,
    ),
  );
}
