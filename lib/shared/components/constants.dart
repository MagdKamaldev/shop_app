//https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=361f03ef60814eeba9c3e5e791843cdd
//https://newsapi.org/v2/everything?q=tesla&apiKey=361f03ef60814eeba9c3e5e791843cdd
// ignore_for_file: avoid_print



import '../../modules/shop_app/login/shop_login_screen.dart';
import '../networks/local/cache_helper.dart';
import 'components.dart';



void signout(context) {
  CacheHelper.removeData(key: "token").then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

dynamic token = "";
dynamic uId = "";
