import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class StorageController extends GetxController {
  final storage = GetStorage();

  @override
  onInit() async {
    super.onInit();
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    storage.writeIfNull('dir', appDocumentsDir.path);
  }

  String get dir => storage.read('dir') ?? '';

  set dir(String value) => storage.write('dir', value);
}
