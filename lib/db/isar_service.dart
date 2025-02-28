import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import "package:fotoflu/models/destino.dart";

class IsarService {
  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([DestinoSchema], directory: dir.path);
  }
}
