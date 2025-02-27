import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fotoflu/controllers/opciones_controller.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:fotoflu/controllers/storage_controller.dart';

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
          Expanded(child: SizedBox(child: DataTableDirs())),
          SizedBox(
            height: 80,
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                IconButton(
                  onPressed: () async {
                    await prompt(context);
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

class DataTableDirs extends StatefulWidget {
  const DataTableDirs({super.key});

  @override
  State<DataTableDirs> createState() => _DataTableDirsState();
}

class _DataTableDirsState extends State<DataTableDirs> {
  List<String> dirs = Get.find<StorageController>().dirs;
  int? selectedRowIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: const <DataColumn>[DataColumn(label: Text('Directorios'))],
        rows: List<DataRow>.generate(
          dirs.length,
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
            cells: <DataCell>[DataCell(Text(dirs[index]))],
            selected: selectedRowIndex == index,
            onSelectChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selectedRowIndex = index;
                } else {
                  selectedRowIndex = null;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
