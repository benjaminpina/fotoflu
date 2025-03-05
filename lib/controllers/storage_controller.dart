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
  String get extRaw => storage.read('extRaw') ?? 'cr2';
  int get destJpg => storage.read('destJpg') ?? -1;
  int get destRaw => storage.read('destRaw') ?? -1;
  int get destSelect => storage.read('destSelect') ?? -1;

  set dir(String value) => storage.write('dir', value);
  set extRaw(String value) => storage.write('extRaw', value);
  set destJpg(int value) => storage.write('destJpg', value);
  set destRaw(int value) => storage.write('destRaw', value);
  set destSelect(int value) => storage.write('destSelect', value);

  Future<void> resetDir() async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    storage.write('dir', appDocumentsDir.path);
  }
}
