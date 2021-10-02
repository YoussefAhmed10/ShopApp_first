import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/moduels/on_bordingscree.dart';
import 'package:shopapp/shared/remote/bloc-observer.dart';
import 'package:shopapp/shared/remote/dio_helper.dart';
import 'style/theme/lightTheme.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shop App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: OnBoardingScreen(),
    );
  }
}
