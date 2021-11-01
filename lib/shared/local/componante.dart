import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/models/onboardngmodel/bordingModel.dart';

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
  TextStyle? labelStyle,
  required IconData prefix,
  IconData? suffix,
  dynamic suffixPressed,
  required InputBorder border,
  Function? onSubmit,
  Function? onChanged,
  bool isPassword = false,
  EdgeInsetsGeometry? padding,
}) {
  return TextFormField(
    controller: controller,
    onChanged: (onChanged) {},
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
  required ToastStates state,
  required BuildContext context,
}) {
  showAndroidToast(
    child: Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: 15.0,
        color: Colors.white,
      ),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: chooseColorToast(state),
    context: context,
  );
}

enum ToastStates { SUCSESS, ERROR, WARNING }

Color chooseColorToast(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCSESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
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

//MyDivider

Widget myDivider() {
  return Divider(thickness: 2);
}

Widget buildListProduct(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
                  height: 120,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      height: 1.1,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice!.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
                                  ? Colors.deepOrange
                                  : Colors.black45,
                          radius: 18,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
