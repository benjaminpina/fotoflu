import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fotoflu/models/destino.dart';

class IsarService {
  // Patrón Singleton
  static final IsarService _instance = IsarService._internal();
  late Isar isar;

  factory IsarService() {
    return _instance;
  }

  IsarService._internal();

  Future<void> init() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([DestinoSchema], directory: dir.path);
    } else {
      isar = Isar.getInstance()!;
    }
  }
}
