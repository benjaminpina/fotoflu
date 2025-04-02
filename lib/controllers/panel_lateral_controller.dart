import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:fotoflu/controllers/home_controller.dart';
import 'package:fotoflu/models/sesion.dart';
import 'package:fotoflu/models/grupo.dart';
import "package:fotoflu/services/files.dart";
import 'package:fotoflu/controllers/storage_controller.dart';
import 'package:fotoflu/controllers/galeria_controller.dart';
import 'package:fotoflu/controllers/panel_inferior_controller.dart';
import 'package:fotoflu/repositories/destino_repository.dart';
import 'package:fotoflu/repositories/sesion_repository.dart';
import 'package:fotoflu/repositories/foto_repository.dart';
import 'package:fotoflu/repositories/grupo_repository.dart';

class PanelLateralController extends GetxController {
  final storage = Get.find<StorageController>();
  final homeController = Get.find<HomeController>();
  final galeriaController = Get.find<GaleriaController>();
  final panelInferiorController = Get.find<PanelInferiorController>();
  final destinos = Get.find<DestinoRepository>();
  final sesiones = Get.find<SesionRepository>();
  final grupos = Get.find<GrupoRepository>();
  final fotos = Get.find<FotoRepository>();

  final dir = ''.obs;
  final sesionId = 0.obs;
  final progress = 0.0.obs;
  final counter = ''.obs;
  final archOrigen = ''.obs;
  final archDestino = ''.obs;
  final listaGrupos = <Grupo>[].obs;

  final selectedRow = Rxn<int>();
  final title = 'Copiando...'.obs;
  final filtrado = false.obs;
  final waiting = false.obs;

