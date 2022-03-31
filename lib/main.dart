import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/shoplayout.dart';
import 'package:shopapp/moduels/login/login_screen.dart';
import 'package:shopapp/moduels/on_bordingscree.dart';
import 'package:shopapp/shared/local/constance.dart';
import 'package:shopapp/shared/remote/bloc-observer.dart';
import 'package:shopapp/shared/remote/cache_helper.dart';
import 'package:shopapp/shared/remote/dio_helper.dart';
import 'style/theme/lightTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget screenST;

  late bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      screenST = LayoutScreen();
    } else {
      screenST = LogInScreen();
    }
  } else {
    screenST = OnBoardingScreen();
  }

  runApp(MyApp(
    startwidget: screenST,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;

  const MyApp({required this.startwidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUserData(),
      child: MaterialApp(
        title: 'shop App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startwidget,
      ),
    );
  }
}
