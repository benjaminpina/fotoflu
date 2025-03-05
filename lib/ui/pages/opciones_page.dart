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
        children: [_Directorios(controller), _Destinos(controller)],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Spacer(),
            ElevatedButton(
              onPressed: () {
                controller.updateStorage();
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

class _Destinos extends StatelessWidget {
  final OpcionesController controller;

  const _Destinos(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.blue,
      child: Column(
        children: [
          Text('Destinos'),
          SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: TextField(
              controller: controller.extRawController,
              decoration: InputDecoration(
                labelText: 'Extensión de Archivos Raw',
                hintText: 'raw',
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Destino de Archivos JPG'),
          SizedBox(
            height: 300,
            child: Obx(
              () => DropdownButton<int>(
                value: controller.selDestinoJPG.value,
                items: controller.opcionesDestino,
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    controller.selDestinoJPG.value = newValue;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Directorios extends StatelessWidget {
  const _Directorios(this.controller);

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
                Obx(
                  () => IconButton(
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
                ),
                IconButton(
                  onPressed: () async {
                    final dir = await prompt(
                      context,
                      title: Text('Agregar Directorio'),
                      hintText: 'Directorio',
                      textOK: Text('Agregar'),
                      textCancel: Text('Cancelar'),
                      controller: TextEditingController(),
                    );
                    if (dir != null) {
                      controller.addDir(dir);
                    }
                  },
                  icon: Icon(Icons.add),
                ),
                Obx(
                  () => IconButton(
                    onPressed:
                        controller.selectedRow.value != null
                            ? () async {
                              final dir = await prompt(
                                context,
                                title: Text('Editar Directorio'),
                                hintText: 'Directorio',
                                textOK: Text('Guardar'),
                                textCancel: Text('Cancelar'),
                                controller: TextEditingController(
                                  text:
                                      controller.dirs[controller
                                          .selectedRow
                                          .value!],
                                ),
                              );
                              if (dir != null) {
                                controller.updateDir(
                                  controller.selectedRow.value!,
                                  dir,
                                );
                              }
                            }
                            : null,
                    icon: Icon(Icons.edit),
                  ),
                ),
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
              color: MaterialStateProperty.resolveWith<Color?>((
                Set<MaterialState> states,
              ) {
                if (states.contains(MaterialState.selected)) {
                  return Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.08);
                }
                if (index.isEven) {
                  return Colors.grey.withOpacity(0.3);
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
