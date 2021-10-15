import 'package:flutter/material.dart';
import 'package:shopapp/moduels/login/login_screen.dart';
import 'package:shopapp/shared/local/componante.dart';
import 'package:shopapp/shared/remote/cache_helper.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salla',
        ),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeData(key: 'token').then((value) {
            if (value) {
              navigateAndFinish(
                context,
                LogInScreen(),
              );
            }
          });
        },
        child: Text('Sign Out'),
      ),
    );
  }
}
