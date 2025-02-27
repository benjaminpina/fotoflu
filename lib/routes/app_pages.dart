import 'package:fotoflu/bindings/home_binding.dart';
import 'package:fotoflu/bindings/opciones_binding.dart';
import 'package:fotoflu/routes/app_routes.dart';
import 'package:fotoflu/ui/pages/home_page.dart';
import 'package:fotoflu/ui/pages/opciones_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.opciones,
      page: () => OpcionesPage(),
      binding: OpcionesBinding(),
    ),
  ];
}
