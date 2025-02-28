import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fotoflu/controllers/opciones_controller.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class OpcionesPage extends GetView<OpcionesController> {
  const OpcionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FotoFlu - Opciones')),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _Directorios(controller: controller),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.blue,
            child: Text('Destinos'),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Spacer(),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Row(children: [Icon(Icons.arrow_back), Text('Regresar')]),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateDirs();
                Get.back();
              },
              child: Row(children: [Icon(Icons.check), Text('Aceptar')]),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class _Directorios extends StatelessWidget {
  const _Directorios({required this.controller});

  final OpcionesController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Center(child: Text('Estructura de Directorios')),
          ),
          Expanded(child: SizedBox(child: DataTableDirs(controller))),
          SizedBox(
            height: 80,
            child: Row(
              children: [
                IconButton(
                  onPressed:
                      controller.selectedRow.value != null
                          ? () async {
                            if (await confirm(
                              context,
                              title: Text('Eliminar Directorio'),
                              content: Text(
                                '¿Está seguro de eliminar el directorio seleccionado?',
                              ),
                            )) {
                              controller.removeDir(
                                controller.selectedRow.value!,
                              );
                            }
                          }
                          : null,
                  icon: Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () async {
                    controller.addDir(
                      await prompt(
                        context,
                        title: Text('Agregar Directorio'),
                        hintText: 'Directorio',
                        textOK: Text('Agregar'),
                        textCancel: Text('Cancelar'),
                        controller: TextEditingController(),
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DataTableDirs extends StatelessWidget {
  final OpcionesController controller;

  const DataTableDirs(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => DataTable(
          columns: const <DataColumn>[DataColumn(label: Text('Directorios'))],
          rows: List<DataRow>.generate(
            controller.dirs.length,
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
              cells: <DataCell>[DataCell(Text(controller.dirs[index]))],
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
