import 'package:shopapp/moduels/login/login_screen.dart';
import 'package:shopapp/shared/local/componante.dart';
import 'package:shopapp/shared/remote/cache_helper.dart';

dynamic signOut(context) {
  CacheHelper.removeData(key: 'token').then(
    (value) {
      if (value) {
        navigateAndFinish(
          context,
          LogInScreen(),
        );
      }
    },
  );
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';