  @override
  void onInit() {
    super.onInit();
    dir.value = storage.dir;
    selectedRow.value = null;
    homeController.cambioIdSelected.value = null;

    // Actualizar id de grupo seleccionado al cambiar la fila seleccionada
    selectedRow.listen((value) {
      if (value != null) {
        homeController.cambioIdSelected.value = listaGrupos[value].id;
      } else {
        homeController.cambioIdSelected.value = null;
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

    title.value = 'Moviendo archivos JPG...';
    progress.value = 0.0;
    for (var i = 0; i < filesJpg.length; i++) {
      final file = filesJpg[i];
      final dest = filesJpgDest[i];
      archOrigen.value = file;
      archDestino.value = dest;
      await copyFile(file, dest, preserveOriginal: false);
      counter.value = 'Moviendo archivo ${i + 1} de ${filesJpg.length}';
      progress.value = (i + 1) / filesJpg.length;
    }

    title.value = 'Moviendo archivos RAW...';
    progress.value = 0.0;
    for (var i = 0; i < filesRaw.length; i++) {
      final file = filesRaw[i];
      final dest = filesRawDest[i];
      archOrigen.value = file;
      archDestino.value = dest;
      await copyFile(file, dest, preserveOriginal: false);
      counter.value = 'Moviendo archivo ${i + 1} de ${filesRaw.length}';
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
      sesionId.value = sesion.id;
      await _continuaSeleccion(sesion);
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
    sesionId.value = sesion.id;
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
    panelInferiorController.goToPage(0);
    updateStats();
    if (lista.isNotEmpty) {
      homeController.setAppState(AppState.explorando);
    } else {
      homeController.setAppState(AppState.sinImagenes);
    }
  }

  Future<void> _continuaSeleccion(Sesion sesion) async {
    final lista = await fotos.getFotosBySesionId(sesion.id);
    listaGrupos.value = await grupos.getGruposBySesionId(sesion.id);
    galeriaController.setImages(lista);
    if (listaGrupos.isNotEmpty) {
      selectedRow.value = 0;
    } else {
      selectedRow.value = null;
    }
    panelInferiorController.goToPage(0);
    updateStats();
    if (lista.isNotEmpty) {
      homeController.setAppState(AppState.explorando);
    } else {
      homeController.setAppState(AppState.sinImagenes);
    }
  }

  Future<void> filtrarPorGrupo(int id) async {
    filtrado.value = true;
    final lista = await fotos.getFotosByGrupoId(id);
    galeriaController.setImages(lista);
    panelInferiorController.goToPage(0);
    if (lista.isNotEmpty) {
      homeController.setAppState(AppState.explorando);
    } else {
      homeController.setAppState(AppState.sinImagenes);
    }
  }

  Future<void> eliminarFiltro() async {
    filtrado.value = false;
    final sesion = await sesiones.getSesionByCarpeta(dir.value);
    if (sesion != null) {
      final lista = await fotos.getFotosBySesionId(sesion.id);
      galeriaController.setImages(lista);
      panelInferiorController.goToPage(0);
      if (lista.isNotEmpty) {
        homeController.setAppState(AppState.explorando);
      } else {
        homeController.setAppState(AppState.sinImagenes);
      }
    }
  }

  void addGrupo(String nombre) async {
    final sesion = await sesiones.getSesionByCarpeta(dir.value);
    if (sesion != null) {
      await grupos.addGrupo(nombre, sesion);
      listaGrupos.value = await grupos.getGruposBySesionId(sesion.id);
      selectedRow.value = listaGrupos.length - 1;
    }
    updateStats();
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
    updateStats();
  }

  void updateStats() {
    homeController.contCambios.value = listaGrupos.length;
    homeController.contSeleccionadas.value =
        galeriaController.images
            .where((image) => image.grupo.value != null)
            .length;
    homeController.contParaBorrar.value =
        galeriaController.images.where((image) => image.paraBorrar).length;
    final conteos = <int, int>{};
    for (final image in galeriaController.images) {
      if (image.grupo.value != null) {
        conteos[image.grupo.value!.id] =
            (conteos[image.grupo.value!.id] ?? 0) + 1;
      }
    }
    homeController.contSelPorGrupo.value = conteos;
  }

  Future<void> exportarRawSelectos(BuildContext context) async {
    final extRaw = storage.extRaw;
    final dirRaw = _getDirRaw();
    final dirSelectos = _getDirSelectos();

    // Obtener lista de fotos marcadas para borrado
    final fotosParaBorrar = await fotos.getFotosParaBorrar(sesionId.value);
    // Generar lista de archivos JPG a borrar
    final archivosBorrar = fotosParaBorrar.map((f) => f.nombre).toList();
    // Agregar lista de archivos RAW a borrar
    final archivosRawBorrar =
        archivosBorrar
            .map((f) => '$dirRaw/${p.basenameWithoutExtension(f!)}.$extRaw')
            .toList();
    archivosBorrar.addAll(archivosRawBorrar);

    // eliminar fotos de la base de datos
    await fotos.borrarFotos(sesionId.value);

    // eliminar archivos marcados para borrar
    title.value = "Eliminando fotos marcadas para borrar...";
    progress.value = 0.0;
    for (var i = 0; i < archivosBorrar.length; i++) {
      final file = archivosBorrar[i];
      await deleteFile(file!);
      counter.value = 'Eliminando archivo ${i + 1} de ${archivosBorrar.length}';
      progress.value = (i + 1) / archivosBorrar.length;
    }

    // Obtener lista de fotos seleccionadas
    final fotosSelectas = await fotos.getFotosSeleccionadadas(sesionId.value);
    // Generar lista de archivos RAW seleccionados
    final archivosRawSelectos =
        fotosSelectas
            .map(
              (f) => '$dirRaw/${p.basenameWithoutExtension(f.nombre!)}.$extRaw',
            )
            .toList();

    title.value = 'Copiando archivos RAW seleccionados...';
    progress.value = 0.0;
    for (var i = 0; i < archivosRawSelectos.length; i++) {
      final file = archivosRawSelectos[i];
      final dest = '$dirSelectos/${p.basename(file)}';
      archOrigen.value = file;
      archDestino.value = dest;
      await copyFile(file, dest, preserveOriginal: true);
      counter.value =
          'Copiando archivo ${i + 1} de ${archivosRawSelectos.length}';
      progress.value = (i + 1) / archivosRawSelectos.length;
    }

    // Cerrar el diálogo que muestra el progreso
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    Get.snackbar(
      'Finalizado',
      'Los archivos RAW seleccionados han sido copiados',
    );

    archDestino.value = '';
    archOrigen.value = '';
    title.value = '';
    progress.value = 0.0;

    // Reiniciar selección
    final sesion = await sesiones.getSesionByCarpeta(dir.value);
    if (sesion != null) {
      _continuaSeleccion(sesion);
    }
  }

  String _getDirJpg() {
    return '${storage.dir}/${destinos.destinos.firstWhereOrNull((d) => d.id == storage.destJpg)?.nombre ?? ''}';
  }

  String _getDirRaw() {
    return '${storage.dir}/${destinos.destinos.firstWhereOrNull((d) => d.id == storage.destRaw)?.nombre ?? ''}';
  }

  String _getDirSelectos() {
    return '${storage.dir}/${destinos.destinos.firstWhereOrNull((d) => d.id == storage.destSelect)?.nombre ?? ''}';
  }
}
