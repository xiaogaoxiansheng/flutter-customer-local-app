import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/change_language/bindings/change_language_binding.dart';
import '../modules/change_language/views/change_language_view.dart';
import '../modules/gallery/bindings/gallery_binding.dart';
import '../modules/gallery/views/gallery_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.changeLanguage;

  static final routes = [
    GetPage(
      name: _Paths.changeLanguage,
      page: () => const ChangeLanguageView(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.main,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.gallery,
      page: () => const GalleryView(),
      binding: GalleryBinding(),
    ),
  ];
}
