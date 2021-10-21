import 'package:flutter/material.dart';

class FavorietesScreen extends StatelessWidget {
  const FavorietesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favorietes Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
