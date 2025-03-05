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
  int get extRaw => storage.read('extRaw') ?? 0;
  int get destJpg => storage.read('destJpg') ?? 0;
  int get destRaw => storage.read('destRaw') ?? 0;
  int get destSelect => storage.read('destSelect') ?? 0;

  set dir(String value) => storage.write('dir', value);
  set extRaw(int value) => storage.write('extRaw', value);
  set destJpg(int value) => storage.write('destJpg', value);
  set destRaw(int value) => storage.write('destRaw', value);
  set destSelect(int value) => storage.write('destSelect', value);

  Future<void> resetDir() async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    storage.write('dir', appDocumentsDir.path);
  }
}
