import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fotoflu/ui/theme/util.dart';
import 'package:fotoflu/ui/theme/theme.dart';
import 'package:fotoflu/routes/app_routes.dart';
import 'package:fotoflu/routes/app_pages.dart';
import 'package:fotoflu/db/isar_service.dart';
import 'package:fotoflu/controllers/storage_controller.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService().init();
  await GetStorage.init();
  Get.put(StorageController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "ABeeZee", "ABeeZee");
    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      title: 'FotoFlu',
      navigatorKey: Get.key,
      getPages: AppPages.pages,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      initialRoute: AppRoutes.home,
    );
  }
}
