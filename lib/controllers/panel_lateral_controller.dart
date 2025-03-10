import 'package:flutter/material.dart';
import 'package:fotoflu/models/sesion.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:fotoflu/models/grupo.dart';
import "package:fotoflu/services/files.dart";
import 'package:fotoflu/controllers/storage_controller.dart';
import 'package:fotoflu/controllers/galeria_controller.dart';
import 'package:fotoflu/repositories/destino_repository.dart';
import 'package:fotoflu/repositories/sesion_repository.dart';
import 'package:fotoflu/repositories/foto_repository.dart';
import 'package:fotoflu/repositories/grupo_repository.dart';

class PanelLateralController extends GetxController {
  final storage = Get.find<StorageController>();
  final galeriaController = Get.find<GaleriaController>();
  final destinos = Get.find<DestinoRepository>();
  final sesiones = Get.find<SesionRepository>();
  final grupos = Get.find<GrupoRepository>();
  final fotos = Get.find<FotoRepository>();

  final dir = ''.obs;
  final progress = 0.0.obs;
  final counter = ''.obs;
  final archOrigen = ''.obs;
  final archDestino = ''.obs;
  final listaGrupos = <Grupo>[].obs;
  final cambioIdSelected = Rxn<int>();
  final selectedRow = Rxn<int>();
  final title = 'Copiando...'.obs;
  final filtrado = false.obs;
  final waiting = false.obs;

  @override
  void onInit() {
    super.onInit();
    dir.value = storage.dir;
    selectedRow.value = null;
    cambioIdSelected.value = null;

    // Actualizar id de grupo seleccionado al cambiar la fila seleccionada
    selectedRow.listen((value) {
      if (value != null) {
        cambioIdSelected.value = listaGrupos[value].id;
      } else {
        cambioIdSelected.value = null;
      }
    });
  }

  void setDir(String value) {
    dir.value = value;
    storage.dir = value;
    listaGrupos.clear();
    galeriaController.setImages([]);
  }

  void crearEstructura() async {
    final base = storage.dir;
    final List<String> dirs = [];

    for (final destino in destinos.destinos) {
      if (destino.nombre != null && destino.nombre!.isNotEmpty) {
        dirs.add(destino.nombre!);
      }
    }

    crearEstrcutura(base, dirs).then((value) async {
      if (value != null) {
        Get.snackbar('Error', value);
      } else {
        Get.snackbar('Info', 'Estructura de directorios creada');
      }
    });
  }

  Future<void> distribuirRawJpg(BuildContext context) async {
    final dirBase = storage.dir;
    final extRaw = storage.extRaw;

    final dirJpg = _getDirJpg();
    final dirRaw = _getDirRaw();

    final filesJpg = await filesByExt(dirBase, ['.jpg', '.jpeg']);
    final filesRaw = await filesByExt(dirBase, ['.$extRaw']);

    final filesJpgDest =
        filesJpg.map((f) => '$dirJpg/${p.basename(f)}').toList();
    final filesRawDest =
        filesRaw.map((f) => '$dirRaw/${p.basename(f)}').toList();

    title.value = 'Copiando archivos JPG...';
    progress.value = 0.0;
    for (var i = 0; i < filesJpg.length; i++) {
      final file = filesJpg[i];
      final dest = filesJpgDest[i];
      archOrigen.value = file;
      archDestino.value = dest;
      await copyFile(file, dest, preserveOriginal: false);
      counter.value = 'Copiando archivo ${i + 1} de ${filesJpg.length}';
      progress.value = (i + 1) / filesJpg.length;
    }

    title.value = 'Copiando archivos RAW...';
    progress.value = 0.0;
    for (var i = 0; i < filesRaw.length; i++) {
      final file = filesRaw[i];
      final dest = filesRawDest[i];
      archOrigen.value = file;
      archDestino.value = dest;
      await copyFile(file, dest, preserveOriginal: false);
      counter.value = 'Copiando archivo ${i + 1} de ${filesRaw.length}';
      progress.value = (i + 1) / filesRaw.length;
    }

    // Cerrar el diálogo que muestra el progreso
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    archDestino.value = '';
    archOrigen.value = '';
    title.value = '';
    progress.value = 0.0;
  }

