import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/home_controller.dart';
import 'package:fotoflu/controllers/panel_lateral_controller.dart';
import 'package:get/get.dart';

class PanelLateral extends GetView<PanelLateralController> {
  const PanelLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Placeholder(
        child: Column(
          children: [
            SizedBox(width: double.infinity, height: 80, child: _Directorio()),
            Expanded(child: _Selecciones()),
            SizedBox(width: double.infinity, height: 190, child: _Acciones()),
            SizedBox(width: double.infinity, height: 100, child: _Botones()),
          ],
        ),
      ),
    );
  }
}

class _Botones extends StatelessWidget {
  const _Botones();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {},
          child: Row(children: [Icon(Icons.settings), Text('Opciones')]),
        ),
        Spacer(),
        ElevatedButton(
          onPressed: () {},
          child: Row(children: [Icon(Icons.cancel), Text('Cerrar')]),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}

class _Acciones extends StatelessWidget {
  const _Acciones();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.perm_media),
                Text('Crear estructura directorios'),
              ],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [Icon(Icons.move_down), Text('Distribuir raw y jpg')],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [Icon(Icons.view_carousel), Text('Explorar imágenes')],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [Icon(Icons.raw_on), Text('Exportar raw selectos')],
            ),
          ),
        ],
      ),
    );
  }
}

class _Selecciones extends StatelessWidget {
  const _Selecciones();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Placeholder(child: Text('Selecciones')),
    );
  }
}

class _Directorio extends StatelessWidget {
  _Directorio();

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: ElevatedButton(
        onPressed: () async {
          String? selectedDirectory =
              await FilePicker.platform.getDirectoryPath();
          if (selectedDirectory != null) {
            controller.directorio.value = selectedDirectory;
          }
        },
        child: Row(children: [Icon(Icons.folder), Text('Directorio')]),
      ),
    );
  }
}
