import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fotoflu/routes/app_routes.dart';
import 'package:fotoflu/services/application.dart';
import 'package:get/get.dart';
import 'package:fotoflu/controllers/galeria_controller.dart';
import 'package:fotoflu/controllers/panel_lateral_controller.dart';

class PanelLateral extends GetView<PanelLateralController> {
  const PanelLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(width: double.infinity, height: 80, child: _Directorio()),
          Expanded(child: _Selecciones()),
          SizedBox(width: double.infinity, height: 190, child: _Acciones()),
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
                    child: DataTableExample(),
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
  _Directorio();

  final controller = Get.find<GaleriaController>();

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

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  static const int numItems = 20;
  int? selectedRowIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: const <DataColumn>[DataColumn(label: Text('Cambios'))],
        rows: List<DataRow>.generate(
          numItems,
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
            cells: <DataCell>[DataCell(Text('Row $index'))],
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
