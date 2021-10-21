import 'package:flutter/material.dart';
import 'package:shopapp/models/onboardngmodel/bordingModel.dart';
import 'package:oktoast/oktoast.dart';

//BoardingModel
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

//TextFormField
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

//OKTOASTSHOW
void toastShow({
  required String text,
  required ToastState state,
}) {
  showToast(
    text,
    textAlign: TextAlign.center,
    duration: Duration(seconds: 2),
    position: ToastPosition.bottom,
    backgroundColor: chooseColorToast(state),
    radius: 15.0,
    textStyle: TextStyle(
      decoration: TextDecoration.none,
      fontSize: 15.0,
      color: Colors.white,
    ),
  );
}

enum ToastState { SUCSESS, ERROR, WARNING }

Color chooseColorToast(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCSESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
  }
  return color;
}

//NavigatorAndPushReplacment
navigateAndFinish(context, Widget screen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) {
        return screen;
      },
    ),
  );
}

//NavigatorTo
navigateTo(context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return screen;
      },
    ),
  );
}
