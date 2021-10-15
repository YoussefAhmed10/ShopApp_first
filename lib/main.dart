import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/layout/shoplayout.dart';
import 'package:shopapp/moduels/login/login_screen.dart';
import 'package:shopapp/moduels/on_bordingscree.dart';
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
  String? token = CacheHelper.getData(key: 'token');

  print(onBoarding);

  // ignore: unnecessary_null_comparison
  if (onBoarding != null) {
    // ignore: unnecessary_null_comparison
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
    return MaterialApp(
      title: 'shop App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: startwidget,
    );
  }
}
