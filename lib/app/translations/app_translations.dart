import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'home_title': '首页',
          'login_title': '登录',
        },
        'en_US': {
          'home_title': 'Home',
          'login_title': 'Login',
        },
      };
}
