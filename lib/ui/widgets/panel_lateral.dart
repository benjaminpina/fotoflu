import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fotoflu/routes/app_routes.dart';
import 'package:fotoflu/services/application.dart';
import 'package:get/get.dart';
import 'package:fotoflu/controllers/panel_lateral_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PanelLateral extends GetView<PanelLateralController> {
  const PanelLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 80,
            child: _Directorio(controller),
          ),
          Expanded(child: _Grupos(controller)),
          SizedBox(
            width: double.infinity,
            height: 190,
            child: _Acciones(controller),
          ),
          SizedBox(width: double.infinity, height: 100, child: _Botones()),
        ],
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
          onPressed: () => Get.toNamed(AppRoutes.opciones),
          child: Row(children: [Icon(Icons.settings), Text('Opciones')]),
        ),
        Spacer(),
        ElevatedButton(
          onPressed:
              () => showDialog<String>(
                context: context,
                barrierDismissible:
                    false, // evitar que se cierre al tocar fuera
                builder:
                    (BuildContext context) => AlertDialog(
                      title: const Text('FotoFlu'),
                      content: const Text('¿Desea cerrar la aplicación?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            exitApp();
                          },
                          child: const Text('Sí'),
                        ),
                      ],
                    ),
              ),
          child: Row(children: [Icon(Icons.cancel), Text('Cerrar')]),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}

class _Acciones extends StatelessWidget {
  final PanelLateralController controller;

  const _Acciones(this.controller);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => controller.crearEstructura(),
            child: Row(
              children: [
                Icon(Icons.perm_media),
                Text('Crear estructura directorios'),
              ],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              controller.distribuirRawJpg(context);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Obx(() => Text(controller.title.value)),
                    content: SizedBox(
                      height: 100,
                      width: width * 0.5,
                      child: Column(
                        children: [
                          Obx(
                            () => Column(
                              children: [
                                LinearPercentIndicator(
                                  percent: controller.progress.value,
                                  lineHeight: 20,
                                  center: Text(
                                    "${(controller.progress.value * 100).toStringAsFixed(1)}%",
                                  ),
                                  progressColor: Colors.black,
                                ),
                                SizedBox(height: 10),
                                Text(controller.counter.value),
                                SizedBox(height: 5),
                                Text(controller.archOrigen.value),
                                SizedBox(height: 5),
                                Text(controller.archDestino.value),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Row(
              children: [Icon(Icons.move_down), Text('Distribuir raw y jpg')],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              controller.explorarImagenes(context);
            },
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

class _Grupos extends StatelessWidget {
  final PanelLateralController controller;
  const _Grupos(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cambio',
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    width: 215,
                    height: double.infinity,
                    child: DataTableGrupos(controller),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 40,
                    height: double.infinity,
                    child: Column(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.filter_alt),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [Text('Cambios:'), Text('0')]),
                Column(children: [Text('Seleccionadas:'), Text('0')]),
                Column(children: [Text('Para borrar:'), Text('0')]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Directorio extends StatelessWidget {
  final PanelLateralController controller;

  const _Directorio(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: ElevatedButton(
        onPressed: () async {
          String? selectedDirectory = await FilePicker.platform
              .getDirectoryPath(initialDirectory: controller.dir.value);
          if (selectedDirectory != null) {
            controller.setDir(selectedDirectory);
          }
        },
        child: Row(children: [Icon(Icons.folder), Text('Directorio')]),
      ),
    );
  }
}

class DataTableGrupos extends StatelessWidget {
  final PanelLateralController controller;

  const DataTableGrupos(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => DataTable(
          columns: const <DataColumn>[DataColumn(label: Text('Cambios'))],
          rows: List<DataRow>.generate(
            controller.listaGrupos.length,
            (int index) => DataRow(
              color: WidgetStateProperty.resolveWith<Color?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.08);
                }
                if (index.isEven) {
                  return Colors.grey.withValues(alpha: 0.3);
                }
                return null; // Use default value for other states and odd rows.
              }),
              cells: <DataCell>[
                DataCell(Text(controller.listaGrupos[index].nombre ?? "")),
              ],
              selected: controller.selectedRow.value == index,
              onSelectChanged: (bool? value) {
                if (value == true) {
                  controller.selectedRow.value = index;
                } else {
                  controller.selectedRow.value = null;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