  Future<void> explorarImagenes(BuildContext context) async {
    waiting.value = true;
    final extRaw = storage.extRaw;
    final dirJpg = _getDirJpg();
    final dirRaw = _getDirRaw();

    // ¿El directorio base existe?
    if (!await directoryExists(dir.value)) {
      Get.snackbar('Error', 'El directorio base no existe');
      return;
    }

    // ¿Ya se ha explorado este directorio?
    final sesion = await sesiones.getSesionByCarpeta(dir.value);
    if (sesion != null) {
      await _continuaSesion(sesion);
      waiting.value = false;
      return;
    }

    if (!await directoryExists(dirJpg)) {
      Get.snackbar('Error', 'El directorio de destino JPG no existe');
      return;
    }

    if (!await directoryExists(dirRaw)) {
      Get.snackbar('Error', 'El directorio de destino RAW no existe');
      return;
    }

    final filesJpg = await filesByExt(dirJpg, ['.jpg', '.jpeg']);
    final filesRaw = await filesByExt(dirRaw, ['.$extRaw']);

    // Verificar que existan archivos en los directorios
    if (filesJpg.isEmpty) {
      Get.snackbar('Error', 'No hay archivos JPG para explorar');
      return;
    }
    if (filesRaw.isEmpty) {
      Get.snackbar('Error', 'No hay archivos RAW seleccionables');
      return;
    }
    // Verificar paridad JPG/RAW
    if (filesJpg.length != filesRaw.length) {
      Get.snackbar(
        'Advertencia',
        'No hay paridad entre archivos JPG y RAW. Las imágenes sin archivo RAW no se mostrarán',
      );
    }
    await _iniciarSeleccion(filesJpg, filesRaw);
    waiting.value = false;
  }

  Future<void> _iniciarSeleccion(List<String> jpgs, List<String> raws) async {
    final seleccionables = <String>[];
    for (var i = 0; i < jpgs.length; i++) {
      final jpg = jpgs[i];
      final raw = raws.firstWhereOrNull(
        (r) => p.basenameWithoutExtension(r) == p.basenameWithoutExtension(jpg),
      );
      if (raw != null) {
        seleccionables.add(jpg);
      }
    }
    if (seleccionables.isEmpty) {
      Get.snackbar('Error', 'No hay imágenes seleccionables');
      return;
    }

    // Agregar sesión a BD
    final sesion = await sesiones.addSesion(dir.value);
    // Agregar fotos a BD
    for (final jpg in seleccionables) {
      fotos.addFoto(jpg, sesion);
    }
    // Agreagar un grupo inicial a BD
    await grupos.addGrupo('Cambio 1', sesion);
    final lista = await fotos.getFotosBySesionId(sesion.id);
    listaGrupos.value = await grupos.getGruposBySesionId(sesion.id);
    galeriaController.setImages(lista);
    selectedRow.value = 0;
  }

  Future<void> _continuaSesion(Sesion sesion) async {
    final lista = await fotos.getFotosBySesionId(sesion.id);
    listaGrupos.value = await grupos.getGruposBySesionId(sesion.id);
    galeriaController.setImages(lista);
    if (listaGrupos.isNotEmpty) {
      selectedRow.value = 0;
    } else {
      selectedRow.value = null;
    }
  }

  Future<void> filtrarPorGrupo(int id) async {
    filtrado.value = true;
    final lista = await fotos.getFotosByGrupoId(id);
    galeriaController.setImages(lista);
  }

  Future<void> eliminarFiltro() async {
    filtrado.value = false;
    final sesion = await sesiones.getSesionByCarpeta(dir.value);
    if (sesion != null) {
      final lista = await fotos.getFotosBySesionId(sesion.id);
      galeriaController.setImages(lista);
    }
  }

  void addGrupo(String nombre) async {
    final sesion = await sesiones.getSesionByCarpeta(dir.value);
    if (sesion != null) {
      await grupos.addGrupo(nombre, sesion);
      listaGrupos.value = await grupos.getGruposBySesionId(sesion.id);
    }
  }

  void updateGrupo(int id, String nombre) async {
    final sesion = await sesiones.getSesionByCarpeta(dir.value);
    if (sesion != null) {
      await grupos.updateGrupo(id, nombre);
      listaGrupos.value = await grupos.getGruposBySesionId(sesion.id);
    }
  }

  void removeGrupo(int id) async {
    final sesion = await sesiones.getSesionByCarpeta(dir.value);
    if (sesion != null) {
      await grupos.deleteGrupo(id);
      listaGrupos.value = await grupos.getGruposBySesionId(sesion.id);
    }
  }

  String _getDirJpg() {
    return '${storage.dir}/${destinos.destinos.firstWhereOrNull((d) => d.id == storage.destJpg)?.nombre ?? ''}';
  }

  String _getDirRaw() {
    return '${storage.dir}/${destinos.destinos.firstWhereOrNull((d) => d.id == storage.destRaw)?.nombre ?? ''}';
  }
}
